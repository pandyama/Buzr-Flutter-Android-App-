import 'package:flutter/material.dart';

class DayPick extends StatefulWidget{

  @override
  DayPickState createState() => new DayPickState();
}

bool isMonday = false;
bool isTuesday = false;
bool isWednesday = false;
bool isThursday = false;
bool isFriday = false;
bool isSaturday = false;
bool isSunday = false;

class DayPickState extends State<DayPick> with AutomaticKeepAliveClientMixin{


  @override
  bool get wantKeepAlive => true;

  void onChanged(bool val){
    setState(() {
      isMonday = val;
    });
  }
  void onChanged2(bool val){
    setState(() {
      isTuesday = val;
    });
  }
  void onChanged3(bool val){
    setState(() {
      isWednesday = val;
    });
  }
  void onChanged4(bool val){
    setState(() {
      isThursday = val;
    });
  }
  void onChanged5(bool val){
    setState(() {
      isFriday = val;
    });
  }
  void onChanged6(bool val){
    setState(() {
      isSaturday = val;
    });
  }
  void onChanged7(bool val){
    setState(() {
      isSunday = val;
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: new Container(
          padding: new EdgeInsets.all(32.0),
          child: new Center(
              child:
              new Column(
                children: <Widget>[
                  giveTile("Monday", "_isMonday"),
                  giveTile("Tuesday", "_isTuesday"),
                  giveTile("Wednesday", "_isWednesday"),
                  giveTile("Thursday", "_isThursday"),
                  giveTile("Friday", "_isFriday"),
                  giveTile("Saturday", "_isSaturday"),
                  giveTile("Sunday", "_isSunday")
                ],
              )
          )
      ),
    );
  }

  CheckboxListTile giveTile(String text, String day){
    bool val = null;
    if(day == "_isMonday"){
      val = isMonday;
      return CheckboxListTile(
          title:  Text(text),
          value: val,
          onChanged: (bool value){onChanged(value);}
      );
    }
    else if(day == "_isTuesday"){
      val = isTuesday;
      return CheckboxListTile(
          title:  Text(text),
          value: val,
          onChanged: (bool value){onChanged2(value);}
      );
    }
    else if(day == "_isWednesday"){
      val = isWednesday;
      return CheckboxListTile(
          title:  Text(text),
          value: val,
          onChanged: (bool value){onChanged3(value);}
      );
    }
    else if(day == "_isThursday"){
      val = isThursday;
      return CheckboxListTile(
          title:  Text(text),
          value: val,
          onChanged: (bool value){onChanged4(value);}
      );
    }
    else if(day == "_isFriday"){
      val = isFriday;
      return CheckboxListTile(
          title:  Text(text),
          value: val,
          onChanged: (bool value){onChanged5(value);}
      );
    }
    else if(day == "_isSaturday"){
      val = isSaturday;
      return CheckboxListTile(
          title:  Text(text),
          value: val,
          onChanged: (bool value){onChanged6(value);}
      );
    }
    else if(day == "_isSunday"){
      val = isSunday;
      return CheckboxListTile(
          title:  Text(text),
          value: val,
          onChanged: (bool value){onChanged7(value);}
      );
    }

  }

}
