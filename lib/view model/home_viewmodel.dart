import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tm_assessment/constant/config.dart';
import 'package:tm_assessment/model/choc_model.dart';
import 'package:tm_assessment/services/Home%20Screen/home_services.dart';

class HomeViewModel extends ChangeNotifier {
  TextEditingController _displayMonthController = TextEditingController();
  TextEditingController _valueMonthController = TextEditingController();

  TextEditingController _displayChocController = TextEditingController();
  TextEditingController _valueChocController = TextEditingController();

  TextEditingController get displayMonthController => _displayMonthController;
  TextEditingController get valueMonthController => _valueMonthController;

  TextEditingController get displayChocController => _displayChocController;
  TextEditingController get valueChocController => _valueChocController;

  List<GlobalDualValue> listMonth = [];
  List<GlobalDualValue> listChoc = [];
  List<GlobalDualValue> top5Choc = [];
  List<GlobalDualValue> chocVolume = [];

  List<ChocModel> allData = [];

  String formattedPrevMonth = "";
  String abbreviatedPrevMonth = "";

  bool isLoading = false;

  // to convert valueMonthController to the value in listMonth
  String getValueForMonth(String month) {
  for (var item in listMonth) {
    if (item.title == month) {
      return item.value;
    }
  }
  return "";
}

  Future getListData(context) async {
    listMonth = [
      GlobalDualValue(title: "JANUARY", value: "28-Jan"),
      GlobalDualValue(title: "FEBRUARY", value: "28-Feb"),
      GlobalDualValue(title: "MARCH", value: "28-Mar"),
      GlobalDualValue(title: "APRIL", value: "28-Apr"),
      GlobalDualValue(title: "MAY", value: "28-May"),
      GlobalDualValue(title: "JUNE", value: "28-Jun"),
      GlobalDualValue(title: "JULY", value: "28-Jul"),
    ];

    listChoc = [
      GlobalDualValue(title: "Flake", value: "Flake"),
      GlobalDualValue(title: "Caramel", value: "Caramel"),
      GlobalDualValue(title: "Twirl", value: "Twirl"),
      GlobalDualValue(title: "Wispa", value: "Wispa"),
      GlobalDualValue(title: "Chomp", value: "Chomp"),
      GlobalDualValue(title: "Fudge", value: "Fudge"),
      GlobalDualValue(title: "Crunchie", value: "Crunchie"),
      GlobalDualValue(title: "Double Decker", value: "DoubleDecker"),
      GlobalDualValue(title: "Wispa Gold", value: "WispaGold"),
      GlobalDualValue(title: "Picnic", value: "Picnic"),
    ];

    getAllData(context);

    /// get previous month
    DateTime now = DateTime.now();

    DateTime prevMonth = DateTime(now.year, now.month - 1, now.day);

    formattedPrevMonth = DateFormat('MMMM').format(prevMonth).toUpperCase();
    abbreviatedPrevMonth = DateFormat('MMM').format(prevMonth).toUpperCase();

    notifyListeners();
  }

  /// get all chocolate data
  Future getAllData(context) async {
    var value = await APIServices_Home().allChocData(context);

    (value!.choc).map((e) {
      allData.add(e);
    }).toList();

    notifyListeners();
  }

  Future filterDataMonth(context, String month) async{
    /// clear the existing top5 list
    top5Choc.clear();

    var filteredChocolates = allData.where((e) => e.productionDate!.contains(month)).toList();

    /// sort by volume in descending order
    filteredChocolates.sort((a, b) => b.volume!.compareTo(a.volume!));

    /// take the top 5
    var top5Chocolates = filteredChocolates.take(5).toList();
     /// print the filtered choc to ensure the list are correct based on month
      for (var choc in top5Chocolates) {
        debugPrint('Chocolate Type: ${choc.chocolateType}, Production Date: ${choc.productionDate}, Volume: ${choc.volume}');
        }

      top5Choc.addAll(top5Chocolates.map((e) => GlobalDualValue(title: e.chocolateType.toString(), value: e.volume.toString())).toList());

    notifyListeners();
  }

  Future filterDataChoc(context, String choc) async{
    chocVolume.clear();

    var filteredChocolates = allData.where((e) => e.chocolateType == choc).toList();

    /// print the filtered choc to ensure the list are correct based on choc type
    for (var choc in filteredChocolates) {
        debugPrint('Chocolate Type: ${choc.chocolateType}, Production Date: ${choc.productionDate}, Volume: ${choc.volume}');
        }

    chocVolume.addAll(filteredChocolates.map((e) => GlobalDualValue(title: e.productionDate.toString(), value: e.volume.toString())).toList());
    for (var choc in chocVolume) {
        debugPrint('Production Date: ${choc.title}, Volume: ${choc.value}');
        }
        
    notifyListeners();
  }
}
