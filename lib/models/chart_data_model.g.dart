// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chart_data_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ChartDataModel _$ChartDataModelFromJson(Map<String, dynamic> json) =>
    ChartDataModel(
      (json['open']??0).toDouble(),
      (json['high']??0).toDouble(),
      (json['low']??0).toDouble(),
      (json['last']??0).toDouble(),
      (json['close']??0).toDouble(),
      (json['volume']??0).toDouble(),
      (json['date']??"") as String,
      (json['symbol']??"") as String,
      (json['exchange']??"") as String,
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
