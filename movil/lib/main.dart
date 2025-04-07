import 'package:mysql1/mysql1.dart';

class Database {
  final ConnectionSettings settings = ConnectionSettings(
    host: '127.0.0.1',
    port: 3306,
    user: 'dart_user',
    password: 'Abcd1234*',
    db: 'adso25'
  );

  Future<void> testConnection() async {
    try {
      final conn = await MySqlConnection.connect(settings);
      print(
          'Conexión exitosa a la base de datos'); // Mensaje de conexión exitosa
      await conn.close();
    } catch (e) {
      print('Error al conectar a la base de datos: $e'); // Mensaje de error
    }
  }
}

void main() async {
  var db = Database();

  // Probar la conexión a la base de datos
  await db.testConnection();
}
