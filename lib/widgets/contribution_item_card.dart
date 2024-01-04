import 'package:budget_tracker/models/expense.dart';
import 'package:flutter/material.dart';

class ContributionItemCard extends StatelessWidget {
  const ContributionItemCard(this.contribution, {super.key});

  final Contribution contribution;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 16,
        ),
        child: 
            Row(
              children: [
                Text('₹ ${contribution.amount.toStringAsFixed(2)}'),
                const Spacer(),

                    Text(contribution.formattedDate),
                 
              ],
            ),
         
      ),
    );
  }
}