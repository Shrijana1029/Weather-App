// import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AdditionalInfoItem extends StatelessWidget {
  const AdditionalInfoItem({super.key});

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      width: 90,height: 110,
      child: Column(
        children: [
          Icon(Icons.water_drop_rounded,size: 40,),
          SizedBox(height: 8,),
          Text("Humidity", style: TextStyle(fontSize: 16),),
          SizedBox(height: 8,),
          Text("91",style: TextStyle(fontSize: 19, fontWeight: FontWeight.bold),),
        ],
      ),
    );
  }
}
