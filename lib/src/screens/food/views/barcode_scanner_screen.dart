import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:gulapedia/src/routes/routes_name.dart';
import 'package:gulapedia/src/widgets/layout_appbar.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:permission_handler/permission_handler.dart';

class BarcodeScannerScreen extends StatefulWidget {
  const BarcodeScannerScreen({
    super.key,
    required this.journalId,
    required this.mealId,
    required this.mealName,
    required this.sugarsGoal,
    required this.sugarsTotal,
  });

  final String journalId;
  final String mealId;
  final String mealName;
  final double sugarsGoal;
  final double sugarsTotal;

  @override
  State<BarcodeScannerScreen> createState() => _BarcodeScannerScreenState();
}

class _BarcodeScannerScreenState extends State<BarcodeScannerScreen> {
  MobileScannerController cameraController = MobileScannerController();
  bool _permissionGranted = false;
  bool _isDetecting = true;

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

      cameraController.start();
    } else {
      setState(() {
        _permissionGranted = false;
      });

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
              'Camera permission denied. Please grant permission in settings.',
            ),
            duration: Duration(seconds: 3),
          ),
        );
        Navigator.pop(context);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    if (!_permissionGranted) {
      return LayoutAppbar(
        title: 'Barcode Scanner',
        back: () {
          context.pushReplacementNamed(
            RoutesName.tambahMenu,
            pathParameters: {
              'journalId': widget.journalId,
              'mealId': widget.mealId,
            },
            queryParameters: {'mealName': widget.mealName},
            extra: {
              'sugarsGoal': widget.sugarsGoal,
              'sugarsTotal': widget.sugarsTotal,
            },
          );
        },

        child: const Center(
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
              context.pushReplacementNamed(
                RoutesName.tambahMenu,
                pathParameters: {
                  'journalId': widget.journalId,
                  'mealId': widget.mealId,
                },
                queryParameters: {
                  'mealName': widget.mealName,
                  'barcode': scannedValue,
                },
                extra: {
                  'sugarsGoal': widget.sugarsGoal,
                  'sugarsTotal': widget.sugarsTotal,
                },
              );
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
