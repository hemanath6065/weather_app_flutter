import 'package:flutter/material.dart';

class HourlyForecast extends StatefulWidget {
  final String time;
  final IconData icon;
  final String temperature;
  final String  status;
  const HourlyForecast({
    super.key,
    required this.time,
    required this.temperature,
    required this.icon,
    required this.status,
  });


  @override
  State<HourlyForecast> createState() => _HourlyForecastState();
}

class _HourlyForecastState extends State<HourlyForecast> {



  @override
  Widget build(BuildContext context) {
    return  Card(
      child: Container(
        width: 120,
        height: 190,
        padding: EdgeInsets.all(8),
        child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(widget.time,
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 8,),
            Icon(widget.icon,size: 35,),
            const SizedBox(height: 8,),
            Text(widget.temperature,
              style: TextStyle(
                  fontSize: 14
              ),
            ),
            const SizedBox(height: 8,),
            Text(widget.status,style: TextStyle(
                  fontSize: 14
                ),
            )
          ],
        ),
      ),
    );
  }
}
