import 'package:flutter/material.dart';
import '../models/valorization.dart';

class ValorizationCard extends StatelessWidget {
  final Valorization valorization;
  final Function onEdit;
  final Function onDelete;
  final Function onDownload;

  ValorizationCard({
    required this.valorization,
    required this.onEdit,
    required this.onDelete,
    required this.onDownload,
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
              icon: Icon(Icons.edit),
              onPressed: () => onEdit(valorization),
            ),
            IconButton(
              icon: Icon(Icons.delete),
              onPressed: () => onDelete(valorization),
            ),
            IconButton(
              icon: Icon(Icons.download),
              onPressed: () => onDownload(valorization),
            ),
          ],
        ),
      ),
    );
  }
}
