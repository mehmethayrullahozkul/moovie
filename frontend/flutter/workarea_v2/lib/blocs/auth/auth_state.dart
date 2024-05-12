import 'package:equatable/equatable.dart';

/*
 *
 *  AUTHENTICATION STATE
 * 
 *  Bloc uses a pattern of State, Event, Logic to achieve state management in Flutter.
 *  All three of them are extended by Equatable class in order Bloc to compare functionally.
 * 
 *  This is the 'State' file for state management.
 * 
 *  In basic terms:
 * 
 *   We have a abstract base class named as we like which extends the Equatable.
 *   Then we create new classes which represents the states of our need and extends the base class we created.
 * 
 *   Bloc states MOSTLY used within screens to build the widgets accordingly.
 *   We can use a BlocBuilder or BlocListener to check the state of our Bloc and redirect or build.
 * 
 *   Like so,
 * 
 *   return BlocListener<AuthenticationBloc, AuthenticationState>(
 *        listener: (context, state) {
 *          switch (state.status) {
 *            case AuthenticationStatus.authenticated:
 *              _navigator.pushAndRemoveUntil<void>(
 *                HomePage.route(),
 *                (route) => false,
 *              );
 *            case AuthenticationStatus.unauthenticated:
 *
 *   or,
 *
 *   BlocBuilder<AuthenticationBloc, AuthenticationState>(
 *      builder: (context, state) {
 *        if (state is AuthenticationAuthenticated) {
 *          return MainScreen();
 *        }
 *        if (state is AuthenticationUnauthenticated) {
 *          return LoginPage(userRepistory: userRepository);
 *        }
 *
 *    
      read more at Bloc docs.
 * 
 *   EXAMPLE: 
 *     authentication_states.dart with single Authentication class and representing the states with extensions.
 * 
 *    class AuthenticationState extends Equatable {
 *        const AuthenticationState._({
 *        this.status = AuthenticationStatus.unknown,
 *        his.user = User.empty,
 *        });
 *  
 *        const AuthenticationState.unknown() : this._();
 *  
 *        const AuthenticationState.authenticated(User user)
 *        : this._(status: AuthenticationStatus.authenticated, user: user);
 *  
 *        const AuthenticationState.unauthenticated()
 *        : this._(status: AuthenticationStatus.unauthenticated);
 *  
 *        final AuthenticationStatus status;
 *        final User user;
 *  
 *        @override
 *        List<Object> get props => [status, user];
 *    }
 *    
 *    
 *    EXAMPLE:
 *      authentication_states.dart with multiple authentication classes and states being inherited classes.
 * 
 *    abstract class AuthenticationState extends Equatable {
 *      @override
 *      List<Object> get props => [];
 *    }
 *
 *    class AuthenticationUninitialized extends AuthenticationState {}
 *
 *    class AuthenticationAuthenticated extends AuthenticationState {}
 *
 *    class AuthenticationUnauthenticated extends AuthenticationState {}
 *
 *    class AuthenticationLoading extends AuthenticationState {}
 * 
 * 
*/

abstract class AuthenticationState extends Equatable {
  @override
  List<Object> get props => [];
}

class AuthenticationUninitialized extends AuthenticationState {}

class AuthenticationAuthenticated extends AuthenticationState {}

/* class AuthenticationAnonymous extends AuthenticationState {} */

class AuthenticationUnauthenticated extends AuthenticationState {}

class AuthenticationLoading extends AuthenticationState {}
