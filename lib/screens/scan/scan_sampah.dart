import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:welove/main.dart';
import 'package:welove/screens/scan/hasil_scan_sampah_page.dart';

class ScanSampah extends StatefulWidget {
  const ScanSampah({Key? key}) : super(key: key);

  @override
  State<ScanSampah> createState() => _ScanSampahState();
}

class _ScanSampahState extends State<ScanSampah> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  Barcode? result;
  QRViewController? controller;

  // In order to get hot reload to work we need to pause the camera if the platform
  // is android, or resume the camera if the platform is iOS.
  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      controller!.pauseCamera();
    } else if (Platform.isIOS) {
      controller!.resumeCamera();
    }
  }

  @override
  Widget build(BuildContext context) {
    // final simpanDataTempat = Provider.of<SimpanDataTempat>(context);

    // SimpanDataTempat simpanDataTempat;
    // ChangeNotifierProvider.value(value: simpanDataTempat);
    // QRViewController? controller = simpanDataTempat.controller;

    return Scaffold(
      body: Column(
        children: <Widget>[
          Expanded(
            flex: 8,
            child: QRView(
              key: qrKey,
              onQRViewCreated: _onQRViewCreated,
            ),
          ),
          Expanded(
            flex: 1,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                (result != null)
                    ? Text('Barcode Type: ${describeEnum(result!.format)} Data: ${result!.code}')
                    : const Text('Scan a code'),
                InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => HasilScanSampahPage(
                          dataQrCode: result?.code ?? "tanpa_data",
                        ),
                      ),
                    );
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

  void _onQRViewCreated(QRViewController controller) {
    this.controller = controller;
    controller.scannedDataStream.listen((scanData) {
      setState(() {
        result = scanData;
      });
    });
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }
}
