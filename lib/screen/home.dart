import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  var country;
  var tz_id;
  var name;
  var last_updated;
  var temp_c;
  var temp_f;
  String link="http://api.weatherapi.com/v1/current.json?key=c3ed3efa78c74296a1c141416221006&q=Bangladesh";

 Future getWeatherData() async{
    var response= await http.get(Uri.parse(link));
   // print("starts code is${response.statusCode}");
    var results=jsonDecode(response.body);
   setState(() {
     this.country=results["location"]["country"];
     this.tz_id=results["location"]["tz_id"];
     this.last_updated=results["current"]["last_updated"];
     this.temp_c=results["current"]["temp_c"];
     this.temp_f=results["current"]["temp_f"];

   });


  }
  @override
  void initState() {
    // TODO: implement initState
    getWeatherData();
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: NetworkImage("https://wallpaperaccess.com/full/701617.jpg"),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
              Colors.black.withOpacity(0.7),
              BlendMode.darken,
            ),

          ),
        ),

      child: Scaffold(
        backgroundColor: Colors.transparent,

        body: Padding(
          padding: const EdgeInsets.all(16),
          child: Center(
            child: Column(
              children: [

                SizedBox(height: 80,),
                Text(country != null? country.toString():"Loading...",style: TextStyle(fontSize: 20,color: Colors.white),),
                SizedBox(height: 10,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(temp_c != null? temp_c.toString():"Loading...",style: TextStyle(fontSize: 50,color: Colors.white),),
                    Text("°C",style: TextStyle(fontSize: 50,color: Colors.white),),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(temp_f != null? temp_f.toString():"Loading...",style: TextStyle(fontSize: 20,color: Colors.white),),
                    Text("°F",style: TextStyle(fontSize: 20,color: Colors.white),),
                  ],
                ),
                SizedBox(height: 3,),
                Text(tz_id != null? tz_id.toString():"Loading...",style: TextStyle(fontSize: 14,color: Colors.white),),
                SizedBox(height: 20,),


                // Image.network("https://cdn.weatherapi.com/weather/64x64/night/176.png",width: 50,height: 50,),
                // Text(text!= null? text.toString():"Loading",style: TextStyle(fontSize: 14,color: Colors.white),),
                SizedBox(height: 30,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text("Last Updated: ",style: TextStyle(fontSize: 12,color: Colors.white70),),
                    Text(last_updated != null? last_updated.toString():"Loading...",style: TextStyle(fontSize: 12,color: Colors.yellow),),
                  ],
                ),

              ],
            ),
          ),
        ),


        floatingActionButton: new FloatingActionButton(
          onPressed: (){
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (BuildContext context) => super.widget));
          },
          tooltip: 'Refreshed',
          backgroundColor: Colors.black45,
          child: new Icon(Icons.refresh),
        ),
      ),


    );
  }
}
