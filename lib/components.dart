import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

Widget text(String text, {Color color = Colors.black, double fontSize = 16}) {
  return Text(
    text,
    style:
        GoogleFonts.montserrat(fontSize: fontSize, fontWeight: FontWeight.w500),
  );
}

Widget textField(
  TextEditingController controller,
  String errorText,
  String labelText, {
  TextInputType inputType = TextInputType.text,
  int minLines = 1,
}) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 5),
    child: TextFormField(
      maxLines: minLines,
      keyboardType: inputType,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      controller: controller,
      decoration: InputDecoration(
        alignLabelWithHint: true,
        labelText: labelText,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        // labelText: labelText,
        isDense: true,
        contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 14),
      ),
      validator: (value) {
        if (value!.isEmpty) {
          return errorText;
        }
        return null;
      },
    ),
  );
}
