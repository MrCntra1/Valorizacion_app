import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'global_config.dart';
import 'valorizaciones.dart';

class NuevaValorizacion extends StatefulWidget {
  @override
  _NuevaValorizacionState createState() => _NuevaValorizacionState();
}

class _NuevaValorizacionState extends State<NuevaValorizacion> {
  final _formKey = GlobalKey<FormState>();
  final _numeroOrdenController = TextEditingController();
  final _nombreContratistaController = TextEditingController();
  final _descripcionServicioController = TextEditingController();
  final _fechaServicioController = TextEditingController();
  final _nombreServicioController = TextEditingController();
  final _cantidadTotalController = TextEditingController();
  double _resultado = 0.0;
  DateTime? _selectedDate;

  @override
  void initState() {
    super.initState();
    _cantidadTotalController.addListener(_calcularResultado);
  }

  @override
  void dispose() {
    _numeroOrdenController.dispose();
    _nombreContratistaController.dispose();
    _descripcionServicioController.dispose();
    _fechaServicioController.dispose();
    _nombreServicioController.dispose();
    _cantidadTotalController.dispose();
    super.dispose();
  }

  void _calcularResultado() {
    final cantidad = double.tryParse(_cantidadTotalController.text) ?? 0.0;
    final multiplicador =
        Provider.of<GlobalConfig>(context, listen: false).multiplicador;
    setState(() {
      _resultado = cantidad * multiplicador;
    });
  }

  void _saveForm() {
    if (_formKey.currentState!.validate()) {
      final nuevaValorizacion = Valorizacion(
        numeroOrden: _numeroOrdenController.text,
        montoContrato: _resultado,
        nombreContratista: _nombreContratistaController.text,
        descripcionServicio: _descripcionServicioController.text,
        fechaServicio: _selectedDate!,
        nombreServicio: _nombreServicioController.text,
        cantidadTotal: double.parse(_cantidadTotalController.text),
      );

      Navigator.of(context).pop(nuevaValorizacion);
    }
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
        _fechaServicioController.text = DateFormat('yyyy-MM-dd').format(picked);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      appBar: AppBar(
        title: Text('Nueva Valorización'),
        backgroundColor: Colors.blue,
      ),
      body: Container(
        padding: EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.white, Colors.white],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              _buildTextField(_numeroOrdenController, 'Número de Orden'),
              _buildTextField(_cantidadTotalController, 'Cantidad Total en m3',
                  keyboardType: TextInputType.number),
              SizedBox(height: 16.0),
              Consumer<GlobalConfig>(
                builder: (context, config, child) {
                  return Text(
                      'Monto de contrato: ${_cantidadTotalController.text.isEmpty ? 0 : _resultado}');
                },
              ),
              SizedBox(height: 16.0),
              _buildTextField(
                  _nombreContratistaController, 'Nombre del Contratista'),
              _buildTextField(
                  _descripcionServicioController, 'Descripción del Servicio'),
              GestureDetector(
                onTap: () => _selectDate(context),
                child: AbsorbPointer(
                  child: _buildTextField(
                      _fechaServicioController, 'Fecha del Servicio',
                      keyboardType: TextInputType.datetime),
                ),
              ),
              _buildTextField(_nombreServicioController, 'Nombre del Servicio'),
              SizedBox(height: 20),
              ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
                onPressed: _saveForm,
                child: Text(
                  'Guardar',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(TextEditingController controller, String label,
      {TextInputType keyboardType = TextInputType.text}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextFormField(
        controller: controller,
        keyboardType: keyboardType,
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Por favor ingrese $label';
          }
          return null;
        },
      ),
    );
  }
}
