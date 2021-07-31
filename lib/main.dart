import 'package:flutter/material.dart';
import 'package:examen_webmaps/src/providers/database_provider.dart';
import 'package:examen_webmaps/src/pages/login_page.dart';

final _db = DatabaseProvider(
  database: 'sql5428484',
  userName: 'sql5428484',
  password: 'aWVJ8AwBK3',
);
Future<void> main() async {
  await _db.connectDb();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material App',
      home: LoginPage(),
    );
  }
}
