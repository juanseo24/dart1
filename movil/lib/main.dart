import 'package:mysql1/mysql1.dart';

class Database {
  final ConnectionSettings settings = ConnectionSettings(
    host: '127.0.0.1',
    port: 3306,
    user: 'dart_user',
    password: 'Abcd1234*',
    db: 'juancho'
  );

  Future<List<Map<String, dynamic>>> getProducts() async {
  final conn = await MySqlConnection.connect(settings);
  print('Conexión exitosa a la base de datos'); // Mensaje de conexión

  try {
    var results = await conn.query('SELECT * FROM usuarios');
    return results.map((row) => row.fields).toList();
  } finally {
    await conn.close();
  }
  }
}

void main() async {
  var db = Database();

  try {
    var products = await db.getProducts();
    print('Productos obtenidos:');
    for (var product in products) {
      print(product);
    }
  } catch (e) {
    print('Error al obtener los productos: $e');
  }
}