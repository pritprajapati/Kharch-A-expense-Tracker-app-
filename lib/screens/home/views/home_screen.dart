import 'dart:math';
import 'package:expenses_repository/expense_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kharcha/screens/home/bloc/get_expense_bloc/get_expense_bloc.dart';
import 'package:kharcha/screens/home/views/main_screen.dart';
import 'package:kharcha/screens/new_expense/blocs/create_category_bloc/create_category_bloc.dart';
import 'package:kharcha/screens/new_expense/blocs/get_category_bloc/get_category_bloc.dart';
import 'package:kharcha/screens/new_expense/views/add_expense.dart';
import 'package:kharcha/screens/stats/stats.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../new_expense/blocs/create_expense_bloc/create_expense_bloc.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GetExpenseBloc, GetExpenseState>(
      builder: (context, state) {
        if (state is GetExpenseSuccess) {
          return Scaffold(
            bottomNavigationBar: BottomNavigationBar(
              onTap: (index) {
                setState(() {
                  _selectedIndex = index;
                });
              },
              backgroundColor: Colors.white,
              currentIndex: _selectedIndex,
              items: const [
                BottomNavigationBarItem(
                  icon: Icon(CupertinoIcons.home),
                  label: "Home",
                ),
                BottomNavigationBarItem(
                  icon: Icon(CupertinoIcons.graph_circle_fill),
                  label: "Stats",
                ),
              ],
              selectedItemColor:
                  Theme.of(context).primaryColor, // Selected item color
              unselectedItemColor: Colors.grey, // Unselected item color
            ),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerDocked,
            floatingActionButton: FloatingActionButton(
              onPressed: () async {
                Expense? newExpense = await Navigator.push(
                  context,
                  MaterialPageRoute<Expense>(
                    builder: (BuildContext context) => MultiBlocProvider(
                      providers: [
                        BlocProvider(
                          create: (context) =>
                              CreateCategoryBloc(FirebaseExpenseRepo()),
                        ),
                        BlocProvider(
                          create: (context) =>
                              GetCategoryBloc(FirebaseExpenseRepo())
                                ..add(
                                  GetCategory(),
                                ),
                        ),
                        BlocProvider(
                          create: (context) =>
                              CreateExpenseBloc(FirebaseExpenseRepo()),
                        ),
                      ],
                      child: const AddExpense(),
                    ),
                  ),
                );

                if (newExpense != null) {
                  setState(() {
                    state.expense.insert(0, newExpense);
                  });
                }
              },
              shape: const CircleBorder(),
              child: Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: LinearGradient(
                    colors: [
                      Theme.of(context).colorScheme.tertiary,
                      Theme.of(context).colorScheme.secondary,
                      Theme.of(context).colorScheme.primary,
                    ],
                    transform: const GradientRotation(pi / 4),
                  ),
                ),
                child: const Icon(
                  CupertinoIcons.add,
                ),
              ),
            ),
            body: _selectedIndex == 0
                ? MainScreen(state.expense)
                : const StatScreen(),
          );
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}
