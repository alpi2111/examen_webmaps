import 'package:examen_webmaps/src/pages/bienvenido_page.dart';
import 'package:flutter/material.dart';
import 'package:examen_webmaps/src/providers/database_provider.dart';
import 'package:examen_webmaps/src/models/login_model.dart';
import 'package:examen_webmaps/src/modals/alerts_modals.dart' as modal;

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _keyFormLogin = GlobalKey<FormState>();
  final LoginModel _loginModel = LoginModel();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login Page'),
      ),
      body: Center(
        child: FractionallySizedBox(
          widthFactor: 0.8,
          child: SingleChildScrollView(
            child: Form(
              key: _keyFormLogin,
              child: Column(
                children: [
                  TextFormField(
                    onSaved: (value) {
                      if (value != null) {
                        _loginModel.usuario = value.trim();
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
                  SizedBox(height: 20.0),
                  TextFormField(
                    onSaved: (value) {
                      if (value != null) {
                        _loginModel.pass = value.trim();
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
                    child: Text('Iniciar Sesion'),
                    onPressed: () async {
                      if (!_keyFormLogin.currentState!.validate()) return;
                      _loginModel.usuario = "";
                      _loginModel.pass = "";
                      _keyFormLogin.currentState!.save();
                      modal.showCustomLoadingDialog(
                        context: context,
                        titulo: 'Iniciando Sesion...',
                      );
                      final _db = DatabaseProvider();
                      print(_loginModel.usuario);
                      print(_loginModel.pass);
                      final inicio = await _db.loginUsuario(_loginModel);
                      Navigator.pop(context);
                      if (inicio) {
                        Navigator.of(context).pushReplacement(
                          MaterialPageRoute(builder: (BuildContext context) => BienvenidoPage()),
                        );
                      } else {
                        await modal.showCustomContentTextDialog(
                          context: context,
                          dismis: true,
                          contenido: 'Inicio de sesion incorrecto',
                          titulo: 'Error',
                        );
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
