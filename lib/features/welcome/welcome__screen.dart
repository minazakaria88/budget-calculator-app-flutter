import 'package:currency_picker/currency_picker.dart';
import 'package:flutter/material.dart';
import 'package:money/core/routing/routes.dart';
import 'package:money/core/utils/cache_helper.dart';
import 'package:money/core/widgets/my_button.dart';
import 'package:money/features/welcome/welcome_model.dart';

import '../../core/utils/app_strings.dart';
import '../../core/widgets/my_text_field.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  TextEditingController currency = TextEditingController();
  TextEditingController balance = TextEditingController();
  var formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    currency.dispose();
    balance.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(AppString.appBarTitle),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Form(
          key: formKey,
          child: Column(
            children: [
              const SizedBox(
                height: 50,
              ),
              MyTextFormField(
                onTap: (){
                  showCurrencyPicker(
                    context: context,
                    showFlag: true,
                    showCurrencyName: true,
                    showCurrencyCode: true,
                    onSelect: (Currency currency) {
                        this.currency.text=currency.code;
                    },
                  );
                },
                controller: currency,
                label: 'Enter your Currency',
                prefixIcon: Icons.monetization_on_rounded,
                valid: (String value) {
                  if (value.isEmpty) {
                    return 'required';
                  }
                },
                textInputType: TextInputType.number,
              ),
              const SizedBox(
                height: 20,
              ),
              MyTextFormField(
                controller: balance,
                label: 'Enter your Balance',
                prefixIcon: Icons.monetization_on_rounded,
                valid: (String value) {
                  if (value.isEmpty) {
                    return 'required';
                  }
                },
                textInputType: TextInputType.number,
              ),

              const Spacer(),
              MyButton(
                text: 'Let`s Start',
                onTap: () {
                  if (formKey.currentState!.validate()) {
                    Navigator.pushReplacementNamed(context, Routes.homeScreen,);
                    CacheHelper.setBool(key: CacheHelperKeys.isWelcome, value: true);
                    CacheHelper.setString(key: CacheHelperKeys.balance, value: balance.text);
                    CacheHelper.setString(key: CacheHelperKeys.currency, value: currency.text);
                  }
                },
              ),
              const SizedBox(
                height: 50,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
