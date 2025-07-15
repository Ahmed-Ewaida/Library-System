import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
class Scanner extends StatefulWidget {
  const Scanner({super.key});

  @override
  State<Scanner> createState() => _ScannerState();
}

class _ScannerState extends State<Scanner> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MobileScanner(
        onDetect: (capture){

        },
      ),
    );
  }
}
// InkWell(
// onTap: (){
// Navigator.pushNamed(context, 'enterd');
// },
// child: SizedBox(
// width: double.infinity,
// height: 250,
// ),
// ),
