import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class TextInput extends StatefulWidget {
  final String label;
  final String placeholder;
  final bool isObscure;
  const TextInput(
      {super.key,
      required this.label,
      required this.placeholder,
      required this.isObscure});

  @override
  State<TextInput> createState() => _TextInputState();
}

class _TextInputState extends State<TextInput> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.label,
          style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 12),
        ),
        const SizedBox(
          height: 4,
        ),
        Material(
          elevation: 0.2,
          borderRadius: BorderRadius.circular(8),
          child: TextField(
            obscureText: widget.isObscure,
            scrollPadding: EdgeInsets.zero,
            style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 14),
            decoration: InputDecoration(
              isDense: true,
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 14, horizontal: 12),
              hintText: widget.placeholder,
              hintStyle: const TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 14,
                  color: Colors.black26),
              fillColor: Colors.white,
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: const BorderSide(color: Colors.black, width: 1),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: const BorderSide(color: Colors.black12, width: 1),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
