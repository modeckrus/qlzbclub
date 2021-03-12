import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:get_it/get_it.dart';

import '../../entities/user.dart';
import '../../service/user_service.dart';

part 'authentication_event.dart';
part 'authentication_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  AuthenticationBloc() : super(const AuthenticationState.unknown()) {
    _authenticationStatusSubscription = _userRepository.status.listen((status) {
      print(status);
      add(AuthenticationStatusChanged(status));
    });
  }
  final UserService _userRepository = GetIt.I.get<UserService>();
  StreamSubscription<AuthenticationStatus>? _authenticationStatusSubscription;

  @override
  Stream<AuthenticationState> mapEventToState(
    AuthenticationEvent event,
  ) async* {
    if (event is AuthenticationStatusChanged) {
      yield await _mapAuthenticationStatusChangedToState(event);
    } else if (event is AuthenticationLogoutRequested) {
      _userRepository.logOut();
    } else if( event is AuthAppStarted){
      final isSignIn = _userRepository.isSignIn;
      if(isSignIn){
        // if(_userRepository.){

        // }else{

        // }
        // final user = _userRepository.user;
        
      }else{
        yield AuthenticationState.unauthenticated();
      }
    }
  }

  @override
  Future<void> close() {
    _authenticationStatusSubscription?.cancel();
    _userRepository.close();
    return super.close();
  }

  Future<AuthenticationState> _mapAuthenticationStatusChangedToState(
    AuthenticationStatusChanged event,
  ) async {
    switch (event.status) {
      case AuthenticationStatus.unauthenticated:
        return const AuthenticationState.unauthenticated();
      case AuthenticationStatus.authenticated:
        final user = _userRepository.user;
        return user != null
            ? AuthenticationState.authenticated(user)
            : const AuthenticationState.unauthenticated();
      case AuthenticationStatus.unverified:
        return const AuthenticationState.unverified();
      case AuthenticationStatus.unsetted:
        return const AuthenticationState.unsetted();
      default:
        return const AuthenticationState.unknown();
    }
  }
}
