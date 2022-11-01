// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chart_data_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ChartDataModel _$ChartDataModelFromJson(Map<String, dynamic> json) =>
    ChartDataModel(
      (json['open'] as num).toDouble(),
      (json['high'] as num).toDouble(),
      (json['low'] as num).toDouble(),
      (json['last'] as num).toDouble(),
      (json['close'] as num).toDouble(),
      (json['volume'] as num).toDouble(),
      json['date'] as String,
      json['symbol'] as String,
      json['exchange'] as String,
    );

Map<String, dynamic> _$ChartDataModelToJson(ChartDataModel instance) =>
    <String, dynamic>{
      'open': instance.open,
      'high': instance.high,
      'low': instance.low,
      'last': instance.last,
      'close': instance.close,
      'volume': instance.volume,
      'date': instance.date,
      'symbol': instance.symbol,
      'exchange': instance.exchange,
    };
