
import 'package:flutter/material.dart';
import 'package:money/core/utils/cache_helper.dart';
import 'package:money/features/home/data/models/transcation_model.dart';

import '../../../../core/routing/routes.dart';
import '../../../../core/utils/app_colors.dart';

class TransactionListItem extends StatelessWidget {
  const TransactionListItem({
    super.key, required this.model, required this.function,
  });
 final TransactionModel model;
 final Function function;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: AppColors.primaryColor1,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  padding: const EdgeInsets.all(15),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: model.type=='revenue'?Colors.green:Colors.red,
                  ),
                  child:  Icon(
                    model.type=='revenue'? Icons.add:Icons.remove,
                    color: Colors.white,
                  ),
                ),
              ),
               Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                   model.time,
                    style: const TextStyle(
                        color: AppColors.primaryColor1, fontSize: 20),
                  ),
                  Text(
                    model.date,
                    style: const TextStyle(
                        color: AppColors.primaryColor1, fontSize: 20),
                  )
                ],
              ),
               Column(
                 children: [
                   TextButton(
                       onPressed: (){

                             function();
                       },
                       child: const Text(
                         'Edit'
                       )
                   ),
                   Text(
                    '${model.amount} ${CacheHelper.getString(key: CacheHelperKeys.currency)}',
                    style: const TextStyle(
                        color: AppColors.primaryColor2, fontSize: 22),
                                 ),
                 ],
               )
            ],
          ),
        ),
      ),
    );
  }
}