import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_project_2/caching/controllers/local_database.dart';
import 'package:flutter_project_2/caching/models/news_modal.dart';
import 'package:http/http.dart' as http;
class FetchApiNews {

static Future getLatestNews(int pageNo)async{
  String url="https://hn.algolia.com/api/v1/search_by_date?tags=story&page=$pageNo";
  var response= await http.get(Uri.parse(url));
 try{
  if(response.statusCode==200 || response.statusCode==201){
    var data=jsonDecode(response.body); // gettig all the api data
    for(var dt in data["hits"]){ // getting only hit news data from api
      var news=NewsModal.fromJson(dt); // getting a single news

      LocalDatabase.insertNews(news); // inserting a single news in sqflite database
    }
      LocalDatabase.insertSaveTime(0);
    return true;
  }
  }catch(e){
    debugPrint("error during calling api is $e");
    return false;
  }
}
}