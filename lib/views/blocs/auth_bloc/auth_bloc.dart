import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthInitial()) {
    on<AuthEvent>((event, emit) async {
      if (event is LoginEvent) {
        emit(LoginLoading());
        try {
          await FirebaseAuth.instance.signInWithEmailAndPassword(
            email: event.email,
            password: event.password,
          );
          emit(LoginSuccess());
        } on FirebaseAuthException catch (e) {
          if (e.code == 'user-not-found') {
            emit(LoginFailure(errMessage: 'No user found for that email.'));
          } else if (e.code == 'wrong-password') {
            emit(LoginFailure(
                errMessage: 'Wrong password provided for that user.'));
          }
        } catch (ex) {
          emit(LoginFailure(
              errMessage: 'some thing went wrong and here is the Error: $ex'));
        }
      }
      if (event is RegisterEvent) {
        emit(RegisterLoading());
        try {
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
              email: event.email, password: event.password);
          emit(RegisterSuccess());
        } on FirebaseAuthException catch (e) {
          if (e.code == 'weak-password') {
            emit(RegisterFailure(
                errMessage: 'The password provided is too weak.'));
          } else if (e.code == 'email-already-in-use') {
            emit(RegisterFailure(
                errMessage: 'The account already exists for that email.'));
          }
        } catch (ex) {
          emit(RegisterFailure(
              errMessage: 'some thing went wrong and here is the Error: $ex'));
        }
      }
    });
  }

  @override
  void onTransition(Transition<AuthEvent, AuthState> transition) {
    super.onTransition(transition);
  }
}
