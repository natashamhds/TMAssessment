/// parse the JSON response into dart O
class ChocModel {
  String? chocolateType;
  String? productionDate;
  String? volume;

  ChocModel({this.chocolateType, this.productionDate, this.volume});

  ChocModel.fromJson(Map<String, dynamic> json) {
    chocolateType = json['chocolate_type'];
    productionDate = json['production_date'];
    volume = json['volume'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['chocolate_type'] = this.chocolateType;
    data['production_date'] = this.productionDate;
    data['volume'] = this.volume;
    return data;
  }
}

class ChartData {
  final String chocolateType;
  final int volume;

  ChartData(this.chocolateType, this.volume);
}