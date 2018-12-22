import 'package:flutter/material.dart';

class pickFrequency extends StatefulWidget{

  @override
  pickFrequencyState createState() => pickFrequencyState();

}

int groupValue;
TextEditingController myControl = TextEditingController();

class pickFrequencyState extends State<pickFrequency> with AutomaticKeepAliveClientMixin{

  @override
  bool get wantKeepAlive => true;

  TimeOfDay timeOfDay = new TimeOfDay.now();
  var today = new DateTime.now();


  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        resizeToAvoidBottomPadding: false,
      body: new Container(
        alignment: Alignment.center,
        child: new ListView(
          children: <Widget>[
            new Padding(padding: new EdgeInsets.all(6.0)),
            new TextField(
              controller: myControl,
              keyboardType: TextInputType.number,
              decoration: new InputDecoration(
                  labelText: 'Frequency',
                icon: new Icon(Icons.add_alert)
              ),
            ),
            new Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  new Radio(
                      value: 0,
                      onChanged: (int e) => doSomething(e),
                      groupValue: groupValue,
                ),
                new Text('Seconds'),
                new Padding(padding: EdgeInsets.all(4.5)),
                new Radio(
                  value: 1,
                  onChanged: (int e) => doSomething(e),
                  groupValue: groupValue,
                ),
                new Text('Minutes'),
                  new Padding(padding: EdgeInsets.all(4.5)),
                  new Radio(
                    value: 2,
                    onChanged: (int e) => doSomething(e),
                    groupValue: groupValue,
                  ),
                  new Text('Hours'),
                ],
            ),
          ],
        )
      )
    );

  }

  void doSomething(int e){
    setState(() {
      if(e == 0){
        groupValue = 0;
      }
      else if(e == 1){
        groupValue = 1;
      }
      else if(e == 2){
        groupValue = 2;
      }
      });
  }

}

String giveFrequency(){
  String x = myControl.text.toString();
  return x;
}

int giveGroupValue(){
  return groupValue;
}