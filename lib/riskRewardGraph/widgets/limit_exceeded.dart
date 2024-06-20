import 'package:flutter/material.dart';

/// Widget do display when [OptionContract] length exceeds 4
class LimitExceeded extends StatelessWidget {

  /// Displays this Widget when [OptionContract] length exceeds maximum of 4 items
  const LimitExceeded({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('Exceeded max limit of 4 contracts', style: TextStyle(fontSize: 24.0,),),
    );
  }
}
