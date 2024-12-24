import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';

class SearchWeatherPage extends StatelessWidget {
   SearchWeatherPage({super.key,required this.cityData});
  final Map cityData;
  var logoUri=''.obs;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:SafeArea(
        child: Obx(
            (){
              if (cityData['weather'][0]['id'] <= 232 && cityData['weather'][0]['id'] >= 200) {

                logoUri.value = 'assets/icons/thubder.json';
              }
              else if (cityData['weather'][0]['id'] >= 300 && cityData['weather'][0]['id'] <= 321) {
                logoUri.value = 'assets/icons/rainLo.json';
              }
              else if (cityData['weather'][0]['id'] >= 500 && cityData['weather'][0]['id'] <= 531) {

                logoUri.value = 'assets/icons/rainLo.json';
              }
              else if (cityData['weather'][0]['id'] >= 600 && cityData['weather'][0]['id']<= 622) {

                logoUri.value = 'assets/icons/snow.json';
              }
              else if (cityData['weather'][0]['id'] >= 701 && cityData['weather'][0]['id']<= 781) {

                logoUri.value = 'assets/icons/smoke.json';
              }
              else if (cityData['weather'][0]['id'] == 800) {
                logoUri.value = 'assets/icons/cloud.json';
              }
              else if (cityData['weather'][0]['id'] >= 801 && cityData['weather'][0]['id'] <= 804) {

                logoUri.value = 'assets/icons/cloud.json';
              }
             return Padding(
            padding: const EdgeInsets.all(20.0),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    width:MediaQuery.of(context).size.width,
                    decoration:BoxDecoration(
                      color:Colors.white12,
                      borderRadius:BorderRadius.circular(10),
                    ),
                    child:Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment:MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                children: [
                                  Text(cityData['name']),
                                 const SizedBox(height:10,),
                                  Text((cityData['main']['temp']-273.15).toInt().toString(),style: GoogleFonts.rubik(fontSize: 30)),
                                  const SizedBox(height:10,),
                                  Text(cityData['weather'][0]['main']),
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
              
                  const SizedBox(height: 30,),
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
                              Text((cityData['main']['temp']-273.15).toInt().toString(),
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
                              Text((cityData['main']['feels_like']-273.15).toInt().toString(),
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
                              Text((cityData['main']['pressure']-273.15).toInt().toString(),
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
                              Text((cityData['main']['humidity']-273.15).toInt().toString(),
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
                              Text("${( cityData["visibility"]/ 1000)
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
                              Text("${(cityData['wind']['speed'])
                                  .toString()}",
                                style: GoogleFonts.rubik(fontSize: 13),),
                            ],
                          ),
                          const SizedBox(height: 30,),
              
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            );
            },
        ),
      ),
    );
  }
}
