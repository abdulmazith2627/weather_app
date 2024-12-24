import 'dart:async';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:http/http.dart'as http;
import 'package:weather/services/currentlocation.dart';
import 'package:weather/weatherdatas/weather.dart';

class ApiService extends GetxController{
  final currentLoction=Get.put(LocationController());
  var weatherdata=Rx<Weather?>(null);
  var weatherDataList={}.obs;
  var weather5dayDataList={}.obs;
  var airPollutionList={}.obs;
  var searchWeather=[].obs;





  Future getWeatherData()async{

    var log=currentLoction.longitude.value;
    var lat=currentLoction.latitude.value;
    print(log);


     var key='fce8961e767b3780f5dcbe4102db8fe4';
      final res=await http.get(
          Uri.parse(
              'https://api.openweathermap.org/data/2.5/weather?lat=$lat&lon=$log&appid=$key'
          ));

      if(res.statusCode==200){
        final getdata =jsonDecode(res.body);
        weatherDataList.value=getdata;
         weatherdata.value=Weather.fromJson(getdata);
        airPollution();

      }
  }


  Future get5dayWeatherData()async{
    var log=currentLoction.longitude.value;
    var lat=currentLoction.latitude.value;

    var key='fce8961e767b3780f5dcbe4102db8fe4';
    final res=await http.get(
        Uri.parse(
            'http://api.openweathermap.org/data/2.5/forecast?lat=$lat&lon=$log&appid=$key'
        ));
    if(res.statusCode==200){
      final getdata =jsonDecode(res.body);
      weather5dayDataList.value=getdata;
      print(weather5dayDataList["list"][0]);
    }else{
      print('invalid data');
    }
  }



  Future airPollution()async{

    var key='fce8961e767b3780f5dcbe4102db8fe4';
    var log=currentLoction.longitude.value;
    var lat=currentLoction.latitude.value;
    final res=await http.get(
        Uri.parse(
            'http://api.openweathermap.org/data/2.5/air_pollution?lat=$lat&lon=$log&appid=$key'
        ));
    if(res.statusCode==200){
      final getdata =jsonDecode(res.body);
      airPollutionList.value=getdata;

      print(log);
      print(lat);
    }else{
      print('invalid data');
    }
  }

  search(searchCity) async {
    final res = await http.get(
      Uri.parse(
          'https://api.openweathermap.org/data/2.5/weather?q=$searchCity&appid=fce8961e767b3780f5dcbe4102db8fe4'
      ),
    );

    if (res.statusCode == 200) {
      final getdata = jsonDecode(res.body);

      if (getdata != null) {
          searchWeather.value = [getdata];
      }
      print(searchWeather[0]['name']);

    }
  }



  @override
  void onInit() {
    super.onInit();
    currentLoction.getLocation();
    getWeatherData();
    get5dayWeatherData();
    airPollution();
    Timer.periodic(Duration(seconds:2),(_)=>getWeatherData());
    Timer.periodic(Duration(minutes:2),(_)=>get5dayWeatherData());
    Timer.periodic(Duration(minutes:1),(_)=>airPollution());
  }

}