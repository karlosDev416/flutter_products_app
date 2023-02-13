import 'package:flutter/material.dart';
import 'package:flutter_products_app/providers/login_form_provider.dart';
import 'package:flutter_products_app/services/services.dart';
import 'package:flutter_products_app/widgets/widgets.dart';
import 'package:provider/provider.dart';

import '../ui/input_decorations.dart';

class RegisterScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AuthBackground(
          child: SingleChildScrollView(
        child: Column(children: [
          SizedBox(
            height: 250,
          ),
          CardContainer(
              child: Column(
            children: [
              SizedBox(
                height: 10,
              ),
              Text('Crear cuenta',
                  style: Theme.of(context).textTheme.headlineMedium),
              SizedBox(height: 30),
              ChangeNotifierProvider(
                create: (_) => LoginFormProvider(),
                child: _LoginForm(),
              )
            ],
          )),
          SizedBox(
            height: 50,
          ),
          TextButton(
              onPressed: () => Navigator.pushReplacementNamed(context, 'login'),
              style: ButtonStyle(
                  shape: MaterialStateProperty.all(StadiumBorder()),
                  overlayColor: MaterialStateProperty.all(
                      Colors.indigo.withOpacity(0.1))),
              child: Text(
                '¿Ya tienes una cuenta?',
                style: TextStyle(fontSize: 18, color: Colors.black87),
              )),
          SizedBox(
            height: 50,
          ),
        ]),
      )),
    );
  }
}

class _LoginForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final loginForm = Provider.of<LoginFormProvider>(context);
    return Container(
      child: Form(
        key: loginForm.formKey,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        child: Column(
          children: [
            TextFormField(
              autocorrect: false,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecorations.authInputDecoration(
                  hintText: 'john.doe@gmail.com',
                  labelText: 'Correo eletrónico',
                  prefixIcon: Icons.alternate_email_sharp),
              onChanged: (value) => loginForm.email = value,
              validator: (value) {
                String pattern =
                    r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
                RegExp regExp = new RegExp(pattern);
                return regExp.hasMatch(value ?? '') ? null : 'Formato inválido';
              },
            ),
            SizedBox(
              height: 30,
            ),
            TextFormField(
              autocorrect: false,
              obscureText: true,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecorations.authInputDecoration(
                  hintText: '****',
                  labelText: 'Contraseña',
                  prefixIcon: Icons.lock_outline),
              onChanged: (value) => loginForm.password = value,
              validator: (value) {
                return (value != null && value.length >= 6)
                    ? null
                    : 'La contraseña debe contener al menos 6 caracteres';
              },
            ),
            SizedBox(
              height: 30,
            ),
            MaterialButton(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              disabledColor: Colors.grey,
              elevation: 0,
              color: Colors.deepPurple,
              child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 80, vertical: 15),
                  child: Text(
                    loginForm.isLoading ? 'Espere...' : 'Ingresar',
                    style: TextStyle(color: Colors.white),
                  )),
              onPressed: loginForm.isLoading
                  ? null
                  : () async {
                      FocusScope.of(context).unfocus();

                      if (!loginForm.isValidForm()) return;

                      loginForm.isLoading = true;

                      final authService =
                          Provider.of<AuthService>(context, listen: false);
                      final String? errorMessage = await authService.createUser(
                          loginForm.email, loginForm.password);
                      if (errorMessage == null) {
                        Navigator.pushReplacementNamed(context, 'home');
                      } else {
                        // print(errorMessage);
                        NotificationsService.showSnackbar(errorMessage);
                        loginForm.isLoading = false;
                      }
                    },
            )
          ],
        ),
      ),
    );
  }
}