import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';

class CustomTextField extends StatefulWidget {
  final String label;
  final bool isPassword;
  final bool isDropdown; // لمعرفة ما إذا كان الحقل قائمة منسدلة
  final List<String>? dropdownItems;
  final Function(String?)? onChanged;
  final TextEditingController controller;



  CustomTextField({
    required this.label,
    this.isPassword = false,
    this.isDropdown = false,
    this.dropdownItems,
    this.onChanged, required this.controller,
  });

  @override
  _CustomTextFieldState createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool _isPasswordVisible = false; // للتحكم في رؤية كلمة المرور

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.label,
          style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 5),
        SizedBox(
          width: double.infinity,
          // height: 70,
          child: TextField(
            controller: widget.controller,
            textDirection: TextDirection.rtl,
            obscureText: widget.isPassword ? !_isPasswordVisible : false,
            decoration: InputDecoration(
              filled: true,
              fillColor: Colors.white,
              contentPadding:
              EdgeInsets.symmetric(horizontal: 16, vertical: 14),
              focusedBorder: OutlineInputBorder(
                borderSide:
                BorderSide(color: Colors.black), // غير اللون هنا
              ),
              enabledBorder: OutlineInputBorder(
                borderSide:
                BorderSide(color: Color(0XFF888888)), // اللون العادي
              ),
              suffixIcon: widget.isPassword
                  ? IconButton(
                icon: Icon(
                  _isPasswordVisible
                      ? Icons.visibility
                      : Icons.visibility_off,
                  color: Color(0XFF888888),
                  size: 18,
                ),
                onPressed: () {
                  setState(() {
                    _isPasswordVisible = !_isPasswordVisible;
                  });
                },
              )
                  : null,
            ),
          ),
        ),

      ],

    );
  }
}


class Dropdown_Button extends StatefulWidget {
  final List<String> dropdownItems;
  final String textbox;
  final Function(String?)? onChanged;
  String? selectedValue;

  Dropdown_Button({
    Key? key,
    required this.dropdownItems,
    required this.textbox,
    this.onChanged,
    this.selectedValue,
  }) : super(key: key);

  @override
  State<Dropdown_Button> createState() => _Dropdown_ButtonState();
}

class _Dropdown_ButtonState extends State<Dropdown_Button> {
  String? _selectedValue;

  @override
  void initState() {
    super.initState();
    _selectedValue = widget.selectedValue;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.textbox,
          style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
        ),
        SizedBox(
          height: 5,
        ),
        Container(
          width: 331,

          child: Center(
            child: DropdownButtonHideUnderline(
              child: DropdownButton2(
                items: widget.dropdownItems.map((String item) {
                  return DropdownMenuItem(
                    value: item,
                    child: Text(item),
                  );
                }).toList(),
                value: _selectedValue ?? widget.selectedValue,
                onChanged: (String? newValue) {
                  setState(() {
                    _selectedValue = newValue;
                  });
                  if (widget.onChanged != null) {
                    widget.onChanged!(newValue);
                  }
                },
                iconStyleData: IconStyleData(
                    icon: Icon(Icons.keyboard_arrow_down_rounded,color: Colors.black,size: 23,)
                ),

                buttonStyleData: ButtonStyleData(
                  height: 55,
                  width: 331,
                  padding: const EdgeInsets.only(left: 14, right: 14,),
                  decoration: BoxDecoration(

                    borderRadius: BorderRadius.circular(5),
                    border: Border.all(
                        color: Color(0xff838383),width: 1
                    ),
                    color: Colors.white,
                  ),

                ),
                dropdownStyleData: DropdownStyleData(
                  // maxHeight: 200,
                    width: 331,

                    decoration: BoxDecoration(

                      borderRadius: BorderRadius.circular(5),
                      color: Colors.white,
                    ),
                    maxHeight: 200

                ),menuItemStyleData: const MenuItemStyleData(
                height: 50,

                padding: EdgeInsets.only(left: 14, right: 14,top: 22),
              ),

              ),

            ),
          ),
        ),
      ],
    );
  }
}