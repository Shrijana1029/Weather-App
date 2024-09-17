// import 'package:flutter/cupertino.dart';
import 'dart:convert';
import 'dart:ui';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:weather_app/secrets.dart';
import 'additional_info_item.dart';
import 'hourly_focused_item.dart';

class WeatherScreen extends StatefulWidget {
  const WeatherScreen({super.key,});

  @override
  State<WeatherScreen> createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  double temp=0.0;
   @override
  void initState() {
     super.initState();
    getCurrentWeather();
  }

  Future <void> getCurrentWeather() async {

    try{
      String cityName = "London";
      //res contains all data that has been requested
      final res = await http.get(
        Uri.parse("https://api.openweathermap.org/data/2.5 /forecast?q=$cityName&APPID=$openWeatherApiKey"
        ),
      );
      // to check if PI key is working or not
      print(res.statusCode);
      // print(res.body);


      //jsonDecode decodes the json format data into dart map or list
      final data = jsonDecode(res.body);
      if(data['cod'] != '200'){
        throw 'An unexpected error occurred';
      }
      setState(() {
        temp = data['list'][0]['main']['temp'];
      });

    }
    catch(e){
      throw e.toString();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold (
      appBar: AppBar(
       actions: [
         IconButton(onPressed: (){ print("Refreshed");},
             icon: Icon(Icons.refresh),
         )
       ],
        title:  const Text("Weather App",
         style: TextStyle(
             fontWeight: FontWeight.bold,
         )

          ,),
        centerTitle: true,
      ),
          body: temp ==0 ? const CircularProgressIndicator(): Padding(
            padding: const EdgeInsets.all(12.0),
            child:   SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //THIS IS 1ST CONTAINER
                   SizedBox(
                     //to take max amount of widths
                    width: double.infinity,
                    child:  Card(
                      elevation: 10,
                      shape: RoundedRectangleBorder(
                        borderRadius:  BorderRadius.circular(20),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(2),
                        child: BackdropFilter(
                          filter: ImageFilter.blur(sigmaX: 2.0, sigmaY: 3.0),
                          child: Column(
                            children: [
                            const SizedBox(height: 16,),
                              Text("$temp K", style: const TextStyle(fontSize: 32, fontWeight: FontWeight.bold
                              ),
                              ),
                             const SizedBox(height: 16,),
                             const Icon(Icons.cloudy_snowing, size:65),
                              SizedBox(height: 16,),
                              Text("Rain", style: TextStyle(fontSize: 26 ),),
                              SizedBox(height: 16,),
                            ],
                          ),
                        ),
                      ) ,
                    ),
                  ),
                  // tHIS SECOND CONTAINEr
                const SizedBox(height: 40,),
                  const Text("Weather Forecast",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),),
                 const SizedBox(height: 20),
                  //SMALL BOXES HARU XAH AI
                  //row bhitra card xa card bhitra column card is wrapped with sized box
                 const SingleChildScrollView(
                   scrollDirection: Axis.horizontal,
                   child: Row(
                      children: [
                        HourlyFocusedItems(
                          icon: Icons.cloudy_snowing,
                          time: '9.0',
                          data: '300.12',
                        ),HourlyFocusedItems(
                          icon: Icons.cloudy_snowing,
                          time: '10.0',
                          data: '300.44',
                        ),HourlyFocusedItems(
                          icon: Icons.cloud,
                          time: '11.0',
                          data: '300.76',
                        ),HourlyFocusedItems(
                          icon: Icons.cloud,
                          time: '12.0',
                          data: '300.11',
                        ),HourlyFocusedItems(
                          icon: Icons.cloudy_snowing,
                          time: '13.0',
                          data: '201',
                        ),HourlyFocusedItems(
                          icon: Icons.cloudy_snowing,
                          time: '14.0',
                          data: '201',
                        ),

                      ],
                    ),
                 ),
                 const SizedBox(height: 40),

                 const  Text("Additional Information" , style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),),
                 const  Padding(
                    padding:  EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        AdditionalInfoItem(
                          icon: Icons.water_drop_rounded,
                          data: 'Humidity',
                          value: '91',
                        ),
                        AdditionalInfoItem(
                          icon: Icons.air,
                          data: 'Wind',
                          value: '12',

                        ),
                        AdditionalInfoItem(
                          data: 'Pressure',
                          icon: Icons.beach_access_outlined,
                          value: '22',

                        ),
                      ]
                    ),
                  )

                ],//children

                  ),
            ),
          ),


    );
  }
}


