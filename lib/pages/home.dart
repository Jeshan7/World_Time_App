import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Map data = {};

  @override
  Widget build(BuildContext context) {

    data = data.isNotEmpty ? data :  ModalRoute.of(context).settings.arguments;
    print(data);

    String bgImage = data['isDayTime'] ? 'day.png' : 'night.png';
    Color navColor = data['isDayTime'] ? Colors.blue : Colors.grey[700];
    Color textColor = data['isDayTime'] ? Colors.white : Colors.grey[700];

    return Scaffold(
      backgroundColor: navColor,
      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(
              image: DecorationImage(
            image: AssetImage('assets/$bgImage'),
            fit: BoxFit.cover,
          )),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(0, 120.0, 0, 0),
            child: Column(
              children: <Widget>[
                FlatButton.icon(
                    onPressed: () async {
                      dynamic result = await Navigator.pushNamed(context, '/location');
                    setState(() {
                      data = {
                        'time': result['time'],
                        'location': result['location'],
                        'isDayTime': result['isDayTime'],
                        'flag': result['flag']
                      };
                    });
                      },
                    icon: Icon(
                      Icons.edit_location,
                      color: Colors.grey[300],
                    ),
                    label: Text(
                      'Edit Location',
                      style: TextStyle(fontSize: 22.0, color: textColor),
                    )),
                SizedBox(height: 20.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      data["location"],
                      style: TextStyle(
                          fontSize: 28.0,
                          letterSpacing: 2.0,
                          color: textColor),
                    ),
                  ],
                ),
                SizedBox(height: 20.0),
                Text(data["time"],
                    style: TextStyle(fontSize: 66.0, color: textColor))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
