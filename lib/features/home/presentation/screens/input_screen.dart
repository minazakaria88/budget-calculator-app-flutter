import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:money/core/utils/app_strings.dart';
import 'package:money/core/widgets/my_button.dart';
import 'package:money/core/widgets/my_text_field.dart';
import 'package:money/features/home/presentation/manager/home_cubit.dart';
import 'package:money/features/home/presentation/manager/home_state.dart';

class InputScreen extends StatefulWidget {
  const InputScreen({
    super.key,
    required this.homeCubit,
  });
  final HomeCubit homeCubit;
  @override
  State<InputScreen> createState() => _InputScreenState();
}

class _InputScreenState extends State<InputScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(AppString.appBarTitle),
      ),
      body: BlocProvider.value(
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
                        MyTextFormField(
                          controller: cubit.money,
                          label: 'Money',
                          prefixIcon: Icons.monetization_on,
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
                        SegmentedButton(
                            emptySelectionAllowed: true,
                            showSelectedIcon: true,
                            onSelectionChanged: (value) {
                              cubit.segment = value;
                              setState(() {});
                            },
                            segments: const [
                              ButtonSegment(
                                value: 'revenue',
                                label: Text('revenue'),
                              ),
                              ButtonSegment(
                                value: 'expenses',
                                label: Text('expenses'),
                              ),
                            ],
                            selected: cubit.segment),
                        const SizedBox(
                          height: 30,
                        ),
                        MyButton(
                            text: 'Add Transaction',
                            onTap: () {
                              if (cubit.formKey.currentState!.validate()) {
                               if(cubit.segment.isNotEmpty)
                                 {
                                   cubit.insertToDatabase(
                                     time: cubit.time.text,
                                     date: cubit.date.text,
                                     category: cubit.category.text,
                                     amount: cubit.money.text,
                                     type: cubit.segment.first,
                                   );
                                   Navigator.pop(context);
                                 }
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
