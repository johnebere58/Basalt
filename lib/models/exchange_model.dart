// ignore_for_file: non_constant_identifier_names
import 'package:basalt/models/currency_model.dart';
import 'package:json_annotation/json_annotation.dart';
part 'exchange_model.g.dart';

@JsonSerializable()
class ExchangeModel{

  late String name;
  late String acronym;
  late String mic;
  late String country;
  late String country_code;
  late String city;
  late String website;
  // late CurrencyModel currency;

  ExchangeModel(this.name, this.acronym, this.mic, this.country,
      this.country_code, this.city, this.website);

  /// Connect the generated [_$ExchangeModelFromJson] function to the `fromJson`
  /// factory.
  factory ExchangeModel.fromJson(Map<String, dynamic> json) => _$ExchangeModelFromJson(json);

  /// Connect the generated [_$ExchangeModelToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$ExchangeModelToJson(this);
}