import 'package:flutter/material.dart';

class PhoneInputField extends StatelessWidget {
  final TextEditingController phoneController;

  const PhoneInputField({super.key, required this.phoneController,});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Row(
          children: [
            Text(" رقم التليفون:",
                style: TextStyle(fontWeight: FontWeight.bold)),
          ],
        ),
        TextField(
          controller: phoneController,
          keyboardType: TextInputType.number,
          decoration:
          const InputDecoration(
            border: OutlineInputBorder(),
            hintText: 'أدخل رقم الهاتف',
          ),
        ),
      ],
    );
  }
}