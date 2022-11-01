// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tickers_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TickersModel _$TickersModelFromJson(Map<String, dynamic> json) => TickersModel(
      json['symbol'] as String,
      json['name'] as String,
      ExchangeModel.fromJson(json['stock_exchange'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$TickersModelToJson(TickersModel instance) =>
    <String, dynamic>{
      'symbol': instance.symbol,
      'name': instance.name,
      'stock_exchange': instance.stock_exchange,
    };
