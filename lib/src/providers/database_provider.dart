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
    _dbName = database;
    _usrName = userName;
    _pass = password;
  }

  String? _dbName;
  String? _usrName;
  String? _pass;
  MySqlConnection? _database;

  Future<void> connectDb() async {
    try {
      ConnectionSettings settings = new ConnectionSettings(
        host: 'sql5.freemysqlhosting.net',
        port: 3306,
        user: this._usrName,
        password: this._pass,
        db: this._dbName,
      );
      _database = await MySqlConnection.connect(settings);
      print("Connected to $_database");
    } catch (e) {
      print("Error : $e");
    }
  }

  Future<bool> loginUsuario(LoginModel usuarioLogin) async {
    try {
      if (_database != null) {
        final Results resultado = await _database!.query(
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

  Future<List<UsuarioModel>> obtenerTodosLosUsuarios([String? orderBy]) async {
    String query = "SELECT usuario, pais, estado, genero FROM usuarios";
    List<UsuarioModel> usuarios = [];
    try {
      if (_database != null) {
        if (orderBy != null) {
          query += " ORDER BY '$orderBy'";
        }
        final resultado = await _database!.query(query);
        if (resultado.length > 0) {
          resultado.forEach((element) {
            // print(element.values);
            final tempValues = element.values;
            final tempUsr = UsuarioModel(
              usuario: tempValues!.elementAt(0).toString(),
              pais: tempValues.elementAt(1).toString(),
              estado: tempValues.elementAt(2).toString(),
              genero: tempValues.elementAt(3).toString(),
            );
            usuarios.add(tempUsr);
          });
        }
        return usuarios;
      } else {
        return [];
      }
    } catch (e) {
      print(e);
      return [];
    }
  }

  Future<void> agregarRegistroUsuario(UsuarioModel usuario) async {
    try {
      if (_database != null) {
        final res = await _database!.query("INSERT INTO usuarios (usuario, pais, estado, genero) VALUES (?, ?, ?, ?)", [
          usuario.usuario,
          usuario.pais,
          usuario.estado,
          usuario.genero,
        ]);
        print("Filas afectadas: ${res.affectedRows}");
      }
    } catch (e) {
      // TODO
      print(e);
    }
  }

  Future<void> borrarUsuario(UsuarioModel usuario) async {
    try {
      if (_database != null) {
        final res = await _database!.query("DELETE FROM usuarios WHERE usuario = ? AND pais = ? AND estado = ?", [
          usuario.usuario,
          usuario.pais,
          usuario.estado,
        ]);
        print("Filas afectadas: ${res.affectedRows}");
      }
    } catch (e) {
      // TODO
      print(e);
    }
  }
}
