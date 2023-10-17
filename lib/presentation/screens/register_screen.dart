import 'package:flutter/material.dart';
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
      body: const _RegisterView(),
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

class _RegisterForm extends StatefulWidget {
  const _RegisterForm();

  @override
  State<_RegisterForm> createState() => _RegisterFormState();
}

class _RegisterFormState extends State<_RegisterForm> {
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  String username = '';
  String email = '';
  String password = '';

  @override
  Widget build(BuildContext context) {
    return Form(
        key: _formkey,
        child: Column(
          children: [
            CustomTextFormFiel(
              label: 'Nombre de usuario',
              onchanged: (value) => username = value,
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'Campo Requerido';
                }
                if (value.trim().length < 6) {
                  return 'Nombre de a lo menos 6 caracteres';
                }
                return null;
              },
            ),
            const SizedBox(height: 10),
            CustomTextFormFiel(
              label: 'Correo electronico',
              onchanged: (value) => email = value,
               validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'Campo Requerido';
                }
                final emailRegExp = RegExp(
                   r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
                  );
                if (!emailRegExp.hasMatch(value)) {
                  return 'No tiene formato de correo';
                }
                return null;
              },
            ),
            const SizedBox(height: 10),
            CustomTextFormFiel(
              label: 'Contraseña',
              obscureText: true,
              onchanged: (value) => password = value,
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'Campo Requerido';
                }
                if (value.trim().length < 6) {
                  return 'Nombre de a lo menos 6 caracteres';
                }
                return null;
              },
              
            ),
            const SizedBox(height: 20),
            FilledButton.tonalIcon(
                onPressed: () {
                  final isValid = _formkey.currentState!.validate();
                  if (!isValid) return;
                  print('$username , $email , $password');
                },
                icon: const Icon(Icons.save),
                label: const Text('Crear usuario')),
          ],
        ));
  }
}
