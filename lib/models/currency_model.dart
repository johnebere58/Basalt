import 'package:json_annotation/json_annotation.dart';
part 'currency_model.g.dart';

@JsonSerializable()
class CurrencyModel{

  late String code;
  late String symbol;
  late String name;

  CurrencyModel(this.code, this.symbol, this.name);

  /// Connect the generated [_$CurrencyModelFromJson] function to the `fromJson`
  /// factory.
  factory CurrencyModel.fromJson(Map<String, dynamic> json) => _$CurrencyModelFromJson(json);

  /// Connect the generated [_$CurrencyModelToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$CurrencyModelToJson(this);
}