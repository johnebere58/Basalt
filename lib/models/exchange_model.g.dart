// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'exchange_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ExchangeModel _$ExchangeModelFromJson(Map<String, dynamic> json) =>
    ExchangeModel(
      json['name'] as String,
      json['acronym'] as String,
      json['mic'] as String,
      json['country'] as String,
      json['country_code'] as String,
      json['city'] as String,
      json['website'] as String,
      CurrencyModel.fromJson(json['currency'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ExchangeModelToJson(ExchangeModel instance) =>
    <String, dynamic>{
      'name': instance.name,
      'acronym': instance.acronym,
      'mic': instance.mic,
      'country': instance.country,
      'country_code': instance.country_code,
      'city': instance.city,
      'website': instance.website,
      'currency': instance.currency,
    };
