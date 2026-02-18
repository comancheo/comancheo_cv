import 'dart:convert';

import 'package:comancheo_cv/cubits/base_cubits.dart';
import 'package:comancheo_cv/models/chat_message.dart';
import 'package:comancheo_cv/services/connection.dart';
import 'package:comancheo_cv/services/firebase_messaging.dart';
import 'package:comancheo_cv/services/local_storage.dart';
import 'package:comancheo_cv/utils/globals.dart' as globals;
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:uuid/uuid.dart';
import 'package:http/http.dart' as http;

class ChatService {
  static String apiUrl = 'https://cv.comancheo.cz/api/';
  static Map<String, String> headers = {
  'Content-Type': 'application/json',
  'Accept': 'application/json',
};
  final ConnectionService connectionService = GetIt.instance.get<ConnectionService>();
  final LocalStorageService localStorageService = GetIt.instance<LocalStorageService>();
  final FirebaseService firebaseService = GetIt.instance.get<FirebaseService>();
  final Uuid _uuid = Uuid();
  final ListCubit<ChatMessage> messages = ListCubit<ChatMessage>([]);
  final NullStringCubit email = NullStringCubit();
  final BoolCubit verified = BoolCubit(false);
  final NullStringCubit deviceUUID = NullStringCubit();
  final NullStringCubit token = NullStringCubit(); //= '\$2y\$12\$gHpxl8sHMsNaH9IF0aTaH.ukhN/vpD6PVAz5HpuueOutL3n8kjmB6';
  int? id;

  final TextEditingController messageController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController codeFromEmailController = TextEditingController();



  Future<ChatService> init() async {
    // Initialize any resources or connections needed for the chat service
    await Future.delayed(Duration(seconds: 1)); // Simulate initialization delay
    await loadDeviceUUID(); // Load or generate device UUID
    await loadUserCredentials(); // Load user credentials if available
    await receiveMessages();
    return this;
  }

  Future<void> initFcmListener() async {
    firebaseService.fcm!.stream.listen((newToken) async {
      debugPrint('ChatService received new FCM token: $newToken');
      await updateFCMToken(newToken);
    });
  }
  Future<void> sendPushToAll() async {
    final data = await _doPost({'event': 'sendPush'});
    if (data == null) {
      return;
    }
    dynamic response = json.decode(data.body);
    if(response['state'] == 'error'){
      ScaffoldMessenger.of(globals.appRouter.navigatorKey.currentContext!).showSnackBar(
        SnackBar(content: Text(response['message'])),
      );
      return;
    }
  }

  Future<void> createUser() async {
    email.set(emailController.text);
    final data = await _doPost({'event': 'createUser', 'email': email.state, 'fcm': firebaseService.fcm!.state, 'uuid': deviceUUID.state});
    if (data == null) {
      return;
    }
    dynamic response = json.decode(data.body);
    if(response['state'] == 'error'){
      ScaffoldMessenger.of(globals.appRouter.navigatorKey.currentContext!).showSnackBar(
        SnackBar(content: Text(response['message'])),
      );
      return;
    }
    debugPrint('Create user response: ${response['data']['token']}');
    if(response['state'] == 'success' && response['data']!= null && response['data']['token'] != null){
      email.set(response['data']['email']);
      verified.set(response['data']['verified']>0);
      deviceUUID.set(response['data']['uuid']);
      token.set(response['data']['token']);
      await storeUserCredentials();
    }
    debugPrint('Create user response: ${data.body}');
  }

  Future<void> resendEmailCode() async {
    final data = await _doPost({'event': 'resendEmailCode', 'email': email.state});
    if (data == null) {
      return;
    }
    dynamic response = json.decode(data.body);
    if(response['state'] == 'error'){
      ScaffoldMessenger.of(globals.appRouter.navigatorKey.currentContext!).showSnackBar(
        SnackBar(content: Text(response['message'])),
      );
      return;
    }
    if(response['state'] == 'success'){
      ScaffoldMessenger.of(globals.appRouter.navigatorKey.currentContext!).showSnackBar(
        SnackBar(content: Text('Kód byl znovu odeslán na email ${email.state}')),
      );
    }
  }

  Future<void> sendMessage(String message) async {
    final data = await _doPost({'event': 'createMessage', 'message': message});
    if (data == null) {
      return;
    }
    dynamic response = json.decode(data.body);
    if(response['state'] == 'error'){
      ScaffoldMessenger.of(globals.appRouter.navigatorKey.currentContext!).showSnackBar(
        SnackBar(content: Text(response['message'])),
      );
      return;
    }
    if(response['state'] == 'success' && response['data']!= null && response['data'].isNotEmpty){
      for(var message in response['data']){
        messages.updateDiff([ChatMessage.fromJson(message)]);
      }
    }
  }

