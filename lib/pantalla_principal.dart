import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'valorizaciones.dart';
import 'creacion_valorizacion.dart';
import 'configuracion.dart';
import 'global_config.dart';
import 'detalle_valorizacion_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Home extends StatefulWidget {
  const Home({Key? key});

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
      create: (_) => globalConfig,
      builder: (context, child) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('Valorizaciones'),
            backgroundColor: Colors.blue,
            actions: [
              IconButton(
                icon: const Icon(Icons.settings),
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => ConfiguracionPage(),
                      settings: const RouteSettings(arguments: "From Home"),
                    ),
                  );
                },
              ),
            ],
          ),
          body: Container(
            padding: const EdgeInsets.all(8.0),
            decoration: const BoxDecoration(
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
                      prefixIcon: const Icon(Icons.search),
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
                          trailing: const Icon(Icons.arrow_forward_ios),
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
                  icon: const Icon(Icons.home),
                  onPressed: () {},
                ),
                IconButton(
                  icon: Image.asset('lib/img/add-file.png'),
                  onPressed: () async {
                    // Solicitar permiso al usuario para almacenar datos
                    final SharedPreferences prefs =
                        await SharedPreferences.getInstance();
                    bool? permissionGranted =
                        prefs.getBool('permissionGranted');
                    if (permissionGranted == null || !permissionGranted) {
                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: Text('Permiso necesario'),
                          content: Text(
                              '¿Permitir que la aplicación almacene datos en el dispositivo?'),
                          actions: [
                            TextButton(
                              onPressed: () async {
                                await prefs.setBool('permissionGranted', true);
                                Navigator.of(context).pop();
                              },
                              child: Text('Permitir'),
                            ),
                            TextButton(
                              onPressed: () => Navigator.of(context).pop(),
                              child: Text('Cancelar'),
                            ),
                          ],
                        ),
                      );
                    } else {
                      // Si ya se ha dado permiso, continuar con la acción
                      final result = await Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => NuevaValorizacion(),
                        ),
                      );
                      if (result != null) {
                        _addValorizacion(result);
                      }
                    }
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
