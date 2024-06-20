import 'package:flutter_challenge/riskRewardGraph/model/risk_reward_analysis.dart';

import '../model/option_contract.dart';
import '../model/profit_loss_contract_result.dart';

/// [RiskReward] holds the necessary method to perform the calculations
class RiskReward {

  /// Method to calculate profit and loss
  static List<List<ProfitLossContractResult>> calculateProfitLoss(List<OptionContract> contracts, List<double> underlyingPrices) {

    List<List<ProfitLossContractResult>> result = [];

    for (var contract in contracts) {
      List<ProfitLossContractResult> contractResult = [];

      for (var price in underlyingPrices) {
        double contractProfitLoss = 0.0;

        if (contract.type == OptionType.call) {
          if (contract.longShort == PositionType.long) {
            contractProfitLoss = (price > contract.strikePrice ? price - contract.strikePrice : 0) - contract.ask;
          } else {
            contractProfitLoss = contract.bid - (price > contract.strikePrice ? price - contract.strikePrice : 0);
          }
        } else if (contract.type == OptionType.put) {
          if (contract.longShort == PositionType.long) {
            contractProfitLoss = (price < contract.strikePrice ? contract.strikePrice - price : 0) - contract.ask;
          } else {
            contractProfitLoss = contract.bid - (price < contract.strikePrice ? contract.strikePrice - price : 0);
          }
        }

        contractResult.add(ProfitLossContractResult(price, contractProfitLoss));
      }

      result.add(contractResult);
    }

    return result;
  }

  /// Method to generate analysis
  static RiskRewardAnalysis analyzeStrategy(List<OptionContract> contracts) {
    List<double> underlyingPrices = List.generate(500, (index) => 90 + index * (120 - 90) / 499);
    List<List<ProfitLossContractResult>> profitLossData = calculateProfitLoss(contracts, underlyingPrices);

    double maxProfit = double.negativeInfinity;
    double maxLoss = double.infinity;
    List<double> breakEvenPoints = [];

    for (var contractData in profitLossData) {
      for (var data in contractData) {
        double profitLoss = data.profitLoss;
        if (profitLoss > maxProfit) maxProfit = profitLoss;
        if (profitLoss < maxLoss) maxLoss = profitLoss;

        if (data != contractData.first && data != contractData.last) {
          double previousProfitLoss = contractData[contractData.indexOf(data) - 1].profitLoss;
          if ((profitLoss > 0 && previousProfitLoss < 0) || (profitLoss < 0 && previousProfitLoss > 0)) {
            breakEvenPoints.add(data.underlyingPrice);
          }
        }
      }
    }

    return RiskRewardAnalysis(maxProfit, maxLoss, breakEvenPoints);
  }


}