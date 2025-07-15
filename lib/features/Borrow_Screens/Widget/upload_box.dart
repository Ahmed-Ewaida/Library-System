import 'package:flutter/material.dart';
import 'dart:io';

class UploadBox extends StatelessWidget {
  final File? imageFile;
  const UploadBox({super.key, required this.imageFile,});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Center(
        child: imageFile == null
            ? const Icon(Icons.camera_alt, size: 32)
            : Image.file(imageFile!, fit: BoxFit.cover),
      ),
    );
  }
}