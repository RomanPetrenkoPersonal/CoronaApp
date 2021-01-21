import 'package:corona_app/coronaData.dart';
import 'package:corona_app/infoBlock.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class CoronaScreen extends StatefulWidget {
  @override
  _CoronaScreenState createState() => _CoronaScreenState();
}

class _CoronaScreenState extends State<CoronaScreen> {
  CoronaData data = CoronaData(country: "Ukraine", confirmed: 1, recovered: 1, deaths: 1);
  List<String> countries = [
    'Ukraine',
    'France',
    'Germany',
    'Poland',
    'Slovakia'
  ];

  @override
  void initState() {
    super.initState();
    _loadAPI(data.country);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ClipPath(
        child: Column(
          children: <Widget>[
            Container(
            padding: EdgeInsets.only(left: 40, top: 50, right: 20),
            height: 370,
            width: double.infinity,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
                colors: [
                  Colors.red,
                  Colors.orange,
                ],
              ),
              image: DecorationImage(
                image: AssetImage("assets/images/virus.png"),
              ),
            ),
            ),
            Container(
              margin: EdgeInsets.only(left: 20, top: 15, right: 20),
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              height: 60,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(25),
                border: Border.all(
                  color: Colors.white,
                ),
              ),
              child: Row(
                children: <Widget>[
                  SvgPicture.asset("assets/icons/maps.svg"),
                  SizedBox(width: 20),
                  Expanded(
                    child: DropdownButton(
                      isExpanded: true,
                      underline: SizedBox(),
                      icon: SvgPicture.asset("assets/icons/dropdown.svg"),
                      value: data.country,
                      items: countries.map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                      onChanged: (value) {
                        _loadAPI(value);
                      },
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: <Widget>[
                  SizedBox(height: 20),
                  Container(
                    padding: EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          offset: Offset(0, 4),
                          blurRadius: 30,
                          color: Colors.grey,
                        ),
                      ],
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        InfoBlock(
                          color: Colors.orange,
                          number: data.confirmed,
                          title: "Confirmed",
                        ),
                        InfoBlock(
                          color: Colors.red,
                          number: data.deaths,
                          title: "Deaths",
                        ),
                        InfoBlock(
                          color: Colors.green,
                          number: data.recovered,
                          title: "Recovered",
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.orange,
        foregroundColor: Colors.white,
        child: Icon(Icons.refresh),
        onPressed: () {
          _loadAPI(data.country);
        },
      ),
    );
  }

  _loadAPI(String country) async {
    final response = await http.get('https://covid-api.mmediagroup.fr/v1/cases?country=' + country);
    if (response.statusCode == 200){
      var val = (json.decode(response.body) as Map)['All'];
      var record = CoronaData(
          country: val['country'],
          confirmed: val['confirmed'],
          recovered: val['recovered'],
          deaths: val['deaths']
      );
      setState(() {
        data = record;
      });
      print(record.toString());
    }
  }

}