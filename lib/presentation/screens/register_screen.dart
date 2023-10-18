import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:forms_app/presentation/blocs/register/register_cubit.dart';
import 'package:forms_app/presentation/screens/widgets/widgets.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Nuevo usuario'),
        centerTitle: true,
      ),
      body: BlocProvider(
        create: (context) => RegisterCubit(),
        child: const _RegisterView(),
      ),
    );
  }
}

class _RegisterView extends StatelessWidget {
  const _RegisterView();

  @override
  Widget build(BuildContext context) {
    return const SafeArea(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: SingleChildScrollView(
          child: Column(mainAxisAlignment: MainAxisAlignment.end, children: [
            FlutterLogo(
              size: 150,
            ),
            _RegisterForm(),
            SizedBox(height: 20),
            SizedBox(height: 20)
          ]),
        ),
      ),
    );
  }
}

class _RegisterForm extends StatelessWidget {
  const _RegisterForm();

  // final GlobalKey<FormState> _formkey = GlobalKey<FormState>(); ya no lo necesito al usarlo con gestor de estado
  @override
  Widget build(BuildContext context) {
    final registerCubit = context.watch<RegisterCubit>();
    final username = registerCubit.state.username;
    final password = registerCubit.state.password;
     final email = registerCubit.state.email;

    return Form(
        // key: _formkey,
        child: Column(
      children: [
        CustomTextFormFiel(
          label: 'Nombre de usuario',
          onchanged: registerCubit.usernameChanged,
          errorMessage: username.errorMessage,
          // errorMessage: username.isPure || username.isValid
          // ? null
          // : 'usuario no valido',
        ),
        const SizedBox(height: 10),
        CustomTextFormFiel(
          label: 'Correo electronico',
          onchanged: registerCubit.emailChanged,
          errorMessage: email.errorMessage,

        ),
        const SizedBox(height: 10),
        CustomTextFormFiel(
          label: 'Contraseña',
          obscureText: true,
          onchanged: registerCubit.passwordChanged,
          errorMessage: password.errorMessage,

        ),
        const SizedBox(height: 20),
        FilledButton.tonalIcon(
            onPressed: () {
              registerCubit.onSubmit();
            },
            icon: const Icon(Icons.save),
            label: const Text('Crear usuario')),
      ],
    ));
  }
}
