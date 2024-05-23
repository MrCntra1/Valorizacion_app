import 'package:flutter/material.dart';
import 'valorizaciones.dart';

class EditarValorizacionScreen extends StatefulWidget {
  final Valorizacion valorizacion;

  const EditarValorizacionScreen({super.key, required this.valorizacion});

  @override
  _EditarValorizacionScreenState createState() =>
      _EditarValorizacionScreenState();
}

class _EditarValorizacionScreenState extends State<EditarValorizacionScreen> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _numeroOrdenController;
  late TextEditingController _montoContratoController;
  late TextEditingController _nombreContratistaController;
  late TextEditingController _descripcionServicioController;
  late TextEditingController _fechaServicioController;
  late TextEditingController _nombreServicioController;
  late TextEditingController _cantidadTotalController;

  @override
  void initState() {
    super.initState();
    _numeroOrdenController =
        TextEditingController(text: widget.valorizacion.numeroOrden);
    _montoContratoController = TextEditingController(
        text: widget.valorizacion.montoContrato.toString());
    _nombreContratistaController =
        TextEditingController(text: widget.valorizacion.nombreContratista);
    _descripcionServicioController =
        TextEditingController(text: widget.valorizacion.descripcionServicio);
    _fechaServicioController = TextEditingController(
        text: widget.valorizacion.fechaServicio.toString());
    _nombreServicioController =
        TextEditingController(text: widget.valorizacion.nombreServicio);
    _cantidadTotalController = TextEditingController(
        text: widget.valorizacion.cantidadTotal.toString());
  }

  void _saveForm() {
    if (_formKey.currentState!.validate()) {
      final updatedValorizacion = Valorizacion(
        numeroOrden: _numeroOrdenController.text,
        montoContrato: widget.valorizacion.montoContrato,
        nombreContratista: _nombreContratistaController.text,
        descripcionServicio: _descripcionServicioController.text,
        fechaServicio: DateTime.parse(_fechaServicioController.text),
        nombreServicio: _nombreServicioController.text,
        cantidadTotal: double.parse(_cantidadTotalController.text),
      );
      Navigator.of(context).pop(updatedValorizacion);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Editar Valorización'),
        backgroundColor: Colors.blue,
      ),
      body: Container(
        padding: const EdgeInsets.all(16.0),
        decoration: const BoxDecoration(
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
              _buildTextField(_cantidadTotalController, 'Cantidad Total m3',
                  keyboardType: TextInputType.number),
              _buildTextField(_montoContratoController, 'Monto del Contrato',
                  keyboardType: TextInputType.number, readOnly: true),
              _buildTextField(
                  _nombreContratistaController, 'Nombre del Contratista'),
              _buildTextField(
                  _descripcionServicioController, 'Descripción del Servicio'),
              _buildTextField(_fechaServicioController, 'Fecha del Servicio',
                  keyboardType: TextInputType.datetime),
              _buildTextField(_nombreServicioController, 'Nombre del Servicio'),
              const SizedBox(height: 20),
              ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
                onPressed: _saveForm,
                child: const Text(
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
      {TextInputType keyboardType = TextInputType.text,
      bool readOnly = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextFormField(
        controller: controller,
        keyboardType: keyboardType,
        readOnly: readOnly,
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
