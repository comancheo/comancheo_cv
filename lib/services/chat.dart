import 'package:comancheo_cv/services/local_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:uuid/uuid.dart';

class ChatService {
  final LocalStorageService localStorageService = GetIt.instance<LocalStorageService>();
  final Uuid _uuid = Uuid();
  String? email;
  bool isVerified = false;
  String? deviceUUID;

  Future<ChatService> init() async {
    // Initialize any resources or connections needed for the chat service
    await Future.delayed(Duration(seconds: 1)); // Simulate initialization delay
    await loadDeviceUUID(); // Load or generate device UUID
    return this;
  }

  Future<void> sendMessage(String message) async {
    // Simulate sending a message
    await Future.delayed(Duration(milliseconds: 500)); // Simulate network delay
    print('Message sent: $message');
  }

  Future<List<String>> receiveMessages() async {
    // Simulate receiving messages
    await Future.delayed(Duration(seconds: 2)); // Simulate network delay
    return ['Hello!', 'How are you?', 'This is a chat message.'];
  }
  
  Future<void> loadDeviceUUID() async {
    var storedUUID = localStorageService.getData(StorageKeys.deviceUUID);
    if(storedUUID != null){
      deviceUUID = storedUUID;
      return;
    }
    
    deviceUUID = _uuid.v4(); // Example UUID
    localStorageService.saveData(StorageKeys.deviceUUID, deviceUUID);
  }

  Future<void> verifyEmail(String email) async {
    // Simulate email verification process
    await Future.delayed(Duration(seconds: 1)); // Simulate verification delay
    this.email = email;
    isVerified = true; // Assume verification is successful for this example
  }

  Future<void> deleteAllData() async {
    // Simulate deleting all chat data
    await Future.delayed(Duration(seconds: 1)); // Simulate deletion delay
    email = null;
    isVerified = false;
    deviceUUID = null;
    print('All chat data deleted.');
  }

}