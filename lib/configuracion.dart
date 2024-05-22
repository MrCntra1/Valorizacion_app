import 'package:flutter/material.dart';
import 'global_config.dart';
import 'package:provider/provider.dart';

class ConfiguracionPage extends StatefulWidget {
  @override
  _ConfiguracionPageState createState() => _ConfiguracionPageState();
}

class _ConfiguracionPageState extends State<ConfiguracionPage> {
  final _valorController = TextEditingController();

  @override
  void dispose() {
    _valorController.dispose();
    super.dispose();
  }

  void _mostrarDialogoEditarValor(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Editar cantidad de valor de arena por m³'),
          content: TextField(
            controller: _valorController,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              hintText: 'Ingrese un valor numérico',
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancelar'),
            ),
            TextButton(
              onPressed: () {
                final valor = double.tryParse(_valorController.text) ?? 0.0;
                Provider.of<GlobalConfig>(context, listen: false)
                    .setMultiplicador(valor);
                Navigator.of(context).pop();
              },
              child: Text('Aceptar'),
            ),
          ],
        );
      },
    );
  }

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
              leading: Icon(Icons.edit),
              title: Text('Editar Valores'),
              onTap: () {
                _mostrarDialogoEditarValor(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}
