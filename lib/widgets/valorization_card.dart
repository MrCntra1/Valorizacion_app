import 'package:flutter/material.dart';
import '../models/valorization.dart';

class ValorizationCard extends StatelessWidget {
  final Valorization valorization;
  final Function(Valorization) onView;
  final Function(Valorization) onEdit;
  final Function(Valorization) onDelete;
  final Function(Valorization) onExport;

  ValorizationCard({
    required this.valorization,
    required this.onView,
    required this.onEdit,
    required this.onDelete,
    required this.onExport,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(valorization.orderNumber),
        subtitle: Text(valorization.serviceDescription),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              icon: Icon(Icons.visibility),
              onPressed: () => onView(valorization),
            ),
            IconButton(
              icon: Icon(Icons.edit),
              onPressed: () => onEdit(valorization),
            ),
            IconButton(
              icon: Icon(Icons.delete),
              onPressed: () => onDelete(valorization),
            ),
            IconButton(
              icon: Icon(Icons.upload_file),
              onPressed: () => onExport(valorization),
            ),
          ],
        ),
      ),
    );
  }
}
