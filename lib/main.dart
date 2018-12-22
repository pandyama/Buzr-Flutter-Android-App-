import 'package:flutter/material.dart';
import 'timepick.dart';
import 'frequency.dart';
import 'dart:async';
import 'daypicker.dart';
import 'package:ringtone/ringtone.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';




void main() => runApp(
    new MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MyApp()
    )
    );


class MyApp extends StatefulWidget{
  @override
    MyAppState createState() => MyAppState();

}

bool timerFlag = false;
bool onOff = false;
Duration oneSec;

class MyAppState extends State<MyApp> with SingleTickerProviderStateMixin{
  final day = new DayPick();
  final time = new MyTime();
  final frequency = new pickFrequency();
  TabController tbc;
  int currentTab = 0;
  FlutterLocalNotificationsPlugin localNotificationsPlugin;
  TimeOfDay timeOfDay = new TimeOfDay.now();
  var today = new DateTime.now();
  bool _value = false;


  @override
  void initState(){
    super.initState();
    tbc = new TabController(length: 4, vsync: this);

    localNotificationsPlugin = new FlutterLocalNotificationsPlugin();

    var initializeSettingsAndroid = new AndroidInitializationSettings('@mipmap/ic_buzr');
    var initializeSettingsIOS = new IOSInitializationSettings();
    var initializeSettings = new InitializationSettings(initializeSettingsAndroid, initializeSettingsIOS);
    localNotificationsPlugin.initialize(initializeSettings, onSelectNotification: onSelectNotification);
  }

  void onChanged(bool value){
    setState(() {
      _value = value;
      if(value){
        onOff = true;
        startTimer();
      }
      else{
        onOff = false;
        startTimer();
      }
    });
  }


  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Buzr"),
        bottom: new TabBar(
          controller: tbc,
        tabs: <Widget>[
          new Tab(
            icon: new Icon(Icons.home),
          ),
          new Tab(
            icon: new Icon(Icons.view_day),
          ),
          new Tab(
            icon: new Icon(Icons.access_time)
          ),
          new Tab(
            icon: new Icon(Icons.timer)
          )
        ],
      )
      ),
        body: new TabBarView(
            children: <Widget>[
              new Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  new Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                      new Text("Buzr On/Off"),
                    new Switch(value: _value, onChanged: (bool val){onChanged(val);})
                    ]
                  ),
                  new Padding(padding: EdgeInsets.all(30.0)),
                  new RaisedButton(
                      child: Text("Save Settings"),
                      onPressed: (){startTimer();})
              ]), day, time, frequency
            ],
          controller: tbc,
        ),
    );
  }

  Future onSelectNotification(String payload) {
    print("notification selected");
    localNotificationsPlugin.cancelAll();
    Ringtone.stop();
  }


  onNotification() async{
    var androidChannelSpecifics = new AndroidNotificationDetails(
      'A1', 'droid', 'Android Buzr', importance: Importance.Max,
      priority: Priority.High);

    var iOSChannelSpecifics = new IOSNotificationDetails();
    var platformChannelSpecifics = new NotificationDetails(androidChannelSpecifics, iOSChannelSpecifics);

    await localNotificationsPlugin.show(0, 'Buzr', 'Reminder', platformChannelSpecifics, payload: 'Default_Sound');
    Ringtone.play();

  }


  void startTimer(){

    int y = int.tryParse(giveFrequency()) ?? 5;
    assert(y is int);
    var currentDay = today.weekday;

    timerFlag = false;
    oneSec = Duration(seconds: 0);

    if((isBounded() && (isMonday && currentDay == 1) ||
      (isTuesday && currentDay == 2) ||
      (isWednesday && currentDay == 3) ||
      (isThursday && currentDay == 4) ||
      (isFriday && currentDay == 5) ||
      (isSaturday && currentDay == 6) ||
      (isSunday && currentDay == 7)) && onOff) {


          if (giveGroupValue() == 0) {
            oneSec = Duration(seconds: y);
            timerFlag = true;
          }
          else if (giveGroupValue() == 1) {
            oneSec = Duration(minutes: y);

          }
          else if (giveGroupValue() == 2) {
            oneSec = Duration(hours: y);
            }

          interval(oneSec, (t4){
            if(!timerFlag){
              t4.cancel();
              Ringtone.stop();
            }
            else {
              onNotification();
            }
          });
    }
    else{
      interval(oneSec,(t4){
        t4.cancel();
        Ringtone.stop();
      });

    }
  }

  Timer interval(Duration duration, func) {
    Timer function() {
      Timer timer = new Timer(duration, function);
      func(timer);
      return timer;
    }
    return new Timer(duration, function);
  }


}
