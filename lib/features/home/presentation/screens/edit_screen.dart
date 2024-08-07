import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/widgets/my_button.dart';
import '../../../../core/widgets/my_text_field.dart';
import '../manager/home_cubit.dart';
import '../manager/home_state.dart';

class EditDataScreen extends StatefulWidget {
  const EditDataScreen({super.key, required this.homeCubit, required this.index});
  final HomeCubit homeCubit ;
  final int index;

  @override
  State<EditDataScreen> createState() => _EditDataScreenState();
}

class _EditDataScreenState extends State<EditDataScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Data'),
      ),
      body:BlocProvider.value(
        value: widget.homeCubit,
        child: BlocBuilder<HomeCubit, HomeState>(
          builder: (context, state) {
            var cubit = BlocProvider.of<HomeCubit>(context);
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Form(
                key: cubit.formKey,
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 20,
                        ),
                        MyTextFormField(
                          onTap: () {
                            showTimePicker(
                                context: context,
                                initialTime: TimeOfDay.now())
                                .then((value) {
                              cubit.time.text =
                                  value!.format(context).toString();
                            });
                          },
                          controller: cubit.time,
                          label: 'Time',
                          prefixIcon: Icons.timer,
                          valid: (String value) {
                            if (value.isEmpty) {
                              return 'required';
                            }
                          },
                          textInputType: TextInputType.text,
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        MyTextFormField(
                          controller: cubit.category,
                          label: 'Category',
                          prefixIcon: Icons.category,
                          valid: (String value) {
                            if (value.isEmpty) {
                              return 'required';
                            }
                          },
                          textInputType: TextInputType.text,
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        MyTextFormField(
                          onTap: () {
                            showDatePicker(
                                context: context,
                                firstDate: DateTime.now(),
                                lastDate: DateTime(3030))
                                .then((value) {
                              cubit.date.text =
                                  value.toString().split(' ').first;
                            });
                          },
                          controller: cubit.date,
                          label: 'Date',
                          prefixIcon: Icons.calendar_month,
                          valid: (String value) {
                            if (value.isEmpty) {
                              return 'required';
                            }
                          },
                          textInputType: TextInputType.text,
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        MyButton(
                            text: 'Edit Transaction',
                            onTap: () {
                              if (cubit.formKey.currentState!.validate()) {
                                  cubit.updateTransaction(
                                    id: cubit.transactionList[widget.index].id,
                                    time: cubit.time.text,
                                    date: cubit.date.text,
                                    category: cubit.category.text,
                                  );
                                  Navigator.pop(context);
                              }
                            }),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
