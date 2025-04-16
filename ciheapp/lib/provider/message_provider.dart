import 'package:ciheapp/model/message.dart';
import 'package:ciheapp/model/user.dart';
import 'package:ciheapp/service/message_service.dart';
import 'package:flutter/material.dart';



class MessageProvider with ChangeNotifier {
  List<Message> _messages = [];
  List<User> _contacts = [];
  bool _isLoading = false;
  String? _error;
  String? _currentChatUserId;

  List<Message> get messages => _messages;
  List<User> get contacts => _contacts;  bool get isLoading => _isLoading;
  String? get error => _error;
  String? get currentChatUserId => _currentChatUserId;

  final MessageService _messageService = MessageService();


  Future<void> setCurrentChatUser(String userId) async {
    _currentChatUserId = userId;
    notifyListeners();
    await fetchMessages(userId);
  }


  Future<void> fetchContacts() async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      final contacts = await _messageService.getContacts();
      _contacts = contacts;
      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _isLoading = false;
      _error = e.toString();
      notifyListeners();
    }
  }

 
  Future<void> fetchMessages(String userId) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      final messages = await _messageService.getMessages(userId);
      _messages = messages;
      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _isLoading = false;
      _error = e.toString();
      notifyListeners();
    }
  }

 
  Future<bool> sendMessage(String receiverId, String content, {List<String>? attachments}) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      final message = await _messageService.sendMessage(receiverId, content, attachments: attachments);
      
     
      if (receiverId == _currentChatUserId) {
        _messages = [..._messages, message]; 
      }
      
      _isLoading = false;
      notifyListeners();
      return true;
    } catch (e) {
      _isLoading = false;
      _error = e.toString();
      notifyListeners();
      return false;
    }
  }


  Future<void> markAsRead(String messageId) async {
    try {
      await _messageService.markAsRead(messageId);
      
     
      final index = _messages.indexWhere((m) => m.id == messageId);
      if (index != -1) {
        final updatedMessages = List<Message>.from(_messages);
       
        updatedMessages[index] = Message(
          id: _messages[index].id,
          senderId: _messages[index].senderId,
          receiverId: _messages[index].receiverId,
          content: _messages[index].content,
          timestamp: _messages[index].timestamp,
          isRead: true,
          attachments: _messages[index].attachments,
        );
        _messages = updatedMessages;
        notifyListeners();
      }
    } catch (e) {
      _error = e.toString();
      notifyListeners();
    }
  }

  void setupMessageListeners() {
    _messageService.onNewMessage((message) {
   
      if (message.senderId == _currentChatUserId || message.receiverId == _currentChatUserId) {
        _messages = [..._messages, message]; 
        notifyListeners();
      }
    });
  }


  void clearError() {
    _error = null;
    notifyListeners();
  }
}

