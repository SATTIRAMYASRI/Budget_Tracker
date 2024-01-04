import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import 'package:intl/intl.dart';

final formatter = DateFormat.yMd();

const uuid = Uuid();

enum Category { Critical, High, Medium, Low, Optional }

const categoryIcons = {
  Category.Critical: Icons.whatshot,
  Category.High: Icons.star,
  Category.Medium: Icons.build,
  Category.Low: Icons.turn_sharp_right_rounded,
  Category.Optional: Icons.swipe_left_alt,
};

class Expense {
  final String id;
  final String title;
  final double targetamount;
  final double savedamount;
  final DateTime date;
  final Category category;
  final Map<String, dynamic> contributions;

  Expense({
    required this.contributions,
    required this.title,
    required this.targetamount,
    required this.savedamount,
    required this.date,
    required this.category,
  }) : id = uuid.v4();

  String get formattedDate {
    return formatter.format(date);
  }
}

class Contribution {
  final String id;
  final double amount;
  final DateTime date;

  Contribution({
    required this.amount,
    required this.date,
  }) : id = uuid.v4();

  String get formattedDate {
    return formatter.format(date);
  }
}
