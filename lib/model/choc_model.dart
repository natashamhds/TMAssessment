class TotalListChoc{
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

class ChocVolume {
  ChocVolume(this.month, this.volume);
  final String? month;
  final double? volume;

  factory ChocVolume.fromJson(Map<String, dynamic> json){
    return ChocVolume(
        json['month'].toString(),
        json['volume'] as double?
    );
  }
}
