import 'package:bytebank/screens/analysis/data_analysis.dart';
import 'package:bytebank/screens/gasto/categoria/nova_categoria.dart';
import 'package:bytebank/screens/gasto/lista.dart';
import 'package:bytebank/screens/gasto/novo_gasto.dart';
import 'package:bytebank/services/notification_service.dart';
import 'package:bytebank/stores/meta_store.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  NotificationService().initNotification();
  await Firebase.initializeApp();
  runApp(BytebankApp());
}

class BytebankApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<MetaStore>(
          create: (_) => MetaStore(),
        )
      ],
      child: MaterialApp(
        theme: ThemeData.dark(),
        home: ListaGastos(),
        routes: <String, WidgetBuilder>{
          '/novogasto': (BuildContext context) => NovoGasto(),
          '/dataanalysis': (BuildContext context) => DataAnalysis(),
          '/novacategoria': (BuildContext context) => NovaCategoria(),
        },
      ),
    );
  }
}
