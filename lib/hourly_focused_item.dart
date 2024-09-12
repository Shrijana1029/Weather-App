import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HourlyFocusedItems extends StatelessWidget {
  const HourlyFocusedItems({super.key});

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      width: 100,
      child: Card(
        elevation: 10,
        child: Column(
          children: [
            SizedBox(height: 8.0,),
            Text("09:00", style: TextStyle(fontSize:17, fontWeight: FontWeight.bold ),),
            SizedBox(height: 8.0,),
            Icon(Icons.cloudy_snowing, size: 32,),

            SizedBox(height: 8.0,),
            Text("201.3",  style: TextStyle(fontSize:16,),),
            SizedBox(height: 8.0,),
          ],
        ),
      ),
    );
  }
}