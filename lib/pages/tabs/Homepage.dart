import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';
import 'package:weather/pages/tabs/searchpage.dart';
import 'package:weather/services/currentlocation.dart';

import '../../services/apisservice.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  final getdata=Get.put(ApiService());
  var imageUri=''.obs;
  var logoUri=''.obs;
  var airNums=0.obs;
  var airq=''.obs;
  var colors=Colors.green.obs;
  var quailty=''.obs;

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor:Colors.black26,
      body: Obx((){
        final data=getdata.weatherdata.value;
        final weatherData=getdata.weatherDataList;
        final weather5dayData=getdata.weather5dayDataList;
        final airPollution = getdata.airPollutionList;
        final nums = airPollution['list']?.isNotEmpty == true
            ? airPollution['list'][0]['main']['aqi']
            : 0;



        if(data == null ||
            weatherData.isEmpty ||
            weather5dayData['list'] == null ||
            airPollution['list'] == null){
          return const Center(
            child:CircularProgressIndicator(),
          );
        }
          if (data!.id <= 232 && data.id >= 200) {
            imageUri.value = 'assets/thunder.webp';
            logoUri.value = 'assets/icons/thubder.json';
          }
         else if (data.id >= 300 && data.id <= 321) {
            imageUri.value = 'assets/drop.gif';
            logoUri.value = 'assets/icons/rainLo.json';
          }
         else if (data.id >= 500 && data.id <= 531) {
            imageUri.value = 'assets/rain.gif';
            logoUri.value = 'assets/icons/rainLo.json';
          }
         else if (data.id >= 600 && data.id <= 622) {
            imageUri.value = 'assets/snow.gif';
            logoUri.value = 'assets/icons/snow.json';
          }
         else if (data.id >= 701 && data.id <= 781) {
            imageUri.value = 'assets/cloud.gif';
            logoUri.value = 'assets/icons/smoke.json';
          }
         else if (data.id == 800) {
            imageUri.value = 'assets/clear.gif';
            logoUri.value = 'assets/icons/cloud.json';
          }
         else if (data.id >= 801 && data.id <= 804) {
            imageUri.value = 'assets/cloud.gif';
            logoUri.value = 'assets/icons/cloud.json';
          }

          if (nums == 1) {
            airNums.value = nums;
            airq.value = 'Good';
            colors.value = Colors.green;
            quailty.value =
            'The air quality is excellent today, making it perfect for outdoor activities.';
          }
          else if (nums == 2) {
            airNums.value = nums;
            airq.value = 'Fair';
            colors.value = Colors.green;
            quailty.value =
            "The air quality is fair today, suitable for most activities but with some caution for sensitive groups.";
          }
          else if (nums == 3) {
            airNums.value = nums;
            airq.value = 'Moderate';
            colors.value = Colors.orange;
            quailty.value =
            "The air quality is moderate, which means it’s acceptable for most people but might pose a slight risk to sensitive groups.";
          }
          else if (nums == 4) {
            airNums.value = nums;
            airq.value = 'Poor';
            colors.value = Colors.red;
            quailty.value =
            "The air quality is poor today, so it’s best to limit outdoor activities, especially for sensitive groups.";
          }
          else if (nums == 5) {
            airNums.value = nums;
            airq.value = 'Very Poor';
            colors.value = Colors.red;
            quailty.value =
            "The air quality is very poor today, posing significant health risks, especially for vulnerable groups.";
          }

          return CustomScrollView(
            slivers: [
              SliverAppBar(
                backgroundColor: Colors.blue,
                foregroundColor: Colors.white,

                pinned: true,
                expandedHeight: 400,
                title: const Text("Weather"),
                centerTitle: true,
                leading: const Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: CircleAvatar(
                    radius: 25,
                  ),
                ),
                actions: [
                  GestureDetector(
                    onTap:(){
                      Get.to(()=>const SearchPage());
                    },
                    child: Container(
                      width: 50,
                      height: 50,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white30,

                      ),
                      child: const Icon(Icons.search),
                    ),
                  ),
                  const SizedBox(width: 10,),
                ],
                flexibleSpace: FlexibleSpaceBar(

                  background: Container(
                    decoration: BoxDecoration(
                        color: Colors.pinkAccent,
                        image: DecorationImage(
                            image: AssetImage(imageUri.value ?? ''),
                            fit: BoxFit.fill
                        )
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                children: [
                                  Text(weatherData['name'] ?? 'weather',
                                    style: GoogleFonts.rubik(fontSize: 20),),
                                  Text("${data.mainweather.temp.toInt()
                                      .toString()}°C",
                                    style: GoogleFonts.rubik(fontSize: 50),),
                                  Text(data.description.toString(),
                                    style: GoogleFonts.rubik(fontSize: 20),),
                                ],
                              ),

                              Lottie.asset(
                                  logoUri.value,
                                  width: 150,
                                  height: 150)
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),


              // body

              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.all(30.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 30,),
                      Text('Current Details',
                        style: GoogleFonts.rubik(fontSize: 18),),
                      SizedBox(height: 30,),
                      Container(
                        width: MediaQuery
                            .of(context)
                            .size
                            .width,
                        decoration: const BoxDecoration(
                            color: Colors.white10
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment
                                    .spaceBetween,
                                children: [
                                  Text('temp : ',
                                    style: GoogleFonts.rubik(fontSize: 13),),
                                  Text(data.mainweather.temp.toInt().toString(),
                                    style: GoogleFonts.rubik(fontSize: 13),),
                                ],
                              ),
                              const Divider(color: Colors.white12,),
                              const SizedBox(height: 20,),


                              Row(
                                mainAxisAlignment: MainAxisAlignment
                                    .spaceBetween,
                                children: [
                                  Text('feel like : ',
                                    style: GoogleFonts.rubik(fontSize: 13),),
                                  Text(data.mainweather.feel.toInt().toString(),
                                    style: GoogleFonts.rubik(fontSize: 13),),
                                ],
                              ),
                              const Divider(color: Colors.white12,),
                              const SizedBox(height: 20,),


                              Row(
                                mainAxisAlignment: MainAxisAlignment
                                    .spaceBetween,
                                children: [
                                  Text('pressure : ',
                                    style: GoogleFonts.rubik(fontSize: 13),),
                                  Text(data.mainweather.pressure.toInt()
                                      .toString(),
                                    style: GoogleFonts.rubik(fontSize: 13),),
                                ],
                              ),
                              const Divider(color: Colors.white12,),
                              const SizedBox(height: 20,),


                              Row(
                                mainAxisAlignment: MainAxisAlignment
                                    .spaceBetween,
                                children: [
                                  Text('humidity : ',
                                    style: GoogleFonts.rubik(fontSize: 13),),
                                  Text(data.mainweather.humidity.toInt()
                                      .toString(),
                                    style: GoogleFonts.rubik(fontSize: 13),),
                                ],
                              ),
                              const Divider(color: Colors.white12,),
                              const SizedBox(height: 20,),


                              Row(
                                mainAxisAlignment: MainAxisAlignment
                                    .spaceBetween,
                                children: [
                                  Text('visibility : ',
                                    style: GoogleFonts.rubik(fontSize: 13),),
                                  Text("${(weatherData['visibility'] / 1000)
                                      .toInt()
                                      .toString()} Km",
                                    style: GoogleFonts.rubik(fontSize: 13),),
                                ],
                              ),
                              const Divider(color: Colors.white12,),
                              const SizedBox(height: 20,),


                              Row(
                                mainAxisAlignment: MainAxisAlignment
                                    .spaceBetween,
                                children: [
                                  Text('wind speed : ',
                                    style: GoogleFonts.rubik(fontSize: 13),),
                                  Text("${(weatherData['wind']['speed'])
                                      .toString()}",
                                    style: GoogleFonts.rubik(fontSize: 13),),
                                ],
                              ),
                              const SizedBox(height: 30,),

                            ],
                          ),
                        ),
                      ),

                      SizedBox(height: 30,),
                      Text('daily Details',
                        style: GoogleFonts.rubik(fontSize: 18),),
                      SizedBox(height: 30,),

                      Container(
                        width: MediaQuery
                            .of(context)
                            .size
                            .width,
                        decoration: const BoxDecoration(
                            color: Colors.white10
                        ),
                        child: Column(
                          children: [
                            SizedBox(
                              child: ListView.builder(
                                  physics: const NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  itemBuilder: (context, index) {
                                    final dataWeather = weather5dayData['list'][index];
                                    var timeSpam = dataWeather['dt'];
                                    DateTime time = DateTime
                                        .fromMillisecondsSinceEpoch(
                                        timeSpam * 1000);
                                    String formatdate = DateFormat('MMM dd,yy')
                                        .format(time);
                                    return Container(
                                      child: Padding(
                                        padding: const EdgeInsets.all(10.0),
                                        child: Column(
                                          children: [
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment
                                                  .spaceBetween,
                                              children: [
                                                Text((formatdate).toString()),
                                                Row(
                                                  children: [
                                                    Icon(Icons.thermostat),
                                                    Text(
                                                        (dataWeather['main']['temp'] -
                                                            273.15)
                                                            .toInt()
                                                            .toString()),
                                                  ],
                                                ),

                                                Text(
                                                    (dataWeather['main']['feels_like'] -
                                                        273.15)
                                                        .toInt()
                                                        .toString()),

                                              ],
                                            ),
                                            Divider()
                                          ],
                                        ),
                                      ),
                                    );
                                  },
                                  itemCount: weather5dayData.values.length
                              ),

                            ),

                            const SizedBox(height: 30,)
                          ],
                        ),
                      ),

                      SizedBox(height: 30,),
                      Text(
                        'Air Quality', style: GoogleFonts.rubik(fontSize: 18),),
                      SizedBox(height: 30,),

                      Container(
                          decoration: BoxDecoration(
                              color: Colors.white12,
                              borderRadius: BorderRadius.circular(10)
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: Column(
                              children: [
                                Text(quailty.value, style: TextStyle(
                                    fontSize: 15,
                                    color: colors.value
                                ),),
                                const SizedBox(height: 30,),
                                SfRadialGauge(
                                  enableLoadingAnimation: true,
                                  axes: [
                                    RadialAxis(
                                      minimum: 0,
                                      maximum: 6,
                                      interval: 1,
                                      majorTickStyle: MajorTickStyle(
                                        length: 1,
                                      ),
                                      ranges: [
                                        GaugeRange(

                                          startValue: 0,
                                          endValue: 2,
                                          color: Colors.green,
                                          label: 'Good',
                                          labelStyle: GaugeTextStyle(
                                              fontSize: 12,
                                              color: Colors.white),
                                        ),

                                        GaugeRange(
                                          startValue: 2,
                                          endValue: 3,
                                          color: Colors.orangeAccent,
                                          label: 'Fair',
                                          labelStyle: GaugeTextStyle(
                                              fontSize: 12,
                                              color: Colors.white),
                                        ),
                                        GaugeRange(
                                          startValue: 3,
                                          endValue: 4,
                                          color: Colors.orange,
                                          label: 'Moderate',
                                          labelStyle: GaugeTextStyle(
                                              fontSize: 12,
                                              color: Colors.white),
                                        ),

                                        GaugeRange(
                                          startValue: 4,
                                          endValue: 5,
                                          color: Colors.redAccent,
                                          label: 'poor',
                                          labelStyle: GaugeTextStyle(
                                              fontSize: 12,
                                              color: Colors.white),
                                        ),

                                        GaugeRange(
                                          startValue: 5,
                                          endValue: 6,
                                          color: Colors.red,
                                          label: 'very poor',
                                          labelStyle: GaugeTextStyle(
                                              fontSize: 12,
                                              color: Colors.white),
                                        ),
                                      ],
                                      pointers: [
                                        NeedlePointer(
                                          value: airNums.value.toDouble(),
                                          needleColor: colors.value,
                                          knobStyle: KnobStyle(
                                              color: Colors.black),
                                        ),
                                      ],

                                      annotations: [
                                        GaugeAnnotation(
                                          widget: Text(
                                            airq.value,
                                            style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                              color: colors.value,
                                            ),
                                          ),
                                          angle: 90,
                                          positionFactor: 0.8,
                                        ),
                                      ],
                                    ),

                                  ],
                                ),
                              ],
                            ),
                          )
                      )
                    ],

                  ),
                ),
              )
            ],
          );
        }

        )
    );
  }
}



