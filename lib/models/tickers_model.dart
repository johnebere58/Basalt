import 'package:basalt/basalt.dart';
import 'package:json_annotation/json_annotation.dart';
part 'tickers_model.g.dart';

@JsonSerializable()
class TickersModel{

  late String symbol;
  late String name;
  late ExchangeModel stock_exchange;

  TickersModel(this.symbol, this.name, this.stock_exchange);

  /// Connect the generated [_$TickersModelFromJson] function to the `fromJson`
  /// factory.
  factory TickersModel.fromJson(Map<String, dynamic> json) => _$TickersModelFromJson(json);

  /// Connect the generated [_$TickersModelToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$TickersModelToJson(this);
}