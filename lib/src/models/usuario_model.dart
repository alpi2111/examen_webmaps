import 'dart:convert';

UsuarioModel usuarioModelFromJson(String str) => UsuarioModel.fromJson(json.decode(str));

String usuarioModelToJson(UsuarioModel usr) => json.encode(usr.toJson());

class UsuarioModel {
  // Patron Modelo
  UsuarioModel({
    this.usuario,
    this.pais,
    this.estado,
    this.genero,
  });

  String? usuario;
  String? pais;
  String? estado;
  String? genero;

  factory UsuarioModel.fromJson(Map<String, dynamic> json) => UsuarioModel(
        usuario: json["usuario"],
        pais: json["pais"],
        estado: json["estado"],
        genero: json["genero"],
      );

  Map<String, dynamic> toJson() => {
        "usuario": usuario,
        "pais": pais,
        "estado": estado,
        "genero": genero,
      };
}
