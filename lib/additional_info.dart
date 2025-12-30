import 'package:flutter/material.dart';


class AdditionalinfoItem extends StatelessWidget {
  final IconData icon;
  final String lable;
  final String value;

  const AdditionalinfoItem({
    super.key,
    required this.icon,
    required this.lable,
    required this.value
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 110,
      child: Column(
        children: [
          Icon(icon,size: 50,),
          const SizedBox(height: 14,),
          Text(lable,
            style: TextStyle(
                fontSize: 14
            ),
          ),
          const SizedBox(height: 14,),
          Text(value,
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16
            ),
          )
        ],
      ),
    );
  }
}

