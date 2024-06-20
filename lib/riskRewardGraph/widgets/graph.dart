import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_challenge/riskRewardGraph/model/profit_loss_contract_result.dart';
import 'package:flutter_challenge/riskRewardGraph/model/risk_reward_analysis.dart';
import 'package:flutter_challenge/riskRewardGraph/utils/extensions/color_extension.dart';

/// A Graph Widget to plot graph UI
class Graph extends StatelessWidget {
  /// A [Graph] Widget to plot graph UI
  const Graph(
      {super.key,
      required this.lineColors,
      required this.profitLossData,
      required this.analysis,
      required this.numOfLines});

  /// Indicates number of line graph we need to plot
  final int numOfLines;

  /// List of [Color] for each line graph
  final List<Color> lineColors;

  /// Calculated profit and loss data
  final List<List<ProfitLossContractResult>> profitLossData;

  /// generated analysis data
  final RiskRewardAnalysis analysis;

  @override
  Widget build(BuildContext context) {
    List<LineChartBarData> lines = [];

    for (int i = 0; i < numOfLines; i++) {
      List<FlSpot> spots = profitLossData[i].map((data) {
        return FlSpot(data.underlyingPrice, data.profitLoss);
      }).toList();

      /// getting a color for each line graph
      Color lineColor = lineColors[i];

      /// Create gradient colors for the line
      List<Color> gradientColors = [
        lineColor,
        lineColor.darken(30),
      ];

      /// Create gradient for the line
      LinearGradient gradient = LinearGradient(
        begin: Alignment.bottomCenter,
        end: Alignment.topCenter,
        colors: gradientColors,
      );

      /// adding each line to graph
      lines.add(
        LineChartBarData(
          gradient: gradient,
          spots: spots,
          isCurved: false,
          color: lineColor,
          barWidth: 0.1,
          belowBarData: BarAreaData(
            show: false,
            gradient: gradient,
          ),
          isStepLineChart: false,
        ),
      );
    }

    return LineChart(
      LineChartData(
        gridData: const FlGridData(show: true),
        titlesData: const FlTitlesData(
          show: true,
          rightTitles: AxisTitles(
            axisNameWidget: Text('Profit/Loss'),
          ),
          topTitles: AxisTitles(
            axisNameWidget: Text(
              'Underlying price',
            ),
            axisNameSize: 24,
          ),
        ),
        borderData: FlBorderData(
          show: false,
        ),
        lineBarsData: lines,
        lineTouchData: LineTouchData(
          enabled: true,
          touchTooltipData: LineTouchTooltipData(
              fitInsideHorizontally: true,
              fitInsideVertically: true,
              getTooltipColor: (spot) {
                return Theme.of(context).hintColor.withOpacity(0.6);
              },
              getTooltipItems: (touchedSpots) {
                return touchedSpots.map(
                  (LineBarSpot touchedSpot) {
                    TextStyle textStyle = TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                        color: lineColors[touchedSpot.barIndex]);
                    return LineTooltipItem('', textStyle, children: [
                      TextSpan(
                        text: touchedSpot.x.toStringAsFixed(2),
                        style: const TextStyle(fontSize: 12),
                      ),
                      const TextSpan(
                        text: ', ',
                        style: TextStyle(
                            fontSize: 12, fontWeight: FontWeight.bold),
                      ),
                      TextSpan(
                        text: touchedSpot.y.toStringAsFixed(2),
                        style: const TextStyle(fontSize: 12),
                      ),
                    ]);
                  },
                ).toList();
              }),
        ),
        extraLinesData: ExtraLinesData(
            horizontalLines: [
              HorizontalLine(
                y: 0,
                color: Colors.black,
                strokeWidth: 2,
                dashArray: [5, 10],
                label: HorizontalLineLabel(
                  show: true,
                  alignment: Alignment.topCenter,
                  padding: const EdgeInsets.only(right: 5),
                  style: const TextStyle(
                    fontSize: 9,
                    fontWeight: FontWeight.bold,
                  ),
                  labelResolver: (line) => 'Break even',
                ),
              ),
            ],
            verticalLines: analysis.breakEvenPoints
                .map((bp) => VerticalLine(
                      x: bp,
                      color: Colors.green,
                      strokeWidth: 2,
                      dashArray: [5, 10],
                      label: VerticalLineLabel(
                        show: true,
                        alignment: Alignment.bottomCenter,
                        padding: const EdgeInsets.only(right: 5),
                        style: const TextStyle(
                          fontSize: 9,
                          fontWeight: FontWeight.bold,
                        ),
                        labelResolver: (line) => bp.toStringAsFixed(2),
                      ),
                    ))
                .toList()),
      ),
    );
  }
}
