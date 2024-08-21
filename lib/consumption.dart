import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:fl_chart/fl_chart.dart';

class ConsumptionPage extends StatefulWidget {
  const ConsumptionPage({super.key, required this.title});

  final String title;

  @override
  State<ConsumptionPage> createState() => _ConsumptionPageState();
}

class _ConsumptionPageState extends State<ConsumptionPage> {
  List<PieChartSectionData> _sections = [];

  @override
  void initState() {
    super.initState();
    _fetchData();
  }

  Future<void> _fetchData() async {
    final response = await http.get(
        Uri.parse(
          'https://api.electricitymap.org/v3/power-breakdown/latest?zone=IT',
        ),
        headers: {"auth-token": "Tuo8m2YxF1x43"});
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final powerBreakdown = data['powerConsumptionBreakdown'];
      setState(() {
        _sections = _createPieChartSections(powerBreakdown);
      });
    } else {
      throw Exception('Failed to load data');
    }
  }

  List<PieChartSectionData> _createPieChartSections(Map<String, dynamic> data) {
    final List<Color> colors = [
      CupertinoColors.systemRed,
      CupertinoColors.systemTeal,
      CupertinoColors.systemBrown,
      CupertinoColors.black,
      CupertinoColors.activeBlue,
      CupertinoColors.systemOrange,
      CupertinoColors.systemMint,
      CupertinoColors.systemYellow,
      CupertinoColors.systemGrey,
      CupertinoColors.systemGrey2,
      CupertinoColors.systemCyan,
      CupertinoColors.systemIndigo,
    ];

    int colorIndex = 0;

    return data.entries.map((entry) {
      final value = entry.value.toDouble();
      final color = colors[colorIndex % colors.length];
      colorIndex++;

      return PieChartSectionData(
        color: color,
        value: value,
        radius: 200,
        borderSide: const BorderSide(color: CupertinoColors.white, width: 2),
        title: entry.key,
      );
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      child: Center(
        child: _sections.isEmpty
            ? const CupertinoActivityIndicator()
            : PieChart(
                PieChartData(
                  sections: _sections,
                ),
              ),
      ),
    );
  }
}
