import 'package:ciheapp/model/user.dart';



class ProfileService {
  
  final User _mockUser = User(
    id: 1,
    firstname: 'Bijaya',
    lastname: 'Gautam',
    name: 'Bijaya Gautam',
    email: 'bijayagautam125@gmail.com',
    phoneNumber: '1234567890',
    role: UserRole.student,
    profileImageUrl: 'https://i.pravatar.cc/150?img=1',
    notificationPreferences: NotificationPreferences(),
    isTwoFactorEnabled: true,
    status: 'active',
  );

   final User _teacherUser = User(
    id: 1,
    firstname: 'Reza',
    lastname: 'Rafeh',
    name: 'Reza Rafeh',
    email: 'Reza2413@gmail.com',
    phoneNumber: '+613456789',
    role: UserRole.lecturer,
    profileImageUrl: 'assets/images/teacher.jpg',
    notificationPreferences: NotificationPreferences(),
    isTwoFactorEnabled: true,
    status: 'active',
  );
  Future<User> getUserProfile() async {
   
    await Future.delayed(const Duration(seconds: 1));
    
   
    return _mockUser;
  }

  Future<User> getTeacherProfile() async {
   
    await Future.delayed(const Duration(seconds: 1));
    
   
    return _teacherUser;
  }

  Future<User> updateProfile({
    String? name,
    String? email,
    String? phoneNumber,
    String? profileImageUrl,
  }) async {

    await Future.delayed(const Duration(seconds: 1));
    

    return _mockUser.copyWith(
      name: name,
      email: email,
      phoneNumber: phoneNumber,
      profileImageUrl: profileImageUrl,
    );
  }


  Future<User> updateNotificationPreferences(NotificationPreferences preferences) async {
  
    await Future.delayed(const Duration(seconds: 1));
    
   
    return _mockUser.copyWith(
      notificationPreferences: preferences,
    );
  }
}

