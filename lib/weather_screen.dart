// import 'package:flutter/cupertino.dart';
import 'dart:ui';

import 'package:flutter/material.dart';

import 'additional_info_item.dart';
import 'hourly_focused_item.dart';

class WeatherScreen extends StatelessWidget {
  const WeatherScreen({super.key});

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
          body: Padding(
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
                          child: const Column(
                            children: [
                              SizedBox(height: 16,),
                              Text("300°F", style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold
                              ),
                              ),
                             SizedBox(height: 16,),
                             Icon(Icons.cloudy_snowing, size:65),
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
                        HourlyFocusedItems(),
                        HourlyFocusedItems(),
                        HourlyFocusedItems(),
                        HourlyFocusedItems(),
                        HourlyFocusedItems(),
                        HourlyFocusedItems(),
                        HourlyFocusedItems(),
                        HourlyFocusedItems(),
                      ],
                    ),
                 ),
                  SizedBox(height: 40),

                  Text("Additional Information" , style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),),
                 const  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        AdditionalInfoItem(),
                        AdditionalInfoItem(),
                        AdditionalInfoItem(),
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


