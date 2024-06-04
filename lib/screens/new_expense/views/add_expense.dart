import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:kharcha/screens/new_expense/blocs/get_category_bloc/get_category_bloc.dart';
import 'package:kharcha/screens/new_expense/views/category_creation.dart';
import 'package:expenses_repository/expense_repository.dart';
import 'package:expenses_repository/src/models/category.dart';
import 'package:uuid/uuid.dart';

import '../blocs/create_expense_bloc/create_expense_bloc.dart';

class AddExpense extends StatefulWidget {
  const AddExpense({super.key});

  @override
  State<AddExpense> createState() => _AddExpenseState();
}

class _AddExpenseState extends State<AddExpense> {
  TextEditingController exenseController = TextEditingController();
  TextEditingController categoryController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  bool isLoading = false;

  late Expense expense;

  @override
  void initState() {
    dateController.text = DateFormat('dd/MM/yyyy').format(DateTime.now());
    expense = Expense.empty;
    expense.expenseId = const Uuid().v1();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<CreateExpenseBloc, CreateExpenseState>(
      listener: (context, state) {
        if (state is CreateExpenseSuccess) {
          Navigator.pop(context, expense);
        } else if (state is CreateExpenseLoading) {
          setState(() {
            isLoading = true;
          });
        }
      },
      child: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Scaffold(
          backgroundColor: Theme.of(context).colorScheme.surface,
          appBar: AppBar(
            backgroundColor: Theme.of(context).colorScheme.surface,
          ),
          body: BlocBuilder<GetCategoryBloc, GetCategoryState>(
            builder: (context, state) {
              if (state is GetCategorySuccess) {
                return Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      Text(
                        'Add expense',
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                              fontSize: 22,
                              fontWeight: FontWeight.w500,
                            ),
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.7,
                        child: TextFormField(
                          controller: exenseController,
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.white,
                            prefixIcon: const Icon(
                              FontAwesomeIcons.indianRupeeSign,
                              size: 16,
                              color: Colors.grey,
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30),
                              borderSide: BorderSide.none,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 32,
                      ),
                      TextFormField(
                        readOnly: true,
                        onTap: () {},
                        controller: categoryController,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: expense.category == Category.empty
                              ? Colors.white
                              : Color(expense.category.color),
                          // ignore: unrelated_type_equality_checks
                          prefixIcon: expense.category == Category.empty
                              ? const Icon(
                                  FontAwesomeIcons.list,
                                  size: 16,
                                  color: Colors.grey,
                                )
                              : Image.asset(
                                  'assets/${expense.category.icon}.png',
                                  scale: 1.5,
                                ),
                          suffixIcon: IconButton(
                            onPressed: () async {
                              var newCategory =
                                  await getCategoryCreation(context);
                              setState(() {
                                state.category.insert(0, newCategory);
                              });
                            },
                            icon: const Icon(
                              FontAwesomeIcons.circlePlus,
                              size: 20,
                              color: Colors.grey,
                            ),
                          ),
                          hintText: 'Category',
                          border: const OutlineInputBorder(
                            borderRadius: BorderRadius.vertical(
                              top: Radius.circular(12),
                            ),
                            borderSide: BorderSide.none,
                          ),
                        ),
                      ),
                      Container(
                        height: 200,
                        width: MediaQuery.of(context).size.width,
                        // color: Colors.red,
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.vertical(
                            top: Radius.circular(12),
                          ),
                        ),
                        child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ListView.builder(
                              itemCount: state.category.length,
                              itemBuilder: (context, int i) {
                                return Card(
                                  child: ListTile(
                                    onTap: () {
                                      setState(() {
                                        expense.category = state.category[i];
                                        categoryController.text =
                                            state.category[i].name;
                                      });
                                    },
                                    leading: Image.asset(
                                      'assets/${state.category[i].icon}.png',
                                      scale: 1.5,
                                    ),
                                    title: Text(state.category[i].name),
                                    tileColor: Color(state.category[i].color),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                  ),
                                );
                              },
                            )),
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      TextFormField(
                        controller: dateController,
                        readOnly: true,
                        onTap: () async {
                          DateTime? newDate = await showDatePicker(
                            context: context,
                            initialDate: expense.date,
                            firstDate: DateTime.now().subtract(
                              const Duration(days: 365),
                            ),
                            lastDate: DateTime.now().add(
                              const Duration(days: 365),
                            ),
                          );
                          if (newDate != null) {
                            dateController.text =
                                DateFormat('dd/MM/yyyy').format(newDate);
                            expense.date = newDate;
                          }
                        },
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          prefixIcon: const Icon(
                            FontAwesomeIcons.calendar,
                            size: 16,
                            color: Colors.grey,
                          ),
                          hintText: 'Date',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide.none,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      SizedBox(
                        width: double.infinity,
                        height: kToolbarHeight,
                        child: isLoading
                            ? const Center(
                                child: CircularProgressIndicator(),
                              )
                            : TextButton(
                                onPressed: () {
                                  setState(() {
                                    expense.amount =
                                        int.parse(exenseController.text);
                                  });
                                  context.read<CreateExpenseBloc>().add(
                                        CreateExpense(expense),
                                      );
                                },
                                style: TextButton.styleFrom(
                                    backgroundColor: Colors.teal,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12),
                                    )),
                                child: Text(
                                  'Save',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyLarge
                                      ?.copyWith(
                                          fontSize: 22, color: Colors.white),
                                ),
                              ),
                      ),
                    ],
                  ),
                );
              } else {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
            },
          ),
        ),
      ),
    );
  }
}
