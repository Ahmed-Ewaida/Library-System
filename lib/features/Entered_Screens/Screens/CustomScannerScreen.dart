import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import '../../../API models/Scanner_model.dart';
import '../../../API services/Scanner_Service.dart';
import '../../../Core/Clicked_Button.dart';
import '../../../Core/custom_appBar.dart';

class CustomScannerScreen extends StatefulWidget {
  const CustomScannerScreen({super.key});

  static String id = "/CustomScannerScreen";

  @override
  _CustomScannerScreenState createState() => _CustomScannerScreenState();
}

class _CustomScannerScreenState extends State<CustomScannerScreen> {
  MobileScannerController cameraController = MobileScannerController();
  bool isTorchOn = false;
  bool isSending = false;

  // ✅ متغيرات لتخزين البيانات
  String? scannedData;
  final String userId = "user_001"; // لاحقًا ممكن تجيبيه من تسجيل دخول

  bool hasScanned = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          const CustomAppBar(),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 10),
                padding: const EdgeInsets.all(5),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: const [
                    BoxShadow(
                        color: Colors.black26, blurRadius: 6, spreadRadius: 2),
                  ],
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    /// الكاميرا
                    SizedBox(
                      width: double.infinity,
                      height: 185,
                      child: MobileScanner(
                        controller: cameraController,
                        fit: BoxFit.cover,
                        onDetect: (capture) {
                          if (hasScanned) return;

                          final List<Barcode> barcodes = capture.barcodes;
                          if (barcodes.isNotEmpty) {
                            final String? data = barcodes.first.rawValue;
                            if (data != null) {
                              setState(() {
                                hasScanned = true;
                                scannedData = data;
                              });
                              cameraController.stop(); // ✅ أوقفي الكاميرا بعد أول قراءة
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text('تم قراءة الكود: $data'),
                                  backgroundColor: Colors.cyan,
                                ),
                              );
                            }
                          }
                        },
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 25),
              InkWell(
                onTap: () async {
                  if (isSending) return; // ✅ منع الضغط المتكرر
                  setState(() => isSending = true); // ✅ بداية التحميل
                  if (scannedData != null) {
                    final scanModel = ScannerModel(
                      qrCode: scannedData!,
                      location: 'مدخل المكتبة الرئيسي',
                    );

                    try {
                      final response = await ScannerService.postScanData(scanModel);
                      if (response.statusCode == 200 || response.statusCode == 201) {
                        if (context.mounted) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('✅ تم إرسال البيانات بنجاح'),
                              backgroundColor: Colors.green,
                            ),
                          );
                          context.go('/EnteredScreen');
                        }
                      } else {
                        if (context.mounted) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('فشل في الإرسال: ${response.statusCode}'),
                              backgroundColor: Colors.red,
                            ),
                          );
                        }
                      }
                    } catch (e) {
                      if (e is DioException && e.response != null) {
                        print('🔴 Dio Error Response: ${e.response!.data}');
                      }
                      if (context.mounted) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('خطأ في الإرسال: $e'),
                            backgroundColor: Colors.red,
                          ),
                        );
                      }
                    }
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('يرجى مسح كود أولاً'),
                        backgroundColor: Colors.red,
                      ),
                    );
                  }
                  setState(() => isSending = false);
                },
                child:isSending? const CircularProgressIndicator()
                    : const ClickedButton(
                  named: 'الدخول',
                  height: 40,
                  width: 105,
                ),
              ),

            ],
          ),
        ],
      ),
    );
  }
}
