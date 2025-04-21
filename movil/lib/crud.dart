import 'package:mysql1/mysql1.dart';

class Database {
final ConnectionSettings settings = ConnectionSettings(
    host: '127.0.0.1',
    port: 3306,
    user: 'dart_user',
    password: 'Abcd1234*',
    db: 'juancho'
  );

  // Conexión a la base de datos
  // Muestra los registros de la tabla usuario
  Future<List<Map<String, dynamic>>> getUsuarios() async {
    final conn = await MySqlConnection.connect(settings);
    print('Conexión exitosa a la base de datos'); // Mensaje de conexión exitosa
    try {
      var results = await conn.query('SELECT * FROM usuarios');
      return results.map((row) => row.fields).toList();
    } finally {
      await conn.close();
    }
  }

  // Inserta un nuevo usuario en la tabla usuario
  Future<void> insertUsuario(
    String nombre,
    String email,
    String fechanacimiento,
    int edad,
  ) async {
    final conn = await MySqlConnection.connect(settings);
    print(
      'Conexión exitosa a la base de datos para insertar',
    ); // Mensaje de conexión exitosa
    try {
      await conn.query(
        'INSERT INTO usuarios (nombre, email, fecha_nacimiento, edad) VALUES (?, ?, ?, ?)',
        [nombre, email, fechanacimiento, edad],
      );
      print(
        'Usuario insertado exitosamente: $nombre, $email, $fechanacimiento, $edad',
      );
    } catch (e) {
      print('Error al insertar el usuario: $e');
    } finally {
      await conn.close();
    }
  }

  // Actualiza un usuario en la tabla usuarios
  Future<void> updateUsuario(
    int id,
    String nombre,
    String email,
    String fechanacimiento,
    int edad,
  ) async {
    final conn = await MySqlConnection.connect(settings);
    print(
      'Conexión exitosa a la base de datos para actualizar',
    ); // Mensaje de conexión exitosa
    try {
      await conn.query(
        'UPDATE usuarios SET nombre = ?, email = ?, fecha_nacimiento = ?, edad = ? WHERE id = ?',
        [nombre, email, fechanacimiento, edad, id],
      );
      print(
        'Usuario actualizado exitosamente: ID $id, $nombre, $email, $fechanacimiento, $edad',
      );
    } catch (e) {
      print('Error al actualizar el usuario: $e');
    } finally {
      await conn.close();
    }
  }

  // Elimina un usuario en la tabla usuarios
  Future<void> deleteUsuario(int id) async {
    final conn = await MySqlConnection.connect(settings);
    print(
      'Conexión exitosa a la base de datos para eliminar',
    ); // Mensaje de conexión exitosa
    try {
      await conn.query('DELETE FROM usuarios WHERE id = ?', [id]);
      print('Usuario eliminado exitosamente: ID $id');
    } catch (e) {
      print('Error al eliminar el usuario: $e');
    } finally {
      await conn.close();
    }
  }
}

void main() async {
  var db = Database();

  // Función para obtener usuarios
  Future<void> obtenerUsuarios() async {
    try {
      var usuarios = await db.getUsuarios();
      print('Usuarios obtenidos:');
      for (var usuario in usuarios) {
        print(usuario);
      }
    } catch (e) {
      print('Error al obtener los usuarios: $e');
    }
  }

  // Función para insertar un usuario
  Future<void> insertarUsuario(
    String nombre,
    String email,
    String fechanacimiento,
    int edad,
  ) async {
    try {
      await db.insertUsuario(nombre, email, fechanacimiento, edad);
    } catch (e) {
      print('Error al insertar el usuario: $e');
    }
  }

  // Función para actualizar un usuario
  Future<void> actualizarUsuario(
    int id,
    String nombre,
    String email,
    String fechanacimiento,
    int edad,
  ) async {
    try {
      await db.updateUsuario(id, nombre, email, fechanacimiento, edad);
    } catch (e) {
      print('Error al actualizar el usuario: $e');
    }
  }

  // Función para eliminar un usuario 
  Future<void> eliminarUsuario(int id) async {
    try {
      await db.deleteUsuario(id);
    } catch (e) {
      print('Error al eliminar el usuario: $e');
    }
  }
}