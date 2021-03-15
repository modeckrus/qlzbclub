import 'dart:async';

import '../dependecies.dart';
import '../service/db_service.dart';
import 'package:firedart/auth/user_gateway.dart' as fire;
import 'package:firedart/firedart.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:hive/hive.dart';

import '../entities/user.dart';
import '../service/dgraph_service.dart';
import '../service/token_store.dart';
import '../service/user_service.dart';

class FirebaseUserRepo implements UserService {
  StreamController<AuthenticationStatus>? _controller;
  Box<User>? box;
  @override
  bool isSignIn = false;

  @override
  User? user;

  @override
  void close() {
    _controller?.close();
  }

  @override
  Future<void> requestEmailVerification() {
    return FirebaseAuth.instance.requestEmailVerification();
  }
  fire.User? fireUser;
  @override
  Future<void> init() async {
    _controller = StreamController();
    Hive.registerAdapter(TokenAdapter());
    Hive.registerAdapter(UserAdapter());
    FirebaseAuth.initialize(
        'AIzaSyAllSFQBnQHUF_bjjsW29k4X0QgunkbXLk', await HiveStore.create());
    isSignIn = FirebaseAuth.instance.isSignedIn;
    FirebaseAuth.instance.signInState.listen((isS) {
      if (isS) {
        print('Singed in in singInState');
      } else {
        _controller?.add(AuthenticationStatus.unauthenticated);
        if (box != null) {
          box?.clear();
        }
      }
    });
    if (isSignIn) {
      fireUser = await FirebaseAuth.instance.getUser();
      if(fireUser == null){
        _controller?.add(AuthenticationStatus.unauthenticated);
        return;
      }
      isEmailVerified = fireUser!.emailVerified;
      try{
      box = await Hive.openBox<User>('user');
      }catch(e){
        print('Open Box issue');
        print(e);
      }
      if(box!.values!.length <= 0){
        if(!Dependencies.isDb){
          user = User(fid: fireUser!.id, photoUrl: fireUser!.photoUrl, name: fireUser!.displayName, id: '');
          await Dependencies.initDb();
        }
        final duser = await GetIt.I.get<Db>().getUser();
        
        if(duser == null){
        _controller?.add(AuthenticationStatus.unsetted);
        user = User(fid: fireUser!.id, photoUrl: fireUser!.photoUrl, name: fireUser!.displayName, id: '');
        
        }else{
          user = duser;
          isEmailVerified = fireUser!.emailVerified;
          if(isEmailVerified){
            _controller?.add(AuthenticationStatus.authenticated);
          }else{
            _controller?.add(AuthenticationStatus.unverified);
          }
        }
        
      }else{
      box?.values.forEach((element) {
        user = element;
      });
      if(fireUser!.emailVerified){
        if(user?.tags == null || user!.tags!.length <= 0){
          _controller?.add(AuthenticationStatus.unsetted);
        }else{
          _controller?.add(AuthenticationStatus.authenticated);
        }
      }else{
        _controller?.add(AuthenticationStatus.unverified);
      }
      }
    }else{
      _controller?.add(AuthenticationStatus.unauthenticated);
    }
  }

  @override
  Future<void> logOut() async {
    _controller?.add(AuthenticationStatus.unauthenticated);
    if (box != null) {
      await box!.clear();
    }
    return FirebaseAuth.instance.signOut();
  }

  @override
  Future<User?> login({required String email, required String password}) async {
    final fuser = await FirebaseAuth.instance.signIn(email, password);
    if (fuser.emailVerified == null || !fuser.emailVerified) {
      _controller?.add(AuthenticationStatus.unverified);
      await requestEmailVerification();
    } else {
      final duser = await GetIt.I.get<Db>().getUser();
      if (duser?.name == null ||
          duser?.name == '') {
        _controller?.add(AuthenticationStatus.unsetted);
      } else {
        user = duser;
        _controller?.add(AuthenticationStatus.authenticated);
        await box?.add(user);
        return user;
      }
    }
  }

  @override
  Future<User?> register({required String email,required String password}) async {
    final fuser = await FirebaseAuth.instance.signUp(email, password);
    if (fuser.emailVerified == null || !fuser.emailVerified) {
      _controller?.add(AuthenticationStatus.unverified);
      await requestEmailVerification();
    } else {
      final duser = await GetIt.I.get<Db>().getUser();
      if (duser?.name == '' ) {
        _controller?.add(AuthenticationStatus.unsetted);
      } else {
        user = duser;
        _controller?.add(AuthenticationStatus.authenticated);
        return user;
      }
    }
  }

  @override
  Future<User> singInWithGoogle() {
    // TODO: implement singInWithGoogle
    throw UnimplementedError();
  }

  @override
  Stream<AuthenticationStatus> get status async* {
    yield* _controller!.stream;
  }

  @override
  Future<void> changePassword(String password) {
      return FirebaseAuth.instance.changePassword(password);
    }
  
    @override
    Future<void> deleteAccount() async{
      await Dgraph.deleteAccount();
      box?.clear();
      return FirebaseAuth.instance.deleteAccount();
    }
  
    @override
    Future<void> resetPassword(String email) {
      return FirebaseAuth.instance.resetPassword(email);
    }
  
    @override
    Future<void> updateUser(User newUser) async{
      user = await GetIt.I.get<Db>().updateUser(newUser);
      FirebaseAuth.instance.updateProfile(displayName: newUser.name, photoUrl: newUser.photoUrl);
      box?.put(0, user);
      final fuser = await FirebaseAuth.instance.getUser();
      if(fuser.emailVerified){
        _controller?.add(AuthenticationStatus.authenticated);
      }else{
        _controller?.add(AuthenticationStatus.authenticated);
      }
  }

  @override
  Future<void> checkEmailVerification() async{
    final fuser = await FirebaseAuth.instance.getUser();
    if(fuser.emailVerified){
      if(GetIt.I.get<Db>().initialised() == false){
        await Dependencies.init();
      }
      final duser = await GetIt.I.get<Db>().getUser();
      if (
          duser?.name == '' ) {
        _controller?.add(AuthenticationStatus.unsetted);
      } else {
        user = duser;
        _controller?.add(AuthenticationStatus.authenticated);
      }
    }else{
      _controller?.add(AuthenticationStatus.unverified);
    }
  }

  @override
  Future<String> getJwtToken() {
    return FirebaseAuth.instance.tokenProvider.idToken;
  }

  @override
  bool isEmailVerified = false;
}
