import 'dart:convert';

LoginModel loginModelFromJson(String str) => LoginModel.fromJson(json.decode(str));

String loginModelToJson(LoginModel data) => json.encode(data.toJson());

class LoginModel {
  // Patron Modelo
  LoginModel({
    this.usuario,
    this.pass,
  });

  String? usuario;
  String? pass;

  factory LoginModel.fromJson(Map<String, dynamic> json) => LoginModel(
        usuario: json["usuario"],
        pass: json["pass"],
      );

  Map<String, dynamic> toJson() => {
        "usuario": usuario,
        "pass": pass,
      };
}
