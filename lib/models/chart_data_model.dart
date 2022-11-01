import 'package:json_annotation/json_annotation.dart';
part 'chart_data_model.g.dart';

@JsonSerializable()
class ChartDataModel{

  late double open;
  late double high;
  late double low;
  late double last;
  late double close;
  late double volume;
  late String date;
  late String symbol;
  late String exchange;

  /// Connect the generated [_$ChartDataModelFromJson] function to the `fromJson`
  /// factory.
  factory ChartDataModel.fromJson(Map<String, dynamic> json) => _$ChartDataModelFromJson(json);

  /// Connect the generated [_$ChartDataModelToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$ChartDataModelToJson(this);
  ChartDataModel(this.open, this.high, this.low, this.last, this.close,
      this.volume, this.date, this.symbol, this.exchange);


}