  Future<void> receiveMessages() async {
    final data = await _doPost({'event': 'getMessages'});
    if (data == null) {
      return;
    }
    dynamic response = json.decode(data.body);
    if(response['state'] == 'error'){
      ScaffoldMessenger.of(globals.appRouter.navigatorKey.currentContext!).showSnackBar(
        SnackBar(content: Text(response['message'])),
      );
    }
    if(response['state'] == 'success' && response['data']!= null){
      for(var message in response['data']){
        messages.updateDiff([ChatMessage.fromJson(message)]);
      }
    }
  }

  Future<void> updateFCMToken(String? newToken) async {
    if(token.state == null || deviceUUID.state == null || newToken == null){
      return;
    }
    final data = await _doPost({'event': 'updateFcm', 'fcm': newToken});
    if (data == null) {
      return;
    }
    if(json.decode(data.body)['state'] == 'error'){
      ScaffoldMessenger.of(globals.appRouter.navigatorKey.currentContext!).showSnackBar(
        SnackBar(content: Text(json.decode(data.body)['message'])),
      );
    }
  }

  Future<void> loadDeviceUUID() async {
    var storedUUID = localStorageService.getData(StorageKeys.deviceUUID);
    if (storedUUID != null) {
      deviceUUID.set(storedUUID);
      return;
    }

    deviceUUID.set(_uuid.v4()); // Example UUID
    localStorageService.saveData(StorageKeys.deviceUUID, deviceUUID.state);
  }

  Future<void> loadUserCredentials() async {
    var storedCredentials = localStorageService.getData(StorageKeys.userCredentials);
    debugPrint('Loaded user credentials: $storedCredentials');
    if (storedCredentials != null) {
      id = storedCredentials['id'];
      deviceUUID.set(storedCredentials['uuid']);
      token.set(storedCredentials['token']);
      email.set(storedCredentials['email']);
      verified.set(storedCredentials['verified']);
    }
    await loadUserCredentialsFromServer();
  }

  //reload data from server to update credentials (e.g. after email verification)
  Future<void> loadUserCredentialsFromServer() async {
      final data = await _doPost({'event': 'getUser'});
      if (data == null) {
        return;
      }
      dynamic response = json.decode(data.body);
      if(response['state'] == 'error'){
        if(response['message'] == 'User not found.'){
          id = null;
          token.set(null);
          email.set(null);
          verified.set(false);
          await storeUserCredentials();
        }
        ScaffoldMessenger.of(globals.appRouter.navigatorKey.currentContext!).showSnackBar(
          SnackBar(content: Text(response['message'])),
        );
        return;
      }
      if(response['state'] == 'success'){
        id = response['data']['id'];
        deviceUUID.set(response['data']['uuid']);
        token.set(response['data']['token']);
        email.set(response['data']['email']);
        verified.set(response['data']['verified']>0);
        await storeUserCredentials();
      }
  }

  Future<void> storeUserCredentials() async {
    localStorageService.saveData(StorageKeys.userCredentials, {'uuid': deviceUUID.state, 'token': token.state,'email': email.state, 'verified': verified.state, 'id': id});
  }

  Future<void> verifyEmail() async {
    final data = await _doPost({'event': 'verifyEmailByCode', 'emailCode': codeFromEmailController.text});
    if (data == null) {
      return;
    }
    dynamic response = json.decode(data.body);
    if(response['state'] == 'error'){
      ScaffoldMessenger.of(globals.appRouter.navigatorKey.currentContext!).showSnackBar(
        SnackBar(content: Text(response['message'])),
      );
      return;
    }
    if(response['state'] == 'success' && response['data']!= null){
      token.set(response['data']['token']);
      await storeUserCredentials();
      await loadUserCredentialsFromServer();
    }
  }

  Future<void> deleteAllData() async {
    // Simulate deleting all chat data
    await Future.delayed(Duration(seconds: 1)); // Simulate deletion delay
    email.set(null);
    verified.set(false);
    deviceUUID.set(null);
  }

  Future<http.Response?> _doPost(Map<String, dynamic> body) async {
    if (!connectionService.isConnectedCubit.state) {
      return null;
    }
    if(token.state != null){
      body['token'] = token.state;
    }
    final http.Response response = await http.post(Uri.parse(apiUrl), headers: headers, body: json.encode(body));
    debugPrint('API response: ${response.request} - ${response.statusCode} - ${response.body}');
    return response;
  }
}
