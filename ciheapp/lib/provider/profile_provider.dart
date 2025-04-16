import 'package:ciheapp/model/user.dart';
import 'package:ciheapp/service/profile_service.dart';
import 'package:flutter/material.dart';

class ProfileProvider with ChangeNotifier {
  User? _user;
  User? _teacher;
  bool _isLoading = false;
  String? _error;

  User? get user => _user;
  User? get teacher => _teacher;
  bool get isLoading => _isLoading;
  String? get error => _error;

  final ProfileService _profileService = ProfileService();

  Future<void> fetchUserProfile() async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      final user = await _profileService.getUserProfile();
     
      _user = user;
      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _isLoading = false;
      _error = e.toString();
      notifyListeners();
    }
  }
  Future<void> fetchTeacherProfile() async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      final teacher = await _profileService.getTeacherProfile();
     
      _teacher = teacher;
      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _isLoading = false;
      _error = e.toString();
      notifyListeners();
    }
  }
  Future<bool> updateProfile({
    String? name,
    String? email,
    String? phoneNumber,
    String? profileImageUrl,
  }) async {
    if (_user == null) return false;

    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      final updatedUser = await _profileService.updateProfile(
        name: name,
        email: email,
        phoneNumber: phoneNumber,
        profileImageUrl: profileImageUrl,
      );

      _user = updatedUser;
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

  Future<bool> updateNotificationPreferences(
      NotificationPreferences preferences) async {
    if (_user == null) return false;

    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      final updatedUser =
          await _profileService.updateNotificationPreferences(preferences);

      _user = updatedUser;
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

  void clearError() {
    _error = null;
    notifyListeners();
  }
}
