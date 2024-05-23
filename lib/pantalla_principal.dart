import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'detalles_valorizacion.dart';
import 'valorizaciones.dart';
import 'creacion_valorizacion.dart';
import 'configuracion.dart';
import 'global_config.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<Valorizacion> valorizaciones = [];

  void _addValorizacion(Valorizacion valorizacion) {
    setState(() {
      valorizaciones.add(valorizacion);
    });
  }

  @override
  Widget build(BuildContext context) {
    
    return ChangeNotifierProvider(
      // Envuelve el Scaffold con ChangeNotifierProvider
      create: (_) => globalConfig, // Cambia esto a builder
      builder: (context, child) {
        // Añade este builder
        return Scaffold(
          
          appBar: AppBar(
            title: Text('Valorizaciones'),
            backgroundColor: Colors.blue,
            actions: [
              IconButton(
                icon: Icon(Icons.settings),
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => ConfiguracionPage(),
                      settings: RouteSettings(arguments: "From Home"),
                    ),
                  );
                },
              ),
            ],
          ),
          body: Container(
            padding: EdgeInsets.all(8.0),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.white, Colors.white],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.search),
                      hintText: 'Buscar valorización',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: valorizaciones.length,
                    itemBuilder: (context, index) {
                      final valorizacion = valorizaciones[index];
                      return Card(
                        child: ListTile(
                          title:
                              Text('Valorización #${valorizacion.numeroOrden}'),
                          subtitle: Text(
                              '${valorizacion.descripcionServicio}\nRestante: ${valorizacion.cantidadRestante} m3'),
                          trailing: Icon(Icons.arrow_forward_ios),
                          onTap: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => DetalleValorizacion(
                                    valorizacion: valorizacion),
                              ),
                            );
                          },
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
          bottomNavigationBar: BottomAppBar(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                IconButton(
                  icon: Icon(Icons.home),
                  onPressed: () {},
                ),
                IconButton(
                  icon: Image.asset('lib/img/add-file.png'),
                  onPressed: () async {
                    final result = await Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => NuevaValorizacion(),
                      ),
                    );
                    if (result != null) {
                      _addValorizacion(result);
                    }
                  },
                ),
              ],
            ),
          ),
        );
      }, // Cierra el builder
    ); // Cierra ChangeNotifierProvider
  }
}
