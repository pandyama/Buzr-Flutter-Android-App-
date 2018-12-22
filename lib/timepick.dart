import 'package:flutter/material.dart';
import 'dart:async';


class MyTime extends StatefulWidget{
  @override
  MyTimePage createState() => MyTimePage();
}

TimeOfDay timeOfDay = new TimeOfDay.now();
TimeOfDay startTime = new TimeOfDay.now();
TimeOfDay endTime = new TimeOfDay.now();


class MyTimePage extends State<MyTime> with AutomaticKeepAliveClientMixin{

  @override
  bool get wantKeepAlive => true;

  Future<Null> _selectStartTime(BuildContext context) async{
     TimeOfDay picked = await showTimePicker(
        context: context, initialTime: timeOfDay);

    if(picked != null && picked != timeOfDay){
      setState(() {
        startTime = picked;
      });
    }
  }

  Future<Null> _selectEndTime(BuildContext context) async{
    TimeOfDay picked = await showTimePicker(
        context: context, initialTime: timeOfDay);

    if(picked != null && picked != timeOfDay){
      setState(() {
        endTime = picked;
      });
    }
  }

  TimeOfDay giveStart(){
    return startTime;
  }
  TimeOfDay giveEnd(){
    return endTime;
  }


  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: new Container(
          child: new Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            //new Text("Start At: ${startTime.hourOfPeriod}:${startTime.minute}"),
            new Text(showText(),
                style: new TextStyle(
                fontSize: 15.0)),
            new IconButton(
                color: Colors.cyanAccent,
                icon: new Icon(Icons.alarm_on) , onPressed: (){_selectStartTime(context);}
            ),
            new Padding(padding: new EdgeInsets.all(20.0)),
            //new Text("End Buzr: ${endTime.hourOfPeriod}:${endTime.minute}"),
            new Text(
                showEnd(),
              style: new TextStyle(
                fontSize: 15.0)
            ),
            new IconButton(
                color: Colors.pinkAccent,
                icon: new Icon(Icons.alarm_off) , onPressed: (){_selectEndTime(context);}
            ),
          ],
        )
      ),
    );
  }

  showText(){
    if(startTime.minute < 10){
      return "From  ${startTime.hourOfPeriod}:0${startTime.minute}";
    }
    else{
      return "From  ${startTime.hourOfPeriod}:${startTime.minute}";
    }
  }
  showEnd(){
    if(startTime.minute < 10){
      return "To  ${endTime.hourOfPeriod}:0${endTime.minute}";
    }
    else{
      return "To  ${endTime.hourOfPeriod}:${endTime.minute}";
    }
  }

}

bool isBounded(){
  if((startTime.hour == timeOfDay.hour) && (endTime.hour != timeOfDay.hour)){
    if(startTime.minute < timeOfDay.minute){
      return true;
    }
    else{
      return false;
    }
  }
  else if((startTime.hour != timeOfDay.hour) && (endTime.hour == timeOfDay.hour)){
    if(endTime.minute > timeOfDay.minute){
      return true;
    }
    else{
      return false;
    }
  }
  else if((startTime.hour == timeOfDay.hour) && (endTime.hour == timeOfDay.hour)){
    if(startTime.minute < timeOfDay.minute && endTime.minute > timeOfDay.minute){
      return true;
    }
    else{
      return false;
    }
  }
  else if((startTime.hour != timeOfDay.hour) && (endTime.hour != timeOfDay.hour)){
    if(startTime.hour < timeOfDay.hour && endTime.hour > timeOfDay.hour){
      return true;
    }
    else{
      return false;
    }
  }
  else{
    return false;
  }

}