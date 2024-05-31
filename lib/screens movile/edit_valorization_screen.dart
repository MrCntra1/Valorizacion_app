import 'package:flutter/material.dart';
import '../models/valorization.dart';
import 'package:intl/intl.dart';

class EditValorizationScreen extends StatefulWidget {
  final Valorization valorization;

  EditValorizationScreen({Key? key, required this.valorization})
      : super(key: key);

  @override
  _EditValorizationScreenState createState() => _EditValorizationScreenState();
}

class _EditValorizationScreenState extends State<EditValorizationScreen> {
  late TextEditingController _quantityController;
  late TextEditingController _contractAmountController;
  late TextEditingController _contractorNameController;
  late TextEditingController _serviceDescriptionController;
  late TextEditingController _serviceNameController;
  late DateTime _serviceDate;

  @override
  void initState() {
    super.initState();
    _quantityController = TextEditingController(
        text: widget.valorization.totalQuantity.toString());
    _contractAmountController = TextEditingController(
        text: widget.valorization.contractAmount.toString());
    _contractorNameController =
        TextEditingController(text: widget.valorization.contractorName);
    _serviceDescriptionController =
        TextEditingController(text: widget.valorization.serviceDescription);
    _serviceNameController =
        TextEditingController(text: widget.valorization.serviceName);
    _serviceDate = widget.valorization.serviceDate;
  }

  _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _serviceDate,
      firstDate: DateTime(2020),
      lastDate: DateTime(2030),
    );
    if (picked != null && picked != _serviceDate) {
      setState(() {
        _serviceDate = picked;
      });
    }
  }

  _saveValorization() {
    setState(() {
      widget.valorization.totalQuantity =
          double.parse(_quantityController.text);
      widget.valorization.contractAmount =
          double.parse(_contractAmountController.text);
      widget.valorization.contractorName = _contractorNameController.text;
      widget.valorization.serviceDescription =
          _serviceDescriptionController.text;
      widget.valorization.serviceDate = _serviceDate;
      widget.valorization.serviceName = _serviceNameController.text;
    });
    Navigator.pop(context, widget.valorization);
  }

  @override
  void dispose() {
    _quantityController.dispose();
    _contractAmountController.dispose();
    _contractorNameController.dispose();
    _serviceDescriptionController.dispose();
    _serviceNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Valorization'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
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
              title: Text(
                  "Service Date: ${DateFormat('dd/MM/yyyy').format(_serviceDate)}"),
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
