import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:money/core/routing/routes.dart';
import 'package:money/core/utils/app_colors.dart';
import 'package:money/core/utils/app_strings.dart';
import 'package:money/core/utils/cache_helper.dart';
import 'package:money/features/home/presentation/manager/home_cubit.dart';
import 'package:money/features/home/presentation/manager/home_state.dart';

import '../widgets/balance_widget.dart';
import '../widgets/transcation_list_item.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({
    super.key,
  });
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(AppString.appBarTitle),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.primaryColor2,
        onPressed: () {
          Navigator.pushNamed(context, Routes.inputScreen);
        },
        child: const Icon(
          Icons.add,
          color: Colors.white,
          size: 30,
        ),
      ),
      body: BlocBuilder<HomeCubit, HomeState>(
        builder: (context, state) {
          var cubit = BlocProvider.of<HomeCubit>(context);
          return Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(
                height: 30,
                width: double.infinity,
              ),
              BalanceWidget(
                balance: CacheHelper.getString(key: CacheHelperKeys.balance)!,
                currency: CacheHelper.getString(key: CacheHelperKeys.currency)!,
              ),
              const SizedBox(
                height: 20,
              ),
              cubit.transactionList.isEmpty
                  ? const Center(child: Text('No Transactions'))
                  : Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ListView.builder(
                        itemCount: cubit.transactionList.length,
                          itemBuilder: (context, index) => GestureDetector(
                            onTap: () {
                              Navigator.pushNamed(
                                  context, Routes.reviewScreen,
                                  arguments: cubit.transactionList[index]);
                            },
                            child: TransactionListItem(
                              function: (){
                                cubit.setData(model: cubit.transactionList[index]);
                                Navigator.pushNamed(context, Routes.editScreen,arguments: index);
                              },
                              model: cubit.transactionList[index],
                            ),
                          ),
                        ),
                    ),
                  ),
            ],
          );
        },
      ),
    );
  }
}
