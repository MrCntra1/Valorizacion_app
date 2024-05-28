import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/valorization.dart';
import '../widgets/valorization_card.dart';
import 'edit_values_screen.dart';
import 'create_valorization_screen.dart';
import 'edit_valorization_screen.dart';
import '../services/excel_service.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<Valorization> valorizations = []; // Lista de valorizaciones
  final ExcelService excelService = ExcelService();
  String searchQuery = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('RaymiApp'),
        actions: [
          PopupMenuButton<String>(
            onSelected: (value) {
              if (value == 'Edit Values') {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => EditValuesScreen()),
                );
              }
              // Add more actions here for other menu options
            },
            itemBuilder: (BuildContext context) {
              return {'Profile', 'Notifications', 'Security', 'Help', 'Edit Values'}
                  .map((String choice) {
                return PopupMenuItem<String>(
                  value: choice,
                  child: Text(choice),
                );
              }).toList();
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Buscar valorizaciones',
                prefixIcon: Icon(Icons.search),
              ),
              onChanged: (value) {
                setState(() {
                  searchQuery = value;
                });
              },
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: valorizations.length,
              itemBuilder: (context, index) {
                final valorization = valorizations[index];
                if (valorization.orderNumber.contains(searchQuery) ||
                    valorization.serviceDescription.contains(searchQuery)) {
                  return ValorizationCard(
                    valorization: valorization,
                    onEdit: (valorization) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => EditValorizationScreen(valorization: valorization),
                        ),
                      );
                    },
                    onDelete: (valorization) {
                      setState(() {
                        valorizations.remove(valorization);
                      });
                    },
                    onDownload: (valorization) async {
                      await excelService.createAndDownloadExcel([valorization]);
                    },
                  );
                }
                return Container();
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final newValorization = await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => CreateValorizationScreen()),
          );
          if (newValorization != null) {
            setState(() {
              valorizations.add(newValorization);
            });
          }
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
