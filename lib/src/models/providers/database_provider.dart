class DatabaseProvider {
  // Patron Singleton
  static DatabaseProvider? _instance;

  factory DatabaseProvider({required String? database, required String? userName, required String? password}) {
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
    db = database;
    usrName = userName;
    pass = password;
  }

  String? db;
  String? usrName;
  String? pass;
}
