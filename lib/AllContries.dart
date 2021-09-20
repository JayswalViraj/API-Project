import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:getapi/Contry.dart';

class AllContries extends StatefulWidget {
  const AllContries({
    Key? key,
  }) : super(key: key);

  @override
  _AllContriesState createState() => _AllContriesState();
}

class _AllContriesState extends State<AllContries> {
  bool isSerching = false;

  List allcontries = [];
  List filterdcontries = [];

  getApi() async {
    var dio = Dio();
    final response = await dio.get('https://restcountries.eu/rest/v2/all');

    return response.data;
  }

  @override
  void initState() {
    getApi().then((data) {
      setState(() {
        allcontries = filterdcontries = data;
      });
    });

    super.initState();
  }

  void _filterCountries(value) {
    setState(() {
      filterdcontries = allcontries
          .where((country) =>
              country['name'].toLowerCase().contains(value.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xff000000),
          leading: isSerching ? Icon(Icons.search) : null,
          title: isSerching
              ? TextField(
                  style: TextStyle(color: Colors.blue, fontSize: 20),
                  decoration: InputDecoration(
                    hintText: "Search Country",
                    hintStyle: TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                        fontWeight: FontWeight.w500),
                  ),
                  onChanged: (value) {
                    _filterCountries(value);
                  },
                )
              : Text("All Countries"),
          actions: [
            isSerching
                ? IconButton(
                    onPressed: () {
                      setState(() {
                        isSerching = false;
                        filterdcontries = allcontries;
                      });
                    },
                    icon: Icon(Icons.cancel))
                : IconButton(
                    onPressed: () {
                      setState(() {
                        isSerching = true;
                      });
                    },
                    icon: Icon(Icons.search)),
          ],
        ),
        body: Container(
          padding: EdgeInsets.all(12),
          child: filterdcontries.length > 0
              ? ListView.builder(
                  itemCount: filterdcontries.length,
                  itemBuilder: (context, index) {
                    return Card(
                      elevation: 10,
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => Contry(
                                    contryDetail: filterdcontries[index],
                                  ),
                                ));
                          },
                          child: Text(
                            filterdcontries[index]["name"],
                            style: TextStyle(
                              fontSize: 20,
                            ),
                          ),
                        ),
                      ),
                    );
                  })
              : Center(child: CircularProgressIndicator()),
        ));
  }
}
