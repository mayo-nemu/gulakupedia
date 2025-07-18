import 'package:flutter/material.dart';
import 'package:gulapedia/src/widgets/layout_appbar.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:permission_handler/permission_handler.dart';

class BarcodeScannerScreen extends StatefulWidget {
  const BarcodeScannerScreen({super.key});

  @override
  State<BarcodeScannerScreen> createState() => _BarcodeScannerScreenState();
}

class _BarcodeScannerScreenState extends State<BarcodeScannerScreen> {
  MobileScannerController cameraController = MobileScannerController();
  bool _permissionGranted = false;
  bool _isDetecting = true; // To prevent multiple detections quickly

  @override
  void initState() {
    super.initState();
    _checkPermission();
  }

  Future<void> _checkPermission() async {
    final status = await Permission.camera.request();
    if (status.isGranted) {
      setState(() {
        _permissionGranted = true;
      });
      // Optionally start camera immediately if permission granted
      cameraController.start();
    } else {
      // Handle cases where permission is denied
      // You might want to show a dialog or message to the user
      setState(() {
        _permissionGranted = false;
      });
      // Show an alert or pop the screen if permission is critical
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
              'Camera permission denied. Please grant permission in settings.',
            ),
            duration: Duration(seconds: 3),
          ),
        );
        Navigator.pop(context); // Go back if no permission
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    if (!_permissionGranted) {
      return Scaffold(
        appBar: AppBar(title: const Text('Barcode Scanner')),
        body: const Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Camera permission is required to scan barcodes.'),
              SizedBox(height: 20),
              // Optional: Add a button to open app settings
              // ElevatedButton(
              //   onPressed: () => openAppSettings(),
              //   child: const Text('Open Settings'),
              // ),
            ],
          ),
        ),
      );
    }

    return LayoutAppbar(
      title: 'Scan Barcode',
      child: MobileScanner(
        controller: cameraController,

        onDetect: (capture) {
          if (!_isDetecting) return;

          final List<Barcode> barcodes = capture.barcodes;
          if (barcodes.isNotEmpty) {
            final String? scannedValue = barcodes.first.rawValue;
            if (scannedValue != null && scannedValue.isNotEmpty) {
              setState(() {
                _isDetecting = false;
              });
              debugPrint('Barcode found! $scannedValue');
              Navigator.pop(context, scannedValue);
            }
          }
        },
      ),
    );
  }

  @override
  void dispose() {
    cameraController.dispose();
    super.dispose();
  }
}
