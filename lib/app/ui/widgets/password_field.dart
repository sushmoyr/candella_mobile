import 'package:candella/app/ui/widgets/rounded_icon_button.dart';
import 'package:flutter/material.dart';

class PasswordFormField extends StatefulWidget {
  final String? hintText;
  final String? labelText;
  final String? helperText;

  const PasswordFormField(
      {Key? key,
      required this.controller,
      this.hintText,
      this.labelText,
      this.helperText})
      : super(key: key);

  final TextEditingController controller;

  @override
  _PasswordFormFieldState createState() => _PasswordFormFieldState();
}

class _PasswordFormFieldState extends State<PasswordFormField> {
  bool obSecure = true;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      obscureText: obSecure,
      decoration: InputDecoration(
          suffixIcon: (obSecure)
              ? AppIconButton(
                  onTap: () {
                    setState(() {
                      obSecure = !obSecure;
                    });
                  },
                  iconData: Icons.visibility,
                )
              : AppIconButton(
                  onTap: () {
                    setState(() {
                      obSecure = !obSecure;
                    });
                  },
                  iconData: Icons.visibility_off,
                ),
          labelText: widget.labelText,
          helperText: widget.helperText,
          hintText: widget.hintText),
    );
  }
}
