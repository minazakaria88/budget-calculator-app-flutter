

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:money/core/utils/cache_helper.dart';
import 'package:money/features/home/presentation/manager/home_state.dart';
import 'package:sqflite/sqflite.dart';

import '../../data/models/transcation_model.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(InitHomeState());

  TextEditingController time = TextEditingController();

  TextEditingController date = TextEditingController();

  TextEditingController money = TextEditingController();
  TextEditingController category = TextEditingController();
  var formKey = GlobalKey<FormState>();
  Set segment = {};

  Database? database;

  void createDatabase() {
    openDatabase('money.db', version: 1, onCreate: (db, version) {
      db.execute(
          'CREATE TABLE Money (id INTEGER PRIMARY KEY, time TEXT, date TEXT, category TEXT, amount TEXT, type TEXT)');
    }, onOpen: (db) {
      getDataFromDatabase(db);
    }).then((value) {
      database = value;
    });
  }

  List<TransactionModel> transactionList = [];
  void getDataFromDatabase(database) {
    transactionList = [];
    emit(LoadingHomeState());
    database.rawQuery('SELECT * FROM Money').then((value) {
      for (var element in value) {
        transactionList.add(TransactionModel.fromJson(element));
      }
      emit(SuccessHomeState());
    }).catchError((e) {
      emit(ErrorHomeState());
    });
  }

  void insertToDatabase({
    required String time,
    required String date,
    required String category,
    required String amount,
    required String type,
  }) async {
    await database!.transaction((txn) async {
      txn
          .rawInsert(
              'INSERT INTO Money(time, date, category, amount, type) VALUES("$time", "$date", "$category", "$amount", "$type")')
          .then((value) {
        double total=0;
            if(type=='revenue'){
               total =
                  double.parse(CacheHelper.getString(key: CacheHelperKeys.balance)!) +
                      double.parse(amount);
            }
            else{
               total =
                  double.parse(CacheHelper.getString(key: CacheHelperKeys.balance)!) -
                      double.parse(amount);
            }
        CacheHelper.setString(
            key: CacheHelperKeys.balance, value: total.toString());
        getDataFromDatabase(database);
      }).catchError((e) {});
    });
  }

  void deleteTransaction({
    required int id,
  }) async {
    await database!.rawDelete('DELETE FROM Money WHERE id = ?', [id]);
    getDataFromDatabase(database);
  }

  void updateTransaction({
    required int id,
    required String time,
    required String date,
    required String category,

  }) async {
   try
       {
         await database!.rawUpdate(
             'UPDATE Money SET time = ?, date = ?, category = ? WHERE id = ?',
             [time, date, category, id]);
         getDataFromDatabase(database);
       }
       catch(e){
        print(e.toString());
       }

  }

  void setData({required TransactionModel model})
  {
    time.text=model.time;
    date.text=model.date;
    category.text=model.category;

  }
}
