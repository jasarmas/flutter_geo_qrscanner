import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:flutter_geo_qrscanner/src/providers/scan_list_provider.dart';
import 'package:flutter_geo_qrscanner/src/providers/ui_provider.dart';
import 'package:flutter_geo_qrscanner/src/widgets/custom_navigatorbar.dart';
import 'package:flutter_geo_qrscanner/src/widgets/scan_button.dart';
import 'package:flutter_geo_qrscanner/src/widgets/scan_list_tiles.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Historial"),
        actions: [
          IconButton(
            icon: Icon(Icons.delete_forever),
            onPressed: () {
              final scanListProvider =
                  Provider.of<ScanListProvider>(context, listen: false);

              scanListProvider.deleteAll();
            },
          )
        ],
      ),
      body: _HomePageBody(),
      bottomNavigationBar: CustomNavigationBar(),
      floatingActionButton: ScanButton(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}

class _HomePageBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final uiProvider = Provider.of<UiProvider>(context);

    final currentIndex = uiProvider.selectedMenuOpt;

    //final tempScan = new ScanModel(value: "http://google.com");
    //DBProvider.db.newScan(tempScan);
    //DBProvider.db.getScanById(5).then((scan) => print(scan.value));
    //DBProvider.db.getAllScans().then(print);

    final scanListProvider =
        Provider.of<ScanListProvider>(context, listen: false);

    switch (currentIndex) {
      case 0:
        scanListProvider.loadScansByType("geo");
        return ScanListTiles(type: "geo");
      case 1:
        scanListProvider.loadScansByType("http");
        return ScanListTiles(type: "http");
      default:
        return ScanListTiles(type: "geo");
    }
  }
}
