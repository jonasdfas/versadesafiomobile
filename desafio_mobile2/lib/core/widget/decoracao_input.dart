import 'package:flutter/material.dart';

InputDecoration getAutenticacaoinputdecoration(String label) {
  return InputDecoration(
      hintText: label,
      fillColor: Colors.white,
      filled: true,
      contentPadding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
      enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(50),
          borderSide:
              BorderSide(color: const Color.fromARGB(255, 32, 141, 231))),
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(50)
      )
      );
}
