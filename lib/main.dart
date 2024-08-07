import 'package:flutter/material.dart';
import 'package:money/core/routing/app_routes.dart';
import 'package:money/core/routing/routes.dart';
import 'package:money/core/utils/app_theme.dart';
import 'package:money/core/utils/cache_helper.dart';
 bool isWelcome=false;
void main()async {
  WidgetsFlutterBinding.ensureInitialized();
 await CacheHelper.init();
  if(CacheHelper.getBool(key: CacheHelperKeys.isWelcome)!=null)
    {
      isWelcome=true;
    }
  else
    {
      isWelcome=false;
    }

  runApp(const BudgetCalculator());
}

class BudgetCalculator extends StatelessWidget {
  const BudgetCalculator({super.key});

  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: appTheme(),
      initialRoute: !isWelcome ? Routes.welcomeScreen:Routes.homeScreen,
      onGenerateRoute: AppRoutes.onGenerateRout,
    );
  }
}

