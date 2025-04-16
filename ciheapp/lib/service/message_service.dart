import 'dart:async';
import 'package:ciheapp/model/message.dart';
import 'package:ciheapp/model/user.dart';



class MessageService {

  final List<User> _mockContacts = [
  
  User(
    id: 3,
    firstname: 'Sanjaya',
    lastname: 'Adk',
    name: 'sanjaya adk',
    email: 'sanjayaadk@gmailo.com',
    role: UserRole.admin,
    status: 'active',
    notificationPreferences: NotificationPreferences(),
  ),
   User(
    id: 4,
    firstname: 'Reza',
    lastname: 'Rafeh',
    name: 'Reza Rafeh',
    email: 'reza@gmail.com',
    role: UserRole.lecturer,
    status: 'active',
    notificationPreferences: NotificationPreferences(),
  ),
  ];

  final Map<String, List<Message>> _mockMessages = {
    '2': [
      Message(
        id: '1',
        senderId: '2',
        receiverId: '1',
        content: 'Hello, how are you doing with your assignment?',
        timestamp: DateTime.now().subtract(const Duration(days: 1, hours: 2)),
        isRead: true,
      ),
      Message(
        id: '2',
        senderId: '1',
        receiverId: '2',
        content: 'I\'m making good progress, thank you!',
        timestamp: DateTime.now().subtract(const Duration(days: 1, hours: 1)),
        isRead: true,
      ),
    ],
    '3': [
      Message(
        id: '3',
        senderId: '3',
        receiverId: '1',
        content: 'Please check your email for important updates about the upcoming exam.',
        timestamp: DateTime.now().subtract(const Duration(hours: 5)),
        isRead: false,
      ),
       Message(
        id: '3',
        senderId: '1',
        receiverId: '3',
        content: 'Ok sir i will check my email, thank you!',
        timestamp: DateTime.now().subtract(const Duration(days: 1, hours: 1)),
        isRead: true,
      ),
    ],
  };


  final StreamController<Message> _messageController = StreamController<Message>.broadcast();

 
  Future<List<User>> getContacts() async {
   
    await Future.delayed(const Duration(seconds: 1));
    
    
    return _mockContacts;
  }

 
  Future<List<Message>> getMessages(String userId) async {

    await Future.delayed(const Duration(seconds: 1));
    
  
    return _mockMessages[userId] ?? [];
  }


  Future<Message> sendMessage(String receiverId, String content, {List<String>? attachments}) async {

    await Future.delayed(const Duration(seconds: 1));
    
   
    final message = Message(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      senderId: '1', 
      receiverId: receiverId,
      content: content,
      timestamp: DateTime.now(),
      attachments: attachments,
    );
    
   
    if (_mockMessages.containsKey(receiverId)) {
      _mockMessages[receiverId]!.add(message);
    } else {
      _mockMessages[receiverId] = [message];
    }
    
    return message;
  }

 
  Future<void> markAsRead(String messageId) async {
   
    await Future.delayed(const Duration(milliseconds: 500));
    

    for (final userId in _mockMessages.keys) {
      final messages = _mockMessages[userId]!;
      final index = messages.indexWhere((m) => m.id == messageId);
      // if (index != -1) {
      //   messages[index] = messages[index].copyWith(isRead: true);
      //   break;
      // }
    }
  }


  void onNewMessage(Function(Message) callback) {
    _messageController.stream.listen(callback);
  }


  void simulateNewMessage(Message message) {
    if (_mockMessages.containsKey(message.senderId)) {
      _mockMessages[message.senderId]!.add(message);
    } else {
      _mockMessages[message.senderId] = [message];
    }
    _messageController.add(message);
  }


  void dispose() {
    _messageController.close();
  }
}

