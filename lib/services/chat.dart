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
  static String apiUrl = 'https://www.tabor-belun.cz/xmasgame/api.php';
  static Map<String, String> headers = {
  'Content-Type': 'application/json',
  'Accept': 'application/json',
};
  final ConnectionService connectionService = GetIt.instance.get<ConnectionService>();
  final LocalStorageService localStorageService = GetIt.instance<LocalStorageService>();
  final FirebaseService firebaseService = GetIt.instance.get<FirebaseService>();
  final Uuid _uuid = Uuid();
  final ListCubit<ChatMessage> messages = ListCubit<ChatMessage>([]);
  String? email;
  bool verified = false;
  String? deviceUUID;
  String? token; //= '\$2y\$12\$gHpxl8sHMsNaH9IF0aTaH.ukhN/vpD6PVAz5HpuueOutL3n8kjmB6';
  String? id;

  final TextEditingController messageController = TextEditingController();



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
      token = newToken;
      await updateFCMToken(newToken);
    });
  }
  Future<void> sendPushToAll() async {
    final data = await doPost({'event': 'sendPush'});
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
    debugPrint('Send push response: ${data.body}');
  }

  Future<void> createUser() async {
    final data = await doPost({'event': 'createUser', 'email': email, 'fcm': firebaseService.fcm!.state, 'uuid': deviceUUID});
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
      email = response['data']['email'];
      verified = response['data']['verified']>0;
      deviceUUID = response['data']['uuid'];
      token = response['data']['token'];
      await storeUserCredentials();
    }
    debugPrint('Create user response: ${data.body}');
  }

  Future<void> sendMessage(String message) async {
    final data = await doPost({'event': 'createMessage', 'message': message});
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
    debugPrint('Create message response: ${data.body}');
  }

  Future<void> receiveMessages() async {
    final data = await doPost({'event': 'getMessages'});
    if (data == null) {
      return;
    }
    dynamic response = json.decode(data.body);
    if(response['state'] == 'error'){
      ScaffoldMessenger.of(globals.appRouter.navigatorKey.currentContext!).showSnackBar(
        SnackBar(content: Text(response['message'])),
      );
    }
    debugPrint('Get messages response: ${data.body}');
    if(response['state'] == 'success' && response['data']!= null){
      for(var message in response['data']){
        messages.updateDiff([ChatMessage.fromJson(message)]);
      }
    }
  }

  Future<void> updateFCMToken(String? newToken) async {
    if(token == null || deviceUUID == null || newToken == null){
      return;
    }
    final data = await doPost({'event': 'updateFcm', 'fcm': newToken});
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
      deviceUUID = storedUUID;
      return;
    }

    deviceUUID = _uuid.v4(); // Example UUID
    localStorageService.saveData(StorageKeys.deviceUUID, deviceUUID);
  }

  Future<void> loadUserCredentials() async {
    var storedCredentials = localStorageService.getData(StorageKeys.userCredentials);
    debugPrint('Loaded user credentials: $storedCredentials');
    if (storedCredentials != null) {
      id = storedCredentials['id'];
      deviceUUID = storedCredentials['uuid'];
      token = storedCredentials['token'];
      email = storedCredentials['email'];
      verified = storedCredentials['verified'];
    }
  }

  Future<void> storeUserCredentials() async {
    localStorageService.saveData(StorageKeys.userCredentials, {'uuid': deviceUUID, 'token': token,'email': email, 'verified': verified});
  }

  Future<void> verifyEmail(String email) async {
    // Simulate email verification process
    await Future.delayed(Duration(seconds: 1)); // Simulate verification delay
    this.email = email;
    verified = true; // Assume verification is successful for this example
  }

  Future<void> deleteAllData() async {
    // Simulate deleting all chat data
    await Future.delayed(Duration(seconds: 1)); // Simulate deletion delay
    email = null;
    verified = false;
    deviceUUID = null;
  }

  Future<http.Response?> doPost(Map<String, dynamic> body) async {
    if (!connectionService.isConnectedCubit.state) {
      return null;
    }
    if(token != null){
      body['token'] = token;
    }
    final http.Response response = await http.post(Uri.parse(apiUrl), headers: headers, body: json.encode(body));
    debugPrint('API response: ${response.request} - ${response.statusCode} - ${response.body}');
    return response;
  }
}
