import 'package:clubhouse/entities/user.dart';
import 'package:clubhouse/service/user_service.dart';

class RestUserRepoImpl extends UserService{
  @override
  Future<void> changePassword(String password) {
      // TODO: implement changePassword
      throw UnimplementedError();
    }
  
    @override
    Future<void> checkEmailVerification() {
      // TODO: implement checkEmailVerification
      throw UnimplementedError();
    }
  
    @override
    void close() {
      // TODO: implement close
    }
  
    @override
    Future<void> deleteAccount() {
      // TODO: implement deleteAccount
      throw UnimplementedError();
    }
  
    @override
    Future<String> getJwtToken() {
      // TODO: implement getJwtToken
      throw UnimplementedError();
    }
  
    @override
    Future<void> init() {
      // TODO: implement init
      throw UnimplementedError();
    }
  
    @override
    Future<void> logOut() {
      // TODO: implement logOut
      throw UnimplementedError();
    }
  
    @override
    Future<User?> login({required String email, required String password}) {
      // TODO: implement login
      throw UnimplementedError();
    }
  
    @override
    Future<User?> register({required String email, required String password}) {
      // TODO: implement register
      throw UnimplementedError();
    }
  
    @override
    Future<void> requestEmailVerification() {
      // TODO: implement requestEmailVerification
      throw UnimplementedError();
    }
  
    @override
    Future<void> resetPassword(String email) {
      // TODO: implement resetPassword
      throw UnimplementedError();
    }
  
    @override
    Future<User?> singInWithGoogle() {
      // TODO: implement singInWithGoogle
      throw UnimplementedError();
    }
  
    @override
    // TODO: implement status
    Stream<AuthenticationStatus> get status => throw UnimplementedError();
  
    @override
    Future<void> updateUser(User newUser) {
    // TODO: implement updateUser
    throw UnimplementedError();
  }

}