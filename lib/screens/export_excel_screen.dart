import 'package:flutter/material.dart';
import 'dart:io';

class ExportExcelScreen extends StatelessWidget {
  final String filePath;

  const ExportExcelScreen({Key? key, required this.filePath}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Exportar Excel'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () async {
            final file = File(filePath);
            if (await file.exists()) {
              // Aquí puedes manejar la lógica para exportar el archivo,
              // como guardarlo en una ubicación específica o compartirlo.
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Archivo exportado exitosamente')),
              );
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Error al exportar el archivo')),
              );
            }
          },
          child: Text('Exportar Archivo'),
        ),
      ),
    );
  }
}
