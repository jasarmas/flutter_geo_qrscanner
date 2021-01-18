import 'package:flutter/material.dart';
import 'package:flutter_geo_qrscanner/src/pages/home_page.dart';
import 'package:flutter_geo_qrscanner/src/pages/map_page.dart';
import 'package:flutter_geo_qrscanner/src/providers/scan_list_provider.dart';
import 'package:flutter_geo_qrscanner/src/providers/ui_provider.dart';
import 'package:provider/provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => new UiProvider()),
        ChangeNotifierProvider(create: (_) => new ScanListProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'QR Reader',
        initialRoute: "home",
        routes: {
          "home": (_) => HomePage(),
          "map": (_) => MapPage(),
        },
        theme: ThemeData(
            primaryColor: Colors.deepPurple,
            focusColor: Colors.blue,
            floatingActionButtonTheme: FloatingActionButtonThemeData(
              backgroundColor: Colors.deepPurple,
            )),
      ),
    );
  }
}
