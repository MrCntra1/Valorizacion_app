import 'package:flutter/material.dart';
import 'global_config.dart';
import 'package:provider/provider.dart';

class ConfiguracionPage extends StatefulWidget {
  const ConfiguracionPage({super.key});

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
          title: const Text('Editar cantidad de valor de arena por m³'),
          content: TextField(
            controller: _valorController,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
              hintText: 'Ingrese un valor numérico',
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancelar'),
            ),
            TextButton(
              onPressed: () {
                final valor = double.tryParse(_valorController.text) ?? 0.0;
                Provider.of<GlobalConfig>(context, listen: false)
                    .setMultiplicador(valor);
                Navigator.of(context).pop();
              },
              child: const Text('Aceptar'),
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
        title: const Text('Configuración'),
        backgroundColor: Colors.blue,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: Container(
        padding: const EdgeInsets.all(8.0),
        child: ListView(
          children: [
            ListTile(
              leading: const Icon(Icons.person),
              title: const Text('Perfil'),
              onTap: () {
                // Acción cuando se toca el perfil
              },
            ),
            ListTile(
              leading: const Icon(Icons.notifications),
              title: const Text('Notificaciones'),
              onTap: () {
                // Acción cuando se tocan las notificaciones
              },
            ),
            ListTile(
              leading: const Icon(Icons.security),
              title: const Text('Seguridad'),
              onTap: () {
                // Acción cuando se toca la seguridad
              },
            ),
            ListTile(
              leading: const Icon(Icons.help),
              title: const Text('Ayuda'),
              onTap: () {
                // Acción cuando se toca la ayuda
              },
            ),
            ListTile(
              leading: const Icon(Icons.edit),
              title: const Text('Editar Valores'),
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
