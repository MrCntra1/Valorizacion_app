import 'package:flutter/material.dart';

class Configuracion extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Configuración'),
        backgroundColor: Colors.blue,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: Container(
        padding: EdgeInsets.all(8.0),
        child: ListView(
          children: [
            ListTile(
              leading: Icon(Icons.person),
              title: Text('Perfil'),
              onTap: () {
                // Acción cuando se toca el perfil
              },
            ),
            ListTile(
              leading: Icon(Icons.notifications),
              title: Text('Notificaciones'),
              onTap: () {
                // Acción cuando se tocan las notificaciones
              },
            ),
            ListTile(
              leading: Icon(Icons.security),
              title: Text('Seguridad'),
              onTap: () {
                // Acción cuando se toca la seguridad
              },
            ),
            ListTile(
              leading: Icon(Icons.help),
              title: Text('Ayuda'),
              onTap: () {
                // Acción cuando se toca la ayuda
              },
            ),
            ListTile(
              leading: Icon(Icons.help),
              title: Text('Editar Valores'),
              onTap: () {
                // Acción cuando se toca la ayuda
              },
            ),
          ],
        ),
      ),
    );
  }
}
