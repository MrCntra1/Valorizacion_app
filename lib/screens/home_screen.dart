import 'package:flutter/material.dart';
import '../models/valorization.dart';
import '../widgets/valorization_card.dart';
import 'edit_values_screen.dart';
import 'create_valorization_screen.dart';
import 'edit_valorization_screen.dart';
import '../services/excel_service.dart';

class HomeScreen extends StatelessWidget {
  final List<Valorization> valorizations = []; // Replace with your data source
  final ExcelService excelService = ExcelService();

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
              return {
                'Profile',
                'Notifications',
                'Security',
                'Help',
                'Edit Values'
              }.map((String choice) {
                return PopupMenuItem<String>(
                  value: choice,
                  child: Text(choice),
                );
              }).toList();
            },
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: valorizations.length,
        itemBuilder: (context, index) {
          final valorization = valorizations[index];
          return ValorizationCard(
            valorization: valorization,
            onEdit: (valorization) {
              // Navigate to edit screen
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      EditValorizationScreen(valorization: valorization),
                ),
              );
            },
            onDelete: (valorization) {
              // Handle delete
              // Remove valorization from list and update state
              // Add your delete logic here
            },
            onDownload: (valorization) async {
              // Handle download
              await excelService.createAndDownloadExcel([valorization]);
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => CreateValorizationScreen()),
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
