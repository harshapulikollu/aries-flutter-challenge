/// Model for [RiskRewardAnalysis]
class RiskRewardAnalysis {
  final double maxProfit;
  final double maxLoss;
  final List<double> breakEvenPoints;

  RiskRewardAnalysis(this.maxProfit, this.maxLoss, this.breakEvenPoints);
}
