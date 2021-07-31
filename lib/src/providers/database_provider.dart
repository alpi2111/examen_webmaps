import 'package:examen_webmaps/src/models/login_model.dart';
import 'package:examen_webmaps/src/models/usuario_model.dart';
import 'package:mysql1/mysql1.dart';

class DatabaseProvider {
  // Patron Singleton
  static DatabaseProvider? _instance;

  factory DatabaseProvider({String? database, String? userName, String? password}) {
    if (_instance == null) {
      _instance = DatabaseProvider._(
        database: database,
        userName: userName,
        password: password,
      );
    }
    return _instance!;
  }

  DatabaseProvider._({required String? database, required String? userName, required String? password}) {
    dbName = database;
    usrName = userName;
    pass = password;
  }

  String? dbName;
  String? usrName;
  String? pass;
  MySqlConnection? database;

  Future<void> connectDb() async {
    try {
      ConnectionSettings settings = new ConnectionSettings(
        host: 'sql5.freemysqlhosting.net',
        port: 3306,
        user: this.usrName,
        password: this.pass,
        db: this.dbName,
      );
      database = await MySqlConnection.connect(settings);
      print("Connected to $database");
    } catch (e) {
      print("Error : $e");
    }
  }

  Future<bool> loginUsuario(LoginModel usuarioLogin) async {
    try {
      if (database != null) {
        final Results resultado = await database!.query(
          "SELECT usuario, id_login FROM login WHERE usuario = '${usuarioLogin.usuario}' AND password = '${usuarioLogin.pass}'",
        );
        if (resultado.length > 0) {
          print("Encontrado");
          return true;
        } else {
          print('No hay resultados');
          return false;
        }
      }
      return false;
    } catch (e) {
      print(e);
      return false;
    }
  }
}
