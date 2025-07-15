import 'package:flutter/material.dart';
import 'package:t1/Core/widget/custom_snackbar.dart';
import '../../../../Core/Back_Arrow.dart';
import '../../../../Core/custom_appBar.dart';
import '../../../../Features/Borrow_Screens/Widget/Dialog.dart';
import '../../../../Features/Borrow_Screens/Widget/Phone_Input_Field.dart';
import '../../../../Core/Push_button.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

import '../../../API services/borrow_service.dart';
import '../../../local.dart';
import '../Widget/upload_box.dart';
class BorrowRequestPage extends StatefulWidget {
  final int? BookID;
  static String id = "/BorrowRequestPage";
  const BorrowRequestPage({super.key, this.BookID});

  @override
  // ignore: library_private_types_in_public_api
  _BorrowRequestPageState createState() => _BorrowRequestPageState();
}
class _BorrowRequestPageState extends State<BorrowRequestPage> {
  File? idImage;
  File? govPaperImage;
  bool isLoading = false;

  final TextEditingController phoneController = TextEditingController();
  Future<void> pickImage(Function(File) onImagePicked) async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      onImagePicked(File(pickedFile.path));
    }
  }
  @override
  Widget build(BuildContext context) {
    print('📘 Book ID اللي واصل للصفحة: ${widget.BookID}'); // ← أضيفي السطر ده
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const CustomAppBar(),
          const BackArrow(),
          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                const Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      "اكمل البيانات التاليه للإستعارة",
                      textAlign: TextAlign.right,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                const SizedBox(height: 10,),
                const Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                    Text(
                      "صورة البطاقة:",
                      textAlign: TextAlign.right,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ]
                ),
                GestureDetector(
                  onTap: () {
                    pickImage((File file) {
                      setState(() {
                        idImage = file;
                      });
                    });
                  },
                  child: UploadBox(imageFile: idImage),
                ),
                const SizedBox(height: 16),
                const Wrap(
                  alignment: WrapAlignment.start,
                  children: [
                    Text(
                      "ورقة مختومة بختم النسر من مؤسسة حكوميه بتوقيع 2 موظفين:",
                      textAlign: TextAlign.right,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                GestureDetector(
                  onTap: () {
                    pickImage((File file) {
                      setState(() {
                        govPaperImage = file;
                      });
                    });
                  },
                  child: UploadBox(imageFile: govPaperImage),
                ),
                const SizedBox(height: 16),
                PhoneInputField(phoneController: phoneController),
                const SizedBox(height: 16),
                InkWell(
                  onTap: () async {
                    final token = LocalData.accessToken;
                    final bookId = widget.BookID;
                    if (bookId != null && token != null && idImage != null && govPaperImage != null) {
                      setState(() => isLoading = true);
                      final success = await BorrowService().sendRequest(
                        bookId: bookId,
                        imageFile: idImage!,
                        pdfFile: govPaperImage!,
                      );
                      setState(() => isLoading = false);
                      customSnackBar(
                        context,
                        success ? 'تم إرسال الطلب بنجاح' : 'فشل في إرسال الطلب',
                        success ? Colors.green : Colors.red,
                        success ? Icons.check_circle_outline : Icons.error_outline_rounded,
                      );
                    } else {
                      customSnackBar(
                        context,
                        'من فضلك تأكد من إدخال كل البيانات',
                        Colors.red,
                        Icons.error_outline_rounded,
                      );
                    }
                  },
                  child: PushButton(

                    width: 322,
                    nameCard: 'طلب',
                    fontSize: 25,
                    isLoading: isLoading, // ✅ هنا
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}