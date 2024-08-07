import 'package:flutter/material.dart';

import '../../../../core/utils/app_colors.dart';

class BalanceWidget extends StatelessWidget {
  const BalanceWidget({
    super.key,
    required this.balance,
    required this.currency,
  });

  final String balance;
  final String currency;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(30),
      decoration: BoxDecoration(
        color: AppColors.primaryColor1,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        '$balance   $currency',
        style: const TextStyle(
          fontSize: 22,
          color: Colors.white,
        ),
      ),
    );
  }
}