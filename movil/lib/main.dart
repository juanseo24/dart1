import 'dart:io';
import 'crud.dart'; // Importa el archivo CRUD

void main() async {
  var db = Database();
  bool salir = false;

  while (!salir) {
    print('\n===== CRUD de Usuarios (Dart + MySQL) =====');
    print('1. Listar usuarios');
    print('2. Insertar usuario');
    print('3. Actualizar usuario');
    print('4. Eliminar usuario');
    print('5. Salir');
    stdout.write('Selecciona una opción: ');
    String? opcion = stdin.readLineSync();

    switch (opcion) {
      case '1':
        var usuarios = await db.getUsuarios();
        print('\n--- Lista de usuarios ---');
        for (var u in usuarios) {
          print(u);
        }
        break;

      case '2':
        stdout.write('Nombre: ');
        String? nombre = stdin.readLineSync();
        stdout.write('Email: ');
        String? email = stdin.readLineSync();
        stdout.write('Fecha de nacimiento (YYYY-MM-DD): ');
        String? fecha = stdin.readLineSync();
        stdout.write('Edad: ');
        int? edad = int.tryParse(stdin.readLineSync() ?? '');

        if (nombre != null && email != null && fecha != null && edad != null) {
          await db.insertUsuario(nombre, email, fecha, edad);
        } else {
          print('Datos inválidos');
        }
        break;

      case '3':
        stdout.write('ID del usuario a actualizar: ');
        int? id = int.tryParse(stdin.readLineSync() ?? '');
        stdout.write('Nuevo nombre: ');
        String? nombre = stdin.readLineSync();
        stdout.write('Nuevo email: ');
        String? email = stdin.readLineSync();
        stdout.write('Nueva fecha de nacimiento (YYYY-MM-DD): ');
        String? fecha = stdin.readLineSync();
        stdout.write('Nueva edad: ');
        int? edad = int.tryParse(stdin.readLineSync() ?? '');

        if (id != null && nombre != null && email != null && fecha != null && edad != null) {
          await db.updateUsuario(id, nombre, email, fecha, edad);
        } else {
          print('Datos inválidos');
        }
        break;

      case '4':
        stdout.write('ID del usuario a eliminar: ');
        int? id = int.tryParse(stdin.readLineSync() ?? '');
        if (id != null) {
          await db.deleteUsuario(id);
        } else {
          print(' ID inválido');
        }
        break;

      case '5':
        print('Saliendo...');
        salir = true;
        break;

      default:
        print('Opción no válida');
        break;
    }
  }
}
