import 'package:flutter/material.dart';
import 'package:flutter_challenge/riskRewardGraph/model/risk_reward_analysis.dart';
import 'package:flutter_challenge/riskRewardGraph/services/risk_reward.dart';
import 'package:flutter_challenge/riskRewardGraph/utils/utils.dart';
import 'package:flutter_challenge/riskRewardGraph/widgets/analysis.dart';
import 'package:flutter_challenge/riskRewardGraph/widgets/graph.dart';
import 'package:flutter_challenge/riskRewardGraph/widgets/limit_exceeded.dart';

import 'model/option_contract.dart';
import 'model/profit_loss_contract_result.dart';

/// A Parent widget to render on graph UI along with
/// Analysis like max profit, max loss and breakpoints
class RiskRewardGraph extends StatefulWidget {
  /// [RiskRewardGraph] to display risk reward graph and analysis UI
  ///
  /// Underlying prices on X-axis
  /// Profit/Loss on Y-axis
  ///
  /// ```dart
  /// RiskRewardGraph(
  ///    optionContracts: widget.optionsData
  ///         .map((data) => OptionContract.fromJson(data))
  ///          .toList()),
  /// ```
  const RiskRewardGraph(
      {super.key, required this.optionContracts, this.width, this.height});

  /// A List of [OptionContract] to be displayed in graph
  ///
  /// Length of List should not exceed maximum of 4 items.
  final List<OptionContract> optionContracts;

  /// An optional parameter to specify width of the graph
  ///
  /// If not provided, width defaults to 90% of screen width
  final double? width;

  /// An optional parameter to specify height of the graph
  /// If not provided, height defaults to 40% of screen height
  final double? height;

  @override
  State<RiskRewardGraph> createState() => _RiskRewardGraphState();
}

class _RiskRewardGraphState extends State<RiskRewardGraph> {
  late List<Color> lineColors;

  @override
  void initState() {
    super.initState();
    lineColors = Utils.getRandomColor(widget.optionContracts.length);
  }

  @override
  Widget build(BuildContext context) {
    /// Throwing error UI if list contains more than 4 item to display on graph
    if (widget.optionContracts.length > 4) {
      return const LimitExceeded();
    }

    /// Generating points for X-axis
    List<double> underlyingPrices =
        List.generate(500, (index) => 90 + index * (120 - 90) / 499);

    /// Calculating profit and loss
    List<List<ProfitLossContractResult>> profitLossData =
        RiskReward.calculateProfitLoss(
            widget.optionContracts, underlyingPrices);

    /// Calculating analysis data
    RiskRewardAnalysis analysis =
        RiskReward.analyzeStrategy(widget.optionContracts);

    /// Adjusting Graph layout based on device orientation
    return OrientationBuilder(builder: (context, orientation) {
      if (orientation == Orientation.portrait) {
        return Column(
          children: [
            Analysis(analysis: analysis),
            const SizedBox(
              height: 36.0,
            ),
            SizedBox(
              height: widget.height ?? MediaQuery.of(context).size.height * .4,
              width: widget.width ?? MediaQuery.of(context).size.width * .9,
              child: Graph(
                  numOfLines: widget.optionContracts.length,
                  lineColors: lineColors,
                  profitLossData: profitLossData,
                  analysis: analysis),
            ),
          ],
        );
      } else {
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Analysis(analysis: analysis),
            const SizedBox(
              width: 36.0,
            ),
            SizedBox(
              height: widget.height ?? MediaQuery.of(context).size.height * .9,
              width: widget.width ?? MediaQuery.of(context).size.width * .6,
              child: Graph(
                  numOfLines: widget.optionContracts.length,
                  lineColors: lineColors,
                  profitLossData: profitLossData,
                  analysis: analysis),
            ),
          ],
        );
      }
    });
  }
}
