import 'dart:math';

import 'package:flutter/material.dart';

class Utils {

  /// Method to get randomized list of [Color]
  static List<Color> getRandomColor(int count) {
    List<Color> materialColors = [
      Colors.blue,
      Colors.red,
      Colors.orange,
      Colors.purple,
      Colors.indigo,
      Colors.lime,
      Colors.cyan
    ];

    final List<Color> recentlyUsedColors = [];
    final int maxRecentColors = count;
    List<Color> uniqueColors = [];
    Random random = Random();

    /// we are making sure none of the lines in graph should have same random color
    while (uniqueColors.length < count) {
      Color randomColor = materialColors[random.nextInt(materialColors.length)];
      if (!uniqueColors.contains(randomColor) && !recentlyUsedColors.contains(randomColor)) {
        uniqueColors.add(randomColor);
        recentlyUsedColors.add(randomColor);
        if (recentlyUsedColors.length > maxRecentColors) {
          recentlyUsedColors.removeAt(0);
        }
      }
    }

    return uniqueColors;
  }
}