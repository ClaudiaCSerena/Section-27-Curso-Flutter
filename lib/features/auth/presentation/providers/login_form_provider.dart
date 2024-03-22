import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:formz/formz.dart';
import 'package:teslo_shop/features/auth/presentation/providers/auth_provider.dart';
import 'package:teslo_shop/features/shared/infrastructure/inputs/inputs.dart';

//! Paso 3: Cómo vamos a consumir el provider. StateNotifierProvider - consume afuera
final loginFormProvider =
    StateNotifierProvider.autoDispose<LoginFormNotifier, LoginFormState>((ref) {
  //el autodispose es para borrar la info 1 vez ya se ingresó la info al formulario.

  final loginUserCallback = ref.watch(authProvider.notifier).loginUser;

  return LoginFormNotifier(loginUserCallback: loginUserCallback);
});

//! Paso 2: Cómo implementar un Notifier
class LoginFormNotifier extends StateNotifier<LoginFormState> {
  final Function(String, String) loginUserCallback;

  LoginFormNotifier({required this.loginUserCallback})
      : super(LoginFormState()); //creación inicial

  //Método
  onEmailChange(String value) {
    final newEmail = Email.dirty(value);
    state = state.copyWith(
        isValid: Formz.validate([newEmail, state.password]), email: newEmail);
  }

  //Método
  onPasswordChanged(String value) {
    final newPassword = Password.dirty(value);
    state = state.copyWith(
        isValid: Formz.validate([newPassword, state.email]),
        password: newPassword);
  }

  //Método
  onFormSubmit() async {
    _touchEveryField();
    if (!state.isValid) return;
    await loginUserCallback(state.email.value, state.password.value);
    //print(state); //al hacer print al state manda a llamar el toString()
  }

  //Método para verificar que al clickear el botón "ingresar", todos los campos hayan sido completados (tocados)
  _touchEveryField() {
    final email = Email.dirty(state.email.value);
    final password = Password.dirty(state.password.value);

    state = state.copyWith(
        isFormPosted: true,
        email: email,
        password: password,
        isValid: Formz.validate([email, password]));
  }
}

//! Paso 1: Crear el estado del provider: StateNotifier
class LoginFormState {
  final bool isPosting;
  final bool isFormPosted;
  final bool isValid;
  final Email email;
  final Password password;

  LoginFormState(
      {this.isPosting = false,
      this.isFormPosted = false,
      this.isValid = false,
      this.email = const Email.pure(), //está limpio
      this.password = const Password.pure()});

  //Agrego el copyWith()
  LoginFormState copyWith(
          {bool? isPosting,
          bool? isFormPosted,
          bool? isValid,
          Email? email,
          Password? password}) =>
      LoginFormState(
          isPosting: isPosting ?? this.isPosting,
          isFormPosted: isFormPosted ?? this.isFormPosted,
          isValid: isValid ?? this.isValid,
          email: email ?? this.email,
          password: password ?? this.password);

  //Agrego el método toString()
  @override
  String toString() {
    return '''
  LoginFormState:
    isPosting: $isPosting
    isFormPosted: $isFormPosted
    isValid: $isValid
    email: $email
    password: $password
  ''';
  }
}
