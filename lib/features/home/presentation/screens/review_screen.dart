import 'package:flutter/material.dart';
import 'package:money/core/utils/app_colors.dart';
import 'package:money/features/home/data/models/transcation_model.dart';

class ReviewScreen extends StatelessWidget {
  const ReviewScreen({super.key, required this.transactionModel});
  final TransactionModel transactionModel;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Review Screen'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            ReviewItem(
              text1: 'Transaction Type',
              text2: transactionModel.type,
            ),
            ReviewItem(
              text1: 'Transaction Category',
              text2: transactionModel.category,
            ),
            ReviewItem(
              text1: 'Transaction Amount',
              text2: transactionModel.amount,
            ),
            ReviewItem(
              text1: 'Transaction Date',
              text2: transactionModel.date,
            ),
            ReviewItem(
              text1: 'Transaction Time',
              text2: transactionModel.time,
            ),
          ],
        ),
      ),
    );
  }
}

class ReviewItem extends StatelessWidget {
  const ReviewItem({
    super.key, required this.text1, required this.text2,

  });

  final String text1;
  final String text2;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          border: Border.all(color: AppColors.primaryColor2),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Text(
          '$text1: $text2',
          style:
              const TextStyle(color: AppColors.primaryColor1, fontSize: 18),
        ),
      ),
    );
  }
}
