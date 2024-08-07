
import 'package:flutter/material.dart';
import 'package:money/core/utils/app_colors.dart';

class MyTextFormField extends StatelessWidget {
  const MyTextFormField({
    super.key,
    required this.controller,
    required this.label,
    required this.prefixIcon,
    required this.valid,
    required this.textInputType, this.onTap,

  });
  final TextEditingController controller;
  final String label;
  final IconData prefixIcon;
  final Function valid;
  final TextInputType textInputType;
  final Function ?onTap;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      validator: (value) {
        return valid(value);
      },
      onTap: ()
      {
        if(onTap!=null) {
          onTap!();
        }
      },
      cursorColor: AppColors.primaryColor1,
      keyboardType: textInputType,
      decoration: InputDecoration(
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            color: AppColors.primaryColor1,
            width: 2,
          ),
          borderRadius: BorderRadius.circular(8),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide:
              const BorderSide(color: AppColors.primaryColor2, width: 2),
          borderRadius: BorderRadius.circular(8),
        ),
        border:  OutlineInputBorder(
          borderSide: const BorderSide(
            color: AppColors.primaryColor1,
            width: 2,
          ),
          borderRadius: BorderRadius.circular(8),
        ),
        label: Text(
          label,
          style: const TextStyle(color: AppColors.primaryColor1),
        ),
        prefixIcon: Icon(
          prefixIcon,
        ),
      ),
    );
  }
}
