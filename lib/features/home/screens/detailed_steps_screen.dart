import 'package:fitness_application/core/pallet/pallet.dart';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SimpleBarChart extends ConsumerWidget {
  SideTitles get _bottomTitles => SideTitles(
        showTitles: true,
        getTitlesWidget: (value, meta) {
          String text = '';
          switch (value.toInt()) {
            case 1:
              text = 'Sun';
              break;
            case 2:
              text = 'Mon';
              break;
            case 3:
              text = 'Tue';
              break;
            case 4:
              text = 'Wed';
              break;
            case 5:
              text = 'Thu';
              break;
            case 6:
              text = 'Fri';
              break;
            case 7:
              text = 'Sat';
              break;
          }

          return Text(text);
        },
      );

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Simple Bar Chart'),
      ),
      body: Column(
        children: [
          const SizedBox(height: 20,),
          SizedBox(
            width: double.infinity,
            height: 400,
            child: BarChart(
              BarChartData(
                titlesData: FlTitlesData(
                  bottomTitles: AxisTitles(sideTitles: _bottomTitles),
                  topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                  rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                ),
                borderData: FlBorderData(
                  border: Border(
                      bottom: BorderSide(
                          color: ref
                              .watch(themeNotifierProvider)
                              .iconTheme
                              .color!),
                      left: BorderSide(
                          color: ref
                              .watch(themeNotifierProvider)
                              .iconTheme
                              .color!)),
                ),
                gridData: const FlGridData(show: false),
                backgroundColor: ref
                    .watch(themeNotifierProvider)
                    .appBarTheme
                    .backgroundColor,
                groupsSpace: 10,
                // add bars
                barGroups: [
                  BarChartGroupData(
                    x: 1,
                    barRods: [
                      BarChartRodData(
                        toY: 10, //this is the height of the bar
                        width: 15,
                        color: Colors.cyan,
                      ),
                    ],
                  ),
                  BarChartGroupData(
                    x: 2,
                    barRods: [
                      BarChartRodData(
                        toY: 9,
                        width: 15,
                        color: Colors.cyan,
                      ),
                    ],
                  ),
                  BarChartGroupData(
                    x: 3,
                    barRods: [
                      BarChartRodData(
                        toY: 4,
                        width: 15,
                        color: Colors.cyan,
                      ),
                    ],
                  ),
                  BarChartGroupData(
                    x: 4,
                    barRods: [
                      BarChartRodData(
                        toY: 2,
                        width: 15,
                        color: Colors.cyan,
                      ),
                    ],
                  ),
                  BarChartGroupData(
                    x: 5,
                    barRods: [
                      BarChartRodData(
                        toY: 6,
                        width: 15,
                        color: Colors.cyan,
                      ),
                    ],
                  ),
                  BarChartGroupData(
                    x: 6,
                    barRods: [
                      BarChartRodData(
                        toY: 7,
                        width: 15,
                        color: Colors.cyan,
                      ),
                    ],
                  ),
                  BarChartGroupData(
                    x: 7,
                    barRods: [
                      BarChartRodData(
                        toY: 10,
                        width: 15,
                        color: Colors.cyan,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
