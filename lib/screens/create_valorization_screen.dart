import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/valorization.dart';

class CreateValorizationScreen extends StatefulWidget {
  @override
  _CreateValorizationScreenState createState() => _CreateValorizationScreenState();
}

class _CreateValorizationScreenState extends State<CreateValorizationScreen> {
  final TextEditingController _orderNumberController = TextEditingController();
  final TextEditingController _quantityController = TextEditingController();
  final TextEditingController _contractAmountController = TextEditingController();
  final TextEditingController _contractorNameController = TextEditingController();
  final TextEditingController _serviceDescriptionController = TextEditingController();
  final TextEditingController _serviceNameController = TextEditingController();
  DateTime _serviceDate = DateTime.now();

  @override
  void initState() {
    super.initState();
    _orderNumberController.text = 'VA-000001'; // This should be auto-generated
  }

  _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _serviceDate,
      firstDate: DateTime(2020),
      lastDate: DateTime(2030),
    );
    if (picked != null && picked != _serviceDate)
      setState(() {
        _serviceDate = picked;
      });
  }

  _saveValorization() {
    final newValorization = Valorization(
      orderNumber: _orderNumberController.text,
      totalQuantity: double.parse(_quantityController.text),
      contractAmount: double.parse(_contractAmountController.text),
      contractorName: _contractorNameController.text,
      serviceDescription: _serviceDescriptionController.text,
      serviceDate: _serviceDate,
      serviceName: _serviceNameController.text,
    );
    Navigator.pop(context, newValorization);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Create Valorization'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            TextField(
              controller: _orderNumberController,
              decoration: InputDecoration(labelText: 'Order Number'),
              readOnly: true,
            ),
            TextField(
              controller: _quantityController,
              decoration: InputDecoration(labelText: 'Total Quantity in m3'),
              keyboardType: TextInputType.number,
            ),
            TextField(
              controller: _contractAmountController,
              decoration: InputDecoration(labelText: 'Contract Amount'),
              keyboardType: TextInputType.number,
            ),
            TextField(
              controller: _contractorNameController,
              decoration: InputDecoration(labelText: 'Contractor Name'),
            ),
            TextField(
              controller: _serviceDescriptionController,
              decoration: InputDecoration(labelText: 'Service Description'),
            ),
            ListTile(
              title: Text("Service Date: ${DateFormat('dd/MM/yyyy').format(_serviceDate)}"),
              trailing: Icon(Icons.calendar_today),
              onTap: () => _selectDate(context),
            ),
            TextField(
              controller: _serviceNameController,
              decoration: InputDecoration(labelText: 'Service Name'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _saveValorization,
              child: Text('Save'),
            ),
          ],
        ),
      ),
    );
  }
}
