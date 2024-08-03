import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
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
      GlobalWidget().showpopup(context, msg: "No Internet Connection. Please check your internet connection and try again later.", args: "2", ontap: (){
        Navigator.pop(context);
      });
    } on TimeoutException {
      GlobalWidget().showpopup(context, msg: "No Internet Connection. Please check your internet connection and try again later.", args: "2", ontap: (){
        Navigator.pop(context);
      });
    } on HttpException {
      GlobalWidget().showpopup(context, msg: "Sorry, unable to connect to the server. Please try again later", args: "2", ontap: (){
        Navigator.pop(context);
      });
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
      GlobalWidget().showpopup(context, msg: "No Internet Connection. Please check your internet connection and try again later.", args: "2", ontap: (){
        Navigator.pop(context);
      });
    } on TimeoutException {
      GlobalWidget().showpopup(context, msg: "No Internet Connection. Please check your internet connection and try again later.", args: "2", ontap: (){
        Navigator.pop(context);
      });
    } on HttpException {
      GlobalWidget().showpopup(context, msg: "Sorry, unable to connect to the server. Please try again later", args: "2", ontap: (){
        Navigator.pop(context);
      });
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
      GlobalWidget().showpopup(context, msg: "No Internet Connection. Please check your internet connection and try again later.", args: "2", ontap: (){
        Navigator.pop(context);
      });
    } on TimeoutException {
      GlobalWidget().showpopup(context, msg: "No Internet Connection. Please check your internet connection and try again later.", args: "2", ontap: (){
        Navigator.pop(context);
      });
    } on HttpException {
      GlobalWidget().showpopup(context, msg: "Sorry, unable to connect to the server. Please try again later", args: "2", ontap: (){
        Navigator.pop(context);
      });
    }
    return totalListChoc;
  }
}