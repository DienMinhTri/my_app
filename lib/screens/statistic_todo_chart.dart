import 'package:flutter/material.dart';
import 'package:my_app/models/statusProfile.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class StatisticTodoScreen extends StatefulWidget {
  const StatisticTodoScreen({super.key});

  @override
  State<StatisticTodoScreen> createState() => _StatisticTodoScreenState();
}

class _StatisticTodoScreenState extends State<StatisticTodoScreen> {
  late List<StatusProfile> _chartStatus;
  TooltipBehavior? _tooltipBehavior;
  @override
  void initState() {
    _chartStatus = getChartStatus();
    _tooltipBehavior = TooltipBehavior(enable: true);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(),
        body: SfCircularChart(
          title: ChartTitle(text: 'Percentage of completing the day`s work'),
          legend: Legend(
            isVisible: true,
            overflowMode: LegendItemOverflowMode.wrap,
          ),
          tooltipBehavior: _tooltipBehavior,
          series: <CircularSeries>[
            DoughnutSeries<StatusProfile, String>(
              dataSource: _chartStatus,
              xValueMapper: (data, _) => data.statusText,
              yValueMapper: (data, _) => data.status,
              dataLabelSettings: DataLabelSettings(
                isVisible: true,
              ),
              enableTooltip: true,
              legendIconType: LegendIconType.diamond,
            ),
          ],
        ),
      ),
    );
  }

  List<StatusProfile> getChartStatus() {
    final List<StatusProfile> chartStatus = [
      StatusProfile(statusText: "Game", status: 2),
      StatusProfile(statusText: "Work", status: 22),
      StatusProfile(statusText: "Play", status: 50),
      StatusProfile(statusText: "Run", status: 10),
    ];
    return chartStatus;
  }
}
