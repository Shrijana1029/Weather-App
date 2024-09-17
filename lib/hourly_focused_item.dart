// import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HourlyFocusedItems extends StatelessWidget {
  final IconData icon;
  final String data;
  final String time;
  const HourlyFocusedItems({super.key,
    required this.icon,
    required this.time,
    required this.data,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 100,
      child:Card(
        elevation: 10,
        child:  Column(
          children: [
           const SizedBox(height: 8.0,),
            Text(time, style: const TextStyle(fontSize:17, fontWeight: FontWeight.bold ),),
            const SizedBox(height: 8.0,),
            Icon(icon , size: 32,),

          const SizedBox(height: 8.0,),
            Text(data ,  style: const TextStyle(fontSize:16,),),
            const SizedBox(height: 8.0,),
          ],
        ),
      ),
    );
  }
}

