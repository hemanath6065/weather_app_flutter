import 'dart:convert';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:weather_app/secret.dart';
import 'additional_info.dart' show AdditionalinfoItem;
import 'hourly_forcast.dart' show HourlyForecast;


class WeatherHomeScreen extends StatefulWidget {
  const WeatherHomeScreen({super.key});

  @override
  State<WeatherHomeScreen> createState() => _WeatherHomeScreenState();
}

class _WeatherHomeScreenState extends State<WeatherHomeScreen> {




  Future<Map<String,dynamic>> getCurrentWeather() async{
    try{

      String cityName='Erode';
      final res=await http.get(
          Uri.parse(
              'https://api.openweathermap.org/data/2.5/forecast?q=$cityName&APPID=$openweatherAPIKey'
          )
      );
      final data=jsonDecode(res.body);
      if(data['cod']!='200'){
        throw 'An unexpected error occured in 200';
      }
      return data;
    } catch(e){
      throw e.toString();
    }

  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
       appBar: AppBar(
         title: Text("Weather App",
           style: TextStyle(
             color:Colors.black,
             fontWeight: FontWeight.bold,
             fontSize: 22,
           ),
         ),
         centerTitle: true,
         actions: [
           IconButton(
               onPressed: (){
                 setState(() {

                 });
               },
               icon: const Icon(Icons.refresh),
           )
         ],
       ),
      body: FutureBuilder(
        future: getCurrentWeather(),
        builder:  (context,snapshot) {
         // print(snapshot);
          if(snapshot.connectionState==ConnectionState.waiting){
            return Center(
              child: const CircularProgressIndicator.adaptive(),
            );
          }

          if(snapshot.hasError){
            return Center(child: Text(snapshot.error.toString()));
          }
          // First container
          final data=snapshot.data!;
          final currentWeatherData=data['list'][0];
          final currentKelvin=currentWeatherData['main']['temp'];
          final currentSky=currentWeatherData['weather'][0]['main'];
          final currentTemp=(currentKelvin-273.15).toStringAsFixed(2);


          //Aditional information
          final currentHumidity=currentWeatherData['main']['humidity'];
          final currentPressure=currentWeatherData['main']['pressure'];
          final currentWindSpeed=currentWeatherData['wind']['speed'];

          return SingleChildScrollView(
            child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                    
                //first container
               Center(
                 child: SizedBox(
                   width:double.infinity ,
                   child: Card(
                     elevation: 10,
                     shape: RoundedRectangleBorder(
                       borderRadius: BorderRadius.circular(20.0)
                     ),
                    
                     child: ClipRRect(
                       borderRadius: BorderRadius.circular(16.0),
                       child: BackdropFilter(
                         filter: ImageFilter.blur(sigmaX: 10,sigmaY: 10),
                         child: Padding(
                           padding: const EdgeInsets.all(16.0),
                           child: Column(
                             children: [
                               Text("${currentTemp} °C",style:
                                  TextStyle(
                                   fontWeight: FontWeight.bold,
                                    fontSize: 25.0
                                  ),
                               ),
                               const SizedBox(height: 16,),
                               Icon(
                                 currentSky=='Clouds'|| currentSky== 'Rain' ?  Icons.cloud :Icons.sunny,
                                    size: 64,
                               ),
                               const SizedBox(height: 16),
                               Text(currentSky,
                               style: TextStyle(
                                 fontSize: 16,
                                 fontWeight: FontWeight.bold
                                ),
                               )
                             ],
                           ),
                         ),
                       ),
                     ),
                   ),
                 ),
               ),
                    
                const SizedBox(height: 20,),
            
            
            
                //second container
                    
                const Text("Weather Forecast",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 22.0
                  ),
                ),
                const SizedBox(height: 8),
            
                SizedBox(
                  height: 188,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount:18 ,
                      itemBuilder: (context,index){
                      final hourlyForcast=data['list'][index+1];
                      final hourlySky=hourlyForcast['weather'][0]['main'];
                      final dateTime=DateTime.parse( hourlyForcast['dt_txt']);
                        return HourlyForecast(
                            time:DateFormat.j().format(dateTime),
                            temperature: hourlyForcast['main']['temp'].toString(),
                            icon: hourlySky=='Rain' || hourlySky == 'Clouds' ? Icons.cloud : Icons.sunny,
                            status: hourlySky,
                        );
                      },
                  ),
                ),
            
                SizedBox(height: 20),
            
            
            
            
                //Third container
                    
                Text("Additional Information",
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold
                  ),
                ),
                const SizedBox(height: 8),
                    
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      AdditionalinfoItem(
                        icon: Icons.water_drop,
                        lable: "Humidity",
                        value: "$currentHumidity",
                      ),
                      const SizedBox(width: 20),
                      AdditionalinfoItem(
                        icon: Icons.air_outlined,
                        lable: "Wind Speed",
                        value: "$currentWindSpeed",
                      ),
                      const SizedBox(width: 20),
                      AdditionalinfoItem(
                        icon: Icons.beach_access,
                        lable: "Pressure",
                        value: "$currentPressure",
                      ),
                      const SizedBox(width: 20),
                    
                    
                    ],
                  ),
                )
              ],
            ),
                    ),
          );
        },
      ),
    );
  }
}
