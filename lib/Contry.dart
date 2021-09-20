import 'package:flip_card/flip_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:getapi/ContryMap.dart';

class Contry extends StatelessWidget {
  final Map contryDetail;
  const Contry({Key? key, required this.contryDetail}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text(contryDetail["name"]),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 14, vertical: 14),
        margin: EdgeInsets.all(10),
        child: GridView(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2, mainAxisSpacing: 8, crossAxisSpacing: 8),
          children: [
            FlipCard(
              front: CountryDetails(
                title: "Capital",
              ),
              back: CountryDetails2(
                contryDetail["capital"],
                Colors.orange,
              ),
            ),
            FlipCard(
              front: CountryDetails(
                title: "Population",
              ),
              back: CountryDetails2(
                contryDetail["population"].toString(),
                Colors.blue,
              ),
            ),
            FlipCard(
              front: CountryDetails(
                title: "Currency",
              ),
              back: CountryDetails2(
                  contryDetail["currencies"][0]["name"], Colors.yellow),
              //            //104.currencies[0].name104.currencies[0].symbol
            ),
            FlipCard(
                front: CountryDetails(
                  title: "Flag",
                ),
                back: Card(
                    color: Colors.tealAccent,
                    elevation: 10,
                    child: Center(
                        child: SvgPicture.network(
                      contryDetail["flag"],
                      width: 150,
                      height: 150,
                    )))),
            InkWell(
                splashColor: Colors.black,
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (ctx) => ContryMap(
                          contryDetail["name"], contryDetail["latlng"])));
                },
                child: CountryDetails(
                  title: "Show on Map",
                )),
          ],
        ),
      ),
    );
  }
}

class CountryDetails2 extends StatelessWidget {
  final value;
  final color;

  const CountryDetails2(
    this.value,
    this.color,
  );

  @override
  Widget build(BuildContext context) {
    return Card(
        color: color,
        elevation: 10,
        child: Center(
            child: Text(
          "${value}",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
        )));
  }
}

class CountryDetails extends StatelessWidget {
  final title;
  const CountryDetails({Key? key, this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
        elevation: 10,
        child: Center(
            child: Text(
          title,
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
        )));
  }
}
