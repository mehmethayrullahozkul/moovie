import 'package:equatable/equatable.dart';

/*
 *
 *  AUTHENTICATION EVENT
 * 
 *  Bloc uses a pattern of State, Event, Logic to achieve state management in Flutter.
 *  All three of them are extended by Equatable class in order Bloc to compare functionally.
 * 
 *  This is the 'Event' file for state management.
 * 
 *  In basic terms:
 * 
 *   We have a abstract base class named as we like which extends the Equatable.
 *   Then we create new classes which represents the events of our need and extends the base class we created.
 *
 *   Event class used within to hold possible events in the Bloc.
 *   Just like states, events can hold variables and other stuff inside.
 *   Or even better have private classes as events.
 * 
 *   Like,
 * 
 *   final class _AuthenticationStatusChanged extends AuthenticationEvent {
 *    const _AuthenticationStatusChanged(this.status);
 *
 *    final AuthenticationStatus status;
 *  }
 * 
 *  can use event variables and call necessary logic in main logic file like,
 * 
 *    on<_AuthenticationStatusChanged>(_onAuthenticationLogoutRequested);
 * 
 *    with 
 * 
 *    void _onAuthenticationLogoutRequested(
 *      AuthenticationLogoutRequested event,
 *      Emitter<AuthenticationState> emit,
 *      ) {
 *      _authenticationRepository.logOut();
 *    }
 *  
 *    in the above example we can access the status variable of AuthenticationStatusChanged by event.status
 *
 *    or
 *    
 *    on<LoggedOut>((event, emit) async {
 *      emit(AuthenticationLoading());
 *      await userRepository.deleteToken();
 *      emit(AuthenticationUnauthenticated());
 *      } 
 *    );
 * 
*/

abstract class AuthenticationEvent extends Equatable {
  const AuthenticationEvent();

  @override
  List<Object> get props => [];
}

class AuthenticationStart extends AuthenticationEvent {}

class AuthenticationLoggedIn extends AuthenticationEvent {}

class AuthenticationLoggedOut extends AuthenticationEvent {}

class AuthenticationLogoutButtonPressed extends AuthenticationEvent {}
