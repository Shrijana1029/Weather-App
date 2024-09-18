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
//map string dynamic because value can be retured in "tem:25.3"0
//  like json in format so
  Future <Map<String, dynamic>> getCurrentWeather() async {

    try{
      String cityName = "London";
      //res contains all data that has been requested
      final res = await http.get(
        Uri.parse("https://api.openweathermap.org/data/2.5/forecast?q=$cityName&APPID=$openWeatherApiKey"
        ),
      );
      // to check if PI key is working or not
      // print(res.statusCode);
      // print(res.body);


      //jsonDecode decodes the json format data into dart map or list
      final data = jsonDecode(res.body);

      if(data['cod'] != '200'){
        throw 'An unexpected error occurred';
      }
      //returns data to FutureBuilder
      return data;
      // temp = data['list'][0]['main']['temp'];

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
      body: FutureBuilder(

        future: getCurrentWeather(),
        builder: (context, snapshot) {
            if(snapshot.connectionState == ConnectionState.waiting){
              return const Center(child: CircularProgressIndicator());
            }
            else if(snapshot.hasError)
              {
                return Center(child: Text("Error: ${snapshot.error}"));
              }
            //holds data from async operation
            //! means i am sure snapshot.data is not a null
            //snapshot.data gets data from Future okay..(i.e return)
            final data = snapshot.data!;
            final currentWeatherData = data['list'][0];
            final currentTemp = currentWeatherData['main']['temp'];
            final currentSky =currentWeatherData['weather'][0]['main'];
            final currentPressure = currentWeatherData['main']['pressure'];
            final currentHumidity = currentWeatherData['main']['humidity'];
            final currentWind = currentWeatherData['wind']['speed'];


          return Padding(
            padding: const EdgeInsets.all(12.0),
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // THIS IS 1ST CONTAINER
                  SizedBox(
                    width: double.infinity,  // To take max amount of widths
                    child: Card(
                      elevation: 10,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(2),
                        child: BackdropFilter(
                          filter: ImageFilter.blur(sigmaX: 2.0, sigmaY: 3.0),
                          child: Column(
                            children: [
                              SizedBox(height: 16),
                              Text(
                                "$currentTemp K",
                                style: const TextStyle(
                                  fontSize: 32,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(height: 16),
                              Icon(
                                currentSky == 'Clouds' || currentSky == 'Rain' ?
                                Icons.cloud : Icons.sunny, size: 65),
                              SizedBox(height: 16),
                              Text("$currentSky", style: TextStyle(fontSize: 26)),
                              SizedBox(height: 16),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  // THIS IS THE SECOND CONTAINER
                  const SizedBox(height: 40),
                  const Text(
                    "Weather Forecast",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
                  ),
                  const SizedBox(height: 20),
                  // SMALL BOXES HARU XAH AI
                  // SingleChildScrollView(
                  //   scrollDirection: Axis.horizontal,
                  //   child: Row(
                  //     children: [
                  //       for(int i=1 ; i<38 ; i++)
                  //           HourlyFocusedItems(
                  //             icon: data['list'][i]['weather'][0]['main'] == 'Clouds' || data['list'][i]['weather'][0]['main'] == "Rain" ? Icons.cloud : Icons.sunny,
                  //             time:data['list'][i]["dt"].toString(),
                  //             temperature: data['list'][i]["main"]['temp'].toString(),
                  //           ),
                  //     ],
                  //   ),
                  // ),
                  //build a no of list but lately acc to its requirement
                  SizedBox(
                    height: 120,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: 20,
                        itemBuilder: (context, index){
                        final hourlySky = data['list'][index+1]['weather'][0]['main'];
                        final hourlyForecast =  data['list'][index+1];
                        final hourlyTemp = hourlyForecast["main"]['temp'].toString();

                        return HourlyFocusedItems(
                            icon: hourlySky == "Clouds" || hourlySky == 'Rain' ? Icons.cloud: Icons.sunny,
                            time: hourlyForecast["dt_txt"].toString(),
                            temperature :hourlyTemp,
                        );
                        }
                    ),
                  ),

                  const SizedBox(height: 40),
                  const Text(
                    "Additional Information",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
                  ),
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        AdditionalInfoItem(
                          icon: Icons.water_drop_rounded,
                          data: 'Humidit y',
                          value:'$currentHumidity',
                        ),
                        AdditionalInfoItem(
                          icon: Icons.air,
                          data: 'Wind',
                          value: '$currentWind',
                        ),
                        AdditionalInfoItem(
                          data: 'Pressure',
                          icon: Icons.beach_access_outlined,
                          value: '$currentPressure',
                        ),
                      ],
                    ),
                  ),
                ], // children
              ),
            ),
          );
        },
      ),



    );
  }
}


