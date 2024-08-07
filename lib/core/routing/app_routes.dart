import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:money/core/routing/routes.dart';
import 'package:money/features/home/presentation/manager/home_cubit.dart';
import 'package:money/features/home/presentation/screens/home_screen.dart';
import 'package:money/features/home/presentation/screens/input_screen.dart';
import 'package:money/features/home/presentation/screens/review_screen.dart';
import 'package:money/features/welcome/welcome__screen.dart';

import '../../features/home/data/models/transcation_model.dart';
import '../../features/home/presentation/screens/edit_screen.dart';


class AppRoutes {
 static var cubit = HomeCubit();
  static Route onGenerateRout(RouteSettings routeSettings) {
    final args = routeSettings.arguments;
    switch (routeSettings.name) {
      case Routes.welcomeScreen:
        return MaterialPageRoute(
          builder: (context) => const WelcomeScreen(),
        );

      case Routes.inputScreen:
        return MaterialPageRoute(
          builder: (context) =>  InputScreen(homeCubit: cubit,),
        );

      case Routes.homeScreen:
        return MaterialPageRoute(
          builder: (context) => BlocProvider(
            create: (context) => cubit..createDatabase(),
            child: const HomeScreen(),
          ),
        );

      case Routes.reviewScreen:
        return MaterialPageRoute(
          builder: (context) =>  ReviewScreen(transactionModel:args as TransactionModel,),
        );

      case Routes.editScreen:
        return MaterialPageRoute(
          builder: (context) =>  EditDataScreen(homeCubit: cubit, index: args as int,),
        );
      default:
        return MaterialPageRoute(
          builder: (context) => Scaffold(
            appBar: AppBar(),
            body: const Text('no route Found'),
          ),
        );
    }
  }
}
