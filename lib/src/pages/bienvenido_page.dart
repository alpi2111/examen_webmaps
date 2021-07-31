import 'dart:math';

import 'package:flutter/material.dart';
import 'package:examen_webmaps/src/models/usuario_model.dart';
import 'package:examen_webmaps/src/providers/database_provider.dart';
import 'package:examen_webmaps/src/modals/alerts_modals.dart' as modal;

class BienvenidoPage extends StatefulWidget {
  @override
  _BienvenidoPageState createState() => _BienvenidoPageState();
}

class _BienvenidoPageState extends State<BienvenidoPage> {
  final _db = DatabaseProvider();

  final _cantidadRegistros = 1000;

  final List<String> paises = const [
    "México",
    "Estados Unidos",
    "Canadá",
    "Argentina",
    "Chile",
    "Puerto Rico",
  ];

  final List<String> estados = const [
    "Veracruz",
    "Nevada",
    "Ontario",
    "Buenos Aires",
    "Santiago de Chile",
    "San Juan",
  ];

  List<UsuarioModel> _usuarios = [];
  String _ordenarPor = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Bienvenido Page'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Flexible(
                  flex: 6,
                  child: ElevatedButton(
                    child: Text('Generar $_cantidadRegistros registros'),
                    onPressed: () async {
                      modal.showCustomLoadingDialog(context: context, titulo: "Registrando...");
                      for (int i = 0; i < _cantidadRegistros; i++) {
                        int random = Random.secure().nextInt(paises.length);
                        await _db.agregarRegistroUsuario(UsuarioModel(
                          estado: estados[random],
                          genero: random % 2 == 0 ? "Masculino" : "Femenino",
                          pais: paises[random],
                          usuario: "Usuario $i",
                        ));
                        // setState(() {});
                      }
                      Navigator.pop(context);
                      await modal.showCustomContentTextDialog(
                        context: context,
                        titulo: 'Información',
                        contenido: "Registros completos: $_cantidadRegistros",
                      );
                      setState(() {});
                    },
                  ),
                ),
                Flexible(
                  flex: 6,
                  child: ElevatedButton(
                    child: Text('Borrar todos los registros'),
                    onPressed: () async {
                      modal.showCustomLoadingDialog(context: context, titulo: "Eliminando...");
                      for (int i = 0; i < _usuarios.length; i++) {
                        await _db.borrarUsuario(_usuarios[i]);
                      }
                      Navigator.pop(context);
                      await modal.showCustomContentTextDialog(
                        context: context,
                        titulo: 'Información',
                        contenido: "Registros eliminados: ${_usuarios.length}",
                      );
                      setState(() {});
                    },
                  ),
                ),
              ],
            ),
            SizedBox(height: 20.0),
            Row(
              children: [
                Flexible(
                  flex: 5,
                  child: DropdownButton(
                    isExpanded: true,
                    value: _ordenarPor != '' ? _ordenarPor : null,
                    items: [
                      DropdownMenuItem(
                        value: "usuario",
                        child: Text('Usuario'),
                      ),
                      DropdownMenuItem(
                        value: "pais",
                        child: Text('Pais'),
                      ),
                      DropdownMenuItem(
                        value: "estado",
                        child: Text('Estado'),
                      ),
                      DropdownMenuItem(
                        value: "genero",
                        child: Text('Genero'),
                      ),
                    ],
                    onChanged: (val) {
                      setState(() {
                        _ordenarPor = val.toString();
                      });
                    },
                    hint: Text('Ordenar por...'),
                  ),
                ),
              ],
            ),
            SizedBox(height: 20.0),
            FutureBuilder(
              future: _db.obtenerTodosLosUsuarios(_ordenarPor),
              builder: (BuildContext context, AsyncSnapshot<List<UsuarioModel>> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) return Center(child: CircularProgressIndicator());
                if (snapshot.data != null) {
                  _usuarios = snapshot.data!;
                  if (snapshot.data!.length == 0) return Text('No hay registros');
                  return Expanded(
                    child: ListView.builder(
                      itemCount: snapshot.data!.length,
                      itemBuilder: (BuildContext context, int index) {
                        return ListTile(
                          title: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Usuario: ${_usuarios.elementAt(index).usuario}'),
                              Text('Pais: ${_usuarios.elementAt(index).pais}'),
                              Text('Estado: ${_usuarios.elementAt(index).estado}'),
                              Text('Género: ${_usuarios.elementAt(index).genero}'),
                              Divider(),
                            ],
                          ),
                        );
                      },
                    ),
                  );
                }
                return Center(child: Text('Ocurrió un error'));
              },
            ),
          ],
        ),
      ),
    );
  }
}
