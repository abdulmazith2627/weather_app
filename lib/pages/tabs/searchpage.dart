import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:weather/pages/tabs/searchweatherpage.dart';

import '../../services/apisservice.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final searchdata=Get.put(ApiService());
  final TextEditingController _search=TextEditingController();

  @override
  void dispose() {
    super.dispose();
    _search.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                TextFormField(
                  controller:_search,
                  onChanged:(value){
                    setState(() {
                     if(value.isNotEmpty){
                       searchdata.search(value);
                     }else{
                       searchdata.searchWeather.value=[];
                     }

                    });

                  },
                  decoration:InputDecoration(
                    border:const OutlineInputBorder(),
                    hintText:'Searching.....',
                    suffixIcon:IconButton(
                        onPressed:(){}, 
                        icon:const Icon(Icons.search)
                    )
                  ),
                ),
                
                Container(
                  width:MediaQuery.of(context).size.width,
                  child:ListView.builder(
                     physics:NeverScrollableScrollPhysics(),
                      shrinkWrap:true,
                      itemCount:searchdata.searchWeather.length,
                      itemBuilder:(context,index){
                       var cityData=searchdata.searchWeather[index];
                       return Padding(
                           padding:const EdgeInsets.all(20),
                           child:GestureDetector(
                             onTap:(){
                               Get.to(()=>SearchWeatherPage(cityData:cityData));
                             },
                             child: Container(
                               width:MediaQuery.of(context).size.width,
                               decoration:BoxDecoration(
                                 color:Colors.white12,
                                 borderRadius:BorderRadius.circular(10)
                               ),
                               child:Padding(
                                 padding: const EdgeInsets.all(8.0),
                                 child: Align(
                                   alignment:Alignment.topLeft,
                                   child: Padding(
                                     padding: const EdgeInsets.all(15.0),
                                     child: Column(
                                       crossAxisAlignment:CrossAxisAlignment.center,
                                       children: [
                                        Row(
                                          mainAxisAlignment:MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text('City Name : '),
                                            Text(searchdata.searchWeather[index]['name']),
                                          ],
                                        ),
                                         SizedBox(height:20,),
                                         Row(
                                           mainAxisAlignment:MainAxisAlignment.spaceBetween,
                                           children: [
                                             Text('City Temp : '),
                                             Text((searchdata.searchWeather[index]['main']['temp']-273.15).toInt().toString()),

                                           ],
                                         ),

                                         SizedBox(height:20,),
                                         Row(
                                           mainAxisAlignment:MainAxisAlignment.spaceBetween,
                                           children: [
                                             Text('feel Like : '),
                                             Text((searchdata.searchWeather[index]['main']['feels_like']-273.15).toInt().toString()),

                                           ],
                                         ),

                                       ],
                                     ),
                                   ),
                                 ),
                               ),
                             ),
                           ),
                       );
                      }
                  )
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
