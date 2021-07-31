import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _keyFormLogin = GlobalKey<FormState>();
  late String _usuario, _pass;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login Page'),
      ),
      body: FractionallySizedBox(
        widthFactor: 0.8,
        child: SingleChildScrollView(
          child: Form(
            key: _keyFormLogin,
            child: Column(
              children: [
                TextFormField(
                  onSaved: (value) {
                    if (value != null) {
                      _usuario = value.trim();
                    }
                  },
                  validator: (value) {
                    if (value != null) {
                      if (value.isNotEmpty || value != '') {
                        if (RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(value)) {
                          return null;
                        } else {
                          return "Algo no anda bien, debes introducir un correo válido.";
                        }
                      } else {
                        return "Campo obligatorio";
                      }
                    } else {
                      return "Campo obligatorio";
                    }
                  },
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  decoration: InputDecoration(
                    labelText: 'Usuario',
                    hintText: 'usuario@empresa.com',
                  ),
                ),
                TextFormField(
                  onSaved: (value) {
                    if (value != null) {
                      _pass = value.trim();
                    }
                  },
                  validator: (value) {
                    if (value != null) {
                      if (value.isNotEmpty || value != '') {
                        if (RegExp(r"^[\w]{8,}").hasMatch(value)) {
                          return null;
                        } else {
                          return "La contraseña debe ser minimo de 8 caracteres alfanuméricos";
                        }
                      } else {
                        return "Campo obligatorio";
                      }
                    } else {
                      return "Campo obligatorio";
                    }
                  },
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: 'Contraseña',
                    hintText: 'password123',
                  ),
                ),
                SizedBox(height: 20.0),
                ElevatedButton(
                  child: Text('Inicias Sesion'),
                  onPressed: () async {},
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
