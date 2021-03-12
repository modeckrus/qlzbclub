import 'dart:async';

import '../entities/user.dart';
///RU:
///Unknow = при старте когда не понятен статус
///unauthenticated = пользователь не вошел и не зарегестрировался
///unverified = пользователь не проверил email
///unsetted = пользователь не выбрал имя и фамилию не проставил теги
///EN:
///Unknow = on start when userRepo is not loaded
///unauthenticated = user don't login/register
///unverified = with unverified email
///unsetted = no setted up name, surname, tags
enum AuthenticationStatus { unknown,unauthenticated,unverified, unsetted, authenticated,  }
abstract class UserService {
  Stream<AuthenticationStatus> get status;
  Future<User?> login({required String email, required String password});
  Future<User?> register({required String email, required String password});
  Future<User?> singInWithGoogle();
  Future<void> logOut();
  Future<void> requestEmailVerification();
  Future<void> init();
  Future<void> changePassword(String password);
  Future<void> resetPassword(String email);
  Future<void> deleteAccount();
  Future<void> updateUser(User newUser);
  Future<void> checkEmailVerification();
  Future<String> getJwtToken();
  ///Need to close up streams
  void close();
  bool isSignIn = false;
  bool isEmailVerified = false;
  User? user;
}