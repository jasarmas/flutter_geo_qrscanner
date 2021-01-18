import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:flutter_geo_qrscanner/src/providers/scan_list_provider.dart';
import 'package:flutter_geo_qrscanner/src/utils/utils.dart';
import 'package:provider/provider.dart';

class ScanButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      elevation: 1,
      onPressed: () async {
        String barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
          "#3D8BEF",
          "Cancelar",
          false,
          ScanMode.QR,
        );
        //String barcodeScanRes = "https://joseandres.com";
        //final barcodeScanRes = "geo:-33.44935547963195,-70.6549124098931";

        if (barcodeScanRes == "-1") {
          return;
        }

        final scanListProvider =
            Provider.of<ScanListProvider>(context, listen: false);
        final newScan = await scanListProvider.newScan(barcodeScanRes);

        launchURL(context, newScan);
        //scanListProvider.newScan(barcodeScanRes);
      },
      child: Icon(
        Icons.filter_center_focus,
      ),
    );
  }
}
