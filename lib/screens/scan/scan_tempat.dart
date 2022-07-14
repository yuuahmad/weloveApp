import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:welove/main.dart';
import 'package:welove/screens/scan/hasil_scan_tempat_page.dart';

class ScanTempat extends StatefulWidget {
  const ScanTempat({Key? key}) : super(key: key);

  @override
  State<ScanTempat> createState() => _ScanTempatState();
}

class _ScanTempatState extends State<ScanTempat> {
  @override
  Widget build(BuildContext context) {
    final simpanDataTempat = Provider.of<SimpanDataTempat>(context);
    return Scaffold(
      body: Column(
        children: <Widget>[
          Expanded(
            flex: 8,
            child: QRView(
              key: simpanDataTempat.qrKey,
              onQRViewCreated: simpanDataTempat.onQRViewCreated,
            ),
          ),
          Expanded(
            flex: 1,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                (simpanDataTempat.result != null)
                    ? Text(
                        'Barcode Type: ${describeEnum(simpanDataTempat.result!.format)} Data: ${simpanDataTempat.result!.code}')
                    : const Text('Scan a code'),
                InkWell(
                  onTap: () {
                    // // ignore: unnecessary_null_comparison
                    if ((simpanDataTempat.result?.format == null || simpanDataTempat.result?.code == null) ||
                        (describeEnum(simpanDataTempat.result!.format) != "qrcode" &&
                            simpanDataTempat.result?.code != null)) {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("bukan qr code!")));
                    } else if (describeEnum(simpanDataTempat.result!.format) == "qrcode" &&
                        simpanDataTempat.result?.code != null) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => HasilScanTempatPage(
                            dataQrCode: simpanDataTempat.result?.code ?? "",
                          ),
                        ),
                      );
                    }
                    // else {
                    //   ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("bukan qr code!")));
                    // }
                  },
                  child: const TombolPenting(
                    namaTombol: "lanjutkan",
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class SimpanDataTempat with ChangeNotifier {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  Barcode? result;
  QRViewController? controller;
  void reassemble() {
    // super.reassemble();
    if (Platform.isAndroid) {
      controller!.pauseCamera();
    } else if (Platform.isIOS) {
      controller!.resumeCamera();
    }
  }

  void onQRViewCreated(QRViewController controller) {
    this.controller = controller;
    controller.scannedDataStream.listen((scanData) {
      result = scanData;
      notifyListeners();
    });
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }
}
