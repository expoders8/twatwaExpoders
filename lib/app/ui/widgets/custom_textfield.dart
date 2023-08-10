import 'package:flutter/material.dart';

import '../../../config/constant/color_constant.dart';

class CustomTextFormField extends StatefulWidget {
  final TextEditingController? ctrl;
  final String? hintText;
  final TextInputType? keyboardType;
  final String? prefixIcon;
  final String? name;
  final String? validationMsg;
  final int? maxLines;
  final bool formSubmitted;

  const CustomTextFormField(
      {Key? key,
      this.ctrl,
      this.hintText,
      this.keyboardType,
      this.prefixIcon,
      this.maxLines,
      this.formSubmitted = false,
      this.name,
      this.validationMsg})
      : super(key: key);

  @override
  State<CustomTextFormField> createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomTextFormField> {
  bool isTouched = false;
  bool _passwordVisible = false;

  @override
  void initState() {
    super.initState();
    _passwordVisible = false;
  }

  validateInput(value) {
    if (isTouched || widget.formSubmitted) {
      if (value != null && value?.toString() != '') {
        if (widget.name == 'email') {
          if (value.isEmpty) {
            widget.validationMsg;
          } else {
            const pattern =
                r'(^[a-zA-Z0-9_.+-]+@[a-zA-Z0-9]+\.[a-zA-Z0-9-.]+$)';
            final regExp = RegExp(pattern);

            if (!regExp.hasMatch(value.toString())) {
              return "Please enter valid email";
            }
          }
        }
        if (widget.name == 'username') {
          if (value.isEmpty) {
            widget.validationMsg;
          } else {
            // const pattern = r"^[A-Za-z][A-Za-z0-9._-]{5,15}$";
            // final regExp = RegExp(pattern);

            // if (!regExp.hasMatch(value.toString())) {
            //   return "Please enter valid username";
            // }
            if (!RegExp(r"^[A-Za-z@][A-Za-z0-9._-]{5,15}$").hasMatch(value)) {
              return 'Please enter valid username';
            }
          }
        }
        if (widget.name == "password") {
          if (value.isEmpty) {
            widget.validationMsg;
          }
        }
        if (widget.name == "phoneno") {
          if (value.isEmpty) {
            widget.validationMsg;
          } else {
            if (value.length < 9) {
              return "Please Enter valid number";
            } else if (value.length > 13) {
              return "Please Enter valid number";
            }
          }
        }
        return null;
      }
      return widget.validationMsg;
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      style: const TextStyle(color: kWhiteColor),
      controller: widget.ctrl,
      keyboardType: widget.keyboardType,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      validator: (value) {
        return validateInput(value);
      },
      obscureText: widget.name == "password" ? !_passwordVisible : false,
      obscuringCharacter: '●',
      decoration: InputDecoration(
        hintText: widget.hintText,
        filled: true,
        fillColor:
            widget.name == "comment" ? kCardColor : const Color(0xB3493F54),
        hintStyle: TextStyle(
            color:
                widget.name == "comment" ? kButtonSecondaryColor : kWhiteColor,
            fontSize: 14),
        labelStyle: const TextStyle(color: kWhiteColor),
        contentPadding: const EdgeInsets.fromLTRB(17, 17, 17, 17),
        prefixIcon: widget.prefixIcon != null
            ? ImageIcon(
                AssetImage(widget.prefixIcon ?? ''),
                color: const Color(0xFF797A8E),
              )
            : null,
        suffixIcon: widget.name == "password"
            ? IconButton(
                splashColor: kTransparentColor,
                highlightColor: kTransparentColor,
                icon: Icon(
                  _passwordVisible ? Icons.visibility : Icons.visibility_off,
                  color: const Color(0xFF797A8E),
                  size: 18,
                ),
                onPressed: () {
                  setState(() {
                    _passwordVisible = !_passwordVisible;
                  });
                },
              )
            : null,
        border: OutlineInputBorder(
          borderRadius: const BorderRadius.all(
            Radius.circular(5.0),
          ),
          borderSide: BorderSide(
              color: widget.name == "comment"
                  ? kCardColor
                  : const Color(0xB3493F54)),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: const BorderRadius.all(
            Radius.circular(5.0),
          ),
          borderSide: BorderSide(
              color: widget.name == "comment"
                  ? kCardColor
                  : const Color(0xB3493F54)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: const BorderRadius.all(
            Radius.circular(5.0),
          ),
          borderSide: BorderSide(
              color: widget.name == "comment"
                  ? kCardColor
                  : const Color(0xB3493F54)),
        ),
      ),
      maxLines: widget.maxLines,
      onChanged: (value) => {
        isTouched = true,
      },
    );
  }
}
