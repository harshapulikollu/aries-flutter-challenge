/// Model file to create an [OptionContract]
class OptionContract {
  final double strikePrice;
  final OptionType type; // "Call" or "Put"
  final double bid;
  final double ask;
  final PositionType longShort; // "long" or "short"
  final DateTime expirationDate;

  OptionContract({
    required this.strikePrice,
    required this.type,
    required this.bid,
    required this.ask,
    required this.longShort,
    required this.expirationDate,
  });

  factory OptionContract.fromJson(Map<String, dynamic> json) {
    return OptionContract(
      strikePrice: (json['strike_price'] as num).toDouble(),
      type: json['type'] == 'Call' ? OptionType.call : OptionType.put,
      bid: (json['bid'] as num).toDouble(),
      ask: (json['ask'] as num).toDouble(),
      longShort: json['long_short'] == 'long' ? PositionType.long : PositionType.short,
      expirationDate: DateTime.parse(json['expiration_date']),
    );
  }
}

enum OptionType { call, put }
enum PositionType { long, short }
