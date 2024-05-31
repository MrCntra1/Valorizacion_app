import 'package:flutter/material.dart';
import '../models/valorization.dart';
import 'package:intl/intl.dart';

class ViewValorizationScreen extends StatelessWidget {
  final Valorization valorization;

  ViewValorizationScreen({Key? key, required this.valorization})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('View Valorization'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            ListTile(
              title: Text('Order Number'),
              subtitle: Text(valorization.orderNumber),
            ),
            ListTile(
              title: Text('Total Quantity in m3'),
              subtitle: Text(valorization.totalQuantity.toString()),
            ),
            ListTile(
              title: Text('Contract Amount'),
              subtitle: Text(valorization.contractAmount.toString()),
            ),
            ListTile(
              title: Text('Contractor Name'),
              subtitle: Text(valorization.contractorName),
            ),
            ListTile(
              title: Text('Service Description'),
              subtitle: Text(valorization.serviceDescription),
            ),
            ListTile(
              title: Text('Service Date'),
              subtitle: Text(
                  DateFormat('dd/MM/yyyy').format(valorization.serviceDate)),
            ),
            ListTile(
              title: Text('Service Name'),
              subtitle: Text(valorization.serviceName),
            ),
          ],
        ),
      ),
    );
  }
}
