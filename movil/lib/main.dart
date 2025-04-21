import 'dart:io';
import 'crud.dart';

void main() async {
  var db = Database();

  List<String> opciones = [
    'Mostrar usuarios',
    'Insertar usuario',
    'Actualizar usuario',
    'Eliminar usuario',
    'Salir'
  ];

  while (true) {
    print('\n=== Menú de Opciones ===');
    for (int i = 0; i < opciones.length; i++) {
      print('${i + 1}. ${opciones[i]}');
    }

    stdout.write('\nSelecciona una opción (1-${opciones.length}): ');
    int? opcion = int.tryParse(stdin.readLineSync()!);

    switch (opcion) {
      case 1:
        var usuarios = await db.getUsuarios();
        usuarios.forEach((u) => print(u));
        break;

      case 2:
        stdout.write('Nombre: ');
        String nombre = stdin.readLineSync()!;
        stdout.write('Email: ');
        String email = stdin.readLineSync()!;
        stdout.write('Fecha nacimiento (AAAA-MM-DD): ');
        String fecha = stdin.readLineSync()!;
        stdout.write('Edad: ');
        int edad = int.parse(stdin.readLineSync()!);

        await db.insertUsuario(nombre, email, fecha, edad);
        break;

      case 3:
        stdout.write('ID del usuario a actualizar: ');
        int id = int.parse(stdin.readLineSync()!);
        stdout.write('Nuevo nombre: ');
        String nombre = stdin.readLineSync()!;
        stdout.write('Nuevo email: ');
        String email = stdin.readLineSync()!;
        stdout.write('Nueva fecha nacimiento (YYYY-MM-DD): ');
        String fecha = stdin.readLineSync()!;
        stdout.write('Nueva edad: ');
        int edad = int.parse(stdin.readLineSync()!);

        await db.updateUsuario(id, nombre, email, fecha, edad);
        break;

      case 4:
        stdout.write('ID del usuario a eliminar: ');
        int id = int.parse(stdin.readLineSync()!);
        await db.deleteUsuario(id);
        break;

      case 5:
        print('Se salio del programa');
        return;

      default:
        print('Opción inválida. Intenta de nuevo.');
    }
  }
}
