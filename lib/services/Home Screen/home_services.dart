import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:tm_assessment/constant/config.dart';
import 'package:tm_assessment/constant/widgets.dart';
import 'package:tm_assessment/model/choc_model.dart';
import 'package:http/http.dart' as http;

class APIServices_Home {

  TotalListChoc? totalListChoc;

  Future<TotalListChoc?> allChocData(context) async {

   try{
      final res = await http.get(Uri.parse(get_choc_data)); 

      totalListChoc = TotalListChoc.fromJson(jsonDecode(res.body));
      return totalListChoc;
    } on SocketException {
      GlobalWidget().popup(context, title: "Oh snap!", msg: "No Internet Connection.\nPlease check your internet connection and try again later.", contentType: ContentType.failure);
    } on TimeoutException {
      GlobalWidget().popup(context, title: "Oh snap!", msg: "No Internet Connection.\nPlease check your internet connection and try again later.", contentType: ContentType.failure);
    } on HttpException {
      GlobalWidget().popup(context, title: "Oh snap!", msg: "Sorry, unable to connect to the server.\nPlease try again later.", contentType: ContentType.warning);
    }
    return totalListChoc;
  }

  /// based on Month
   Future<TotalListChoc?> chocDate(context, {
    required String month
   }) async {

   try{
      final res = await http.get(Uri.parse("$get_choc_data?production_date=$month")); 

      totalListChoc = TotalListChoc.fromJson(jsonDecode(res.body));
      return totalListChoc;
    } on SocketException {
      GlobalWidget().popup(context, title: "Oh snap!", msg: "No Internet Connection.\nPlease check your internet connection and try again later.", contentType: ContentType.failure);
    } on TimeoutException {
      GlobalWidget().popup(context, title: "Oh snap!", msg: "No Internet Connection.\nPlease check your internet connection and try again later.", contentType: ContentType.failure);
    } on HttpException {
      GlobalWidget().popup(context, title: "Oh snap!", msg: "Sorry, unable to connect to the server.\nPlease try again later.", contentType: ContentType.warning);
    }
    return totalListChoc;
  }

  /// based on Type
   Future<TotalListChoc?> chocType(context, {
    required String choc
   }) async {

   try{
      final res = await http.get(Uri.parse("$get_choc_data?production_date=$choc")); 

      totalListChoc = TotalListChoc.fromJson(jsonDecode(res.body));
      return totalListChoc;
    } on SocketException {
      GlobalWidget().popup(context, title: "Oh snap!", msg: "No Internet Connection.\nPlease check your internet connection and try again later.", contentType: ContentType.failure);
    } on TimeoutException {
      GlobalWidget().popup(context, title: "Oh snap!", msg: "No Internet Connection.\nPlease check your internet connection and try again later.", contentType: ContentType.failure);
    } on HttpException {
      GlobalWidget().popup(context, title: "Oh snap!", msg: "Sorry, unable to connect to the server.\nPlease try again later.", contentType: ContentType.warning);
    }
    return totalListChoc;
  }
}