import 'package:flutter/material.dart';

/// A reusable Widget for Analysis
class AnalysisItem extends StatelessWidget {

  /// [AnalysisItem] to display [title], [value] and [color] to the value
  ///
  /// ``` dart
  /// AnalysisItem(
  ///           title: 'Max Profit',
  ///           color: Colors.green,
  ///           value: analysis.maxProfit.toStringAsFixed(2),
  ///         ),
  /// ```
  const AnalysisItem(
      {super.key, required this.title, required this.value, this.color});

  /// [title] takes [String] which displays on top of [AnalysisItem] as header
  final String title;

  /// [color], an optional parameter which takes [Color] to display [value] in color
  final Color? color;

  /// [value] takes [String] which displays on bottom of [AnalysisItem] as body item
  final String value;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          title,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        Text(
          value,
          style: TextStyle(color: color),
        ),
      ],
    );
  }
}
