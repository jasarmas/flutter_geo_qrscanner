import 'package:flutter/material.dart';
import 'package:flutter_geo_qrscanner/src/providers/scan_list_provider.dart';
import 'package:flutter_geo_qrscanner/src/utils/utils.dart';
import 'package:provider/provider.dart';

class ScanListTiles extends StatelessWidget {
  final String type;

  const ScanListTiles({@required this.type});

  @override
  Widget build(BuildContext context) {
    final scanListProvider = Provider.of<ScanListProvider>(context);
    final scans = scanListProvider.scans;

    return ListView.builder(
      itemBuilder: (_, i) => Dismissible(
        key: UniqueKey(),
        background: Container(
          color: Colors.red[100],
        ),
        onDismissed: (DismissDirection direction) {
          Provider.of<ScanListProvider>(context, listen: false)
              .deleteById(scans[i].id);
        },
        child: ListTile(
          leading: Icon(
            this.type == "http" ? Icons.home_outlined : Icons.map,
            color: Theme.of(context).primaryColor,
          ),
          title: Text(scans[i].value),
          subtitle: Text(scans[i].id.toString()),
          trailing: Icon(Icons.keyboard_arrow_right, color: Colors.grey),
          onTap: () => launchURL(context, scans[i]),
        ),
      ),
      itemCount: scans.length,
    );
  }
}
