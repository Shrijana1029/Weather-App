// import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AdditionalInfoItem extends StatelessWidget {
  final IconData icon;
  final String data;
  final String value;
  // final lab
  const AdditionalInfoItem({
    super.key,
    required this.icon,
    required this.data,
    required this.value
  });

  @override
  Widget build(BuildContext context) {
    return  SizedBox(
      width: 90,height: 110,
      child: Column(
        children: [
          Icon(icon, size: 40,),
          const SizedBox(height: 8,),
          Text(data , style: const TextStyle(fontSize: 16),),
          const SizedBox(height: 8,),
          Text(value ,style: const TextStyle(fontSize: 19, fontWeight: FontWeight.bold),),
        ],
      ),
    );
  }
}
