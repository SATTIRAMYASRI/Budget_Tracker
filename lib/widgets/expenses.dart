
import 'package:budget_tracker/models/expense.dart';
import 'package:budget_tracker/widgets/expenses_list/expenses_list.dart';
import 'package:budget_tracker/widgets/new_expense.dart';
import 'package:flutter/material.dart';

class Expenses extends StatefulWidget {
  const Expenses({super.key});

  @override
  State<Expenses> createState() {
    return _ExpensesState();
  }
}

class _ExpensesState extends State<Expenses> {
  List<Expense> _registeredExpenses = [
    Expense(
      title: 'Buy a house',
      targetamount: 150000,
      savedamount: 1000,
      date: DateTime.now(),
      category: Category.Critical,
      contributions: {
        "contribution_id_1": {
          "amount": 10000,
          "date": "2024-01-01"
        },
        "contribution_id_2": {
          "amount": 15000,
          "date": "2024-01-15"
        },
        "contribution_id_3": {
          "amount": 10000,
          "date": "2024-01-01"
        },
        "contribution_id_4": {
          "amount": 15000,
          "date": "2024-01-15"
        },
        "contribution_id_5": {
          "amount": 10000,
          "date": "2024-01-01"
        },
        "contribution_id_6": {
          "amount": 15000,
          "date": "2024-01-15"
        },"contribution_id_7": {
          "amount": 10000,
          "date": "2024-01-01"
        },
        "contribution_id_8": {
          "amount": 15000,
          "date": "2024-01-15"
        },
      },
    ),
    Expense(
      title: 'to buy a car',
      targetamount: 1000000,
      savedamount: 0,
      date: DateTime.now(),
      category: Category.Low,
      contributions: {
        "contribution_id_1": {
          "amount": 200,
          "date": "2024-02-02"
        },
        "contribution_id_2": {
          "amount": 100,
          "date": "2024-02-20"
        }
      },
    ),
  ];


  void _openAddExpenseOverlay() {
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (ctx) => NewExpense(onAddExpense: _addExpense),
    );
  }

  void _addExpense(Expense expense) {
    setState(() {
      _registeredExpenses.add(expense);
    });
  }

  void _removeExpense(Expense expense) {
    final expenseIndex = _registeredExpenses.indexOf(expense);
    setState(() {
      _registeredExpenses.remove(expense);
    });
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: const Duration(seconds: 3),
        content: const Text('Expense deleted.'),
        action: SnackBarAction(
          label: 'Undo',
          onPressed: () {
            setState(() {
              _registeredExpenses.insert(expenseIndex, expense);
            });
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Widget mainContent = const Center(
      child: Text('No expenses found. Start adding some!'),
    );

    if (_registeredExpenses.isNotEmpty) {
      mainContent = ExpensesList(
        expenses: _registeredExpenses,
        onRemoveExpense: _removeExpense,
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter ExpenseTracker'),
        actions: [
          IconButton(
            onPressed: _openAddExpenseOverlay,
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: mainContent,
        
    );
  }
}