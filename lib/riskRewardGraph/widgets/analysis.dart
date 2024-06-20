import 'package:flutter/material.dart';
import 'package:flutter_challenge/riskRewardGraph/model/risk_reward_analysis.dart';

import 'analysis_item.dart';

/// Widget to display analysis data
class Analysis extends StatelessWidget {

  /// [Analysis] to display analysis data like max profit, max loss, and breakpoints
  ///
  /// ``` dart
  /// Analysis(analysis: analysis)
  /// ```
  const Analysis({super.key, required this.analysis});

  /// [RiskRewardAnalysis] has data of [maxProfit], [maxLoss] and [breakpoints]
  final RiskRewardAnalysis analysis;

  @override
  Widget build(BuildContext context) {
    return OrientationBuilder(builder: (context, orientation) {
      if(orientation == Orientation.portrait){
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            AnalysisItem(
              title: 'Max Profit',
              color: Colors.green,
              value: analysis.maxProfit.toStringAsFixed(2),
            ),
            AnalysisItem(
              title: 'Max Loss',
              color: Colors.red,
              value: analysis.maxLoss.toStringAsFixed(2),
            ),
            AnalysisItem(
                title: 'Breakpoints',
                value: analysis.breakEvenPoints
                    .map((el) => el.toStringAsFixed(2))
                    .join(', ')),
          ],
        );
      }else{
        return Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            AnalysisItem(
              title: 'Max Profit',
              color: Colors.green,
              value: analysis.maxProfit.toStringAsFixed(2),
            ),
            AnalysisItem(
              title: 'Max Loss',
              color: Colors.red,
              value: analysis.maxLoss.toStringAsFixed(2),
            ),
            AnalysisItem(
                title: 'Breakpoints',
                value: analysis.breakEvenPoints
                    .map((el) => el.toStringAsFixed(2))
                    .join(', ')),
          ],
        );
      }
    });

  }
}
