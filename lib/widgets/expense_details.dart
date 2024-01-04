import 'package:budget_tracker/models/expense.dart';
import 'package:budget_tracker/widgets/contribution_item_card.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class ExpenseDetails extends StatefulWidget {
  const ExpenseDetails(this.expense, {super.key});
  final Expense expense;

  @override
  State<ExpenseDetails> createState() => _ExpenseDetailsState();
}

class _ExpenseDetailsState extends State<ExpenseDetails> {
  late List<GDPData> _chartData;
  late TooltipBehavior _tooltipBehavior;

  @override
  void initState() {
    _chartData = getChartData();
    _tooltipBehavior = TooltipBehavior(enable: true);
    super.initState();
  }

  double calculateTotalContributionAmount() {
    double totalAmount = 0.0;

    if (widget.expense.contributions != null) {
      widget.expense.contributions!.forEach((key, value) {
        if (value['amount'] != null) {
          totalAmount += value['amount'];
        }
      });
    }

    return totalAmount;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            appBar: AppBar(
                title: Text(
              "Goal Details",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            )),
            body: Padding(
              padding: const EdgeInsets.all(10),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Text(
                      widget.expense.title,
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.purple),
                    ),
                    const SizedBox(height: 10),
                    SfCircularChart(
                      legend: Legend(
                          isVisible: true,
                          overflowMode: LegendItemOverflowMode.wrap),
                      tooltipBehavior: _tooltipBehavior,
                      series: <CircularSeries>[
                        PieSeries<GDPData, String>(
                          dataSource: _chartData,
                          xValueMapper: (GDPData data, _) => data.continent,
                          yValueMapper: (GDPData data, _) => data.gdp,
                          dataLabelSettings: DataLabelSettings(isVisible: true),
                          enableTooltip: true,
                        )
                      ],
                    ),
                    const SizedBox(height: 10),
                    Text(
                      "Contribution History",
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.black),
                    ),
                    const SizedBox(height: 10),
                    Column(
                      children:
                          widget.expense.contributions.entries.map((entry) {
                        return ContributionItemCard(
                          Contribution(
                            amount: entry.value['amount'],
                            date: DateTime.parse(entry.value['date']),
                          ),
                        );
                      }).toList(),
                    ),
                  ],
                ),
              ),
            )));
  }

  List<GDPData> getChartData() {
    final List<GDPData> chartData = [
      GDPData('Target Amount', widget.expense.targetamount.toInt()),
      GDPData('Saved Amount', calculateTotalContributionAmount().toInt()),
    ];
    return chartData;
  }
}

class GDPData {
  GDPData(this.continent, this.gdp);
  final String continent;
  final int gdp;
}
