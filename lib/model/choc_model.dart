class TotalListChoc {
  final List<ChocModel> choc;
  TotalListChoc({required this.choc});

  factory TotalListChoc.fromJson(List<dynamic> json) {
    List<ChocModel> choc = <ChocModel>[];
    choc = json.map((i) => ChocModel.fromJson(i)).toList();
    return TotalListChoc(
        choc: choc
    );
  }
}

/// parse the JSON response into dart objects
class ChocModel  {
  String? chocolateType;
  String? productionDate;
  String? volume;

  ChocModel({this.chocolateType, this.productionDate, this.volume});

  /// convert from JSON to model
  ChocModel.fromJson(Map<String, dynamic> json) {
    chocolateType = json['chocolate_type'];
    productionDate = json['production_date'];
    volume = json['volume'];
  }

  /// convert from model to JSON
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['chocolate_type'] = this.chocolateType;
    data['production_date'] = this.productionDate;
    data['volume'] = this.volume;
    return data;
  }

  @override
  String toString() { return 'choclateType: $chocolateType | volume: $volume \n';}
}

class ChartData {
  final String chocolateType;
  final int volume;

  ChartData(this.chocolateType, this.volume);
}

class ChartDataChoc {
  final String month;
  final int volume;

  ChartDataChoc(this.month, this.volume);
}
