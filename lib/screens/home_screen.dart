import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List pokepedia = [];

  @override
  void initState() {
    // TODO: implement initState
    if (mounted) {
      fetchData();
    }
    super.initState();
  }

  var pokepediaApi =
      "https://raw.githubusercontent.com/Biuni/PokemonGo-Pokedex/master/pokedex.json";
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            top: -50,
            right: -50,
            child: Image.asset(
              'assets/images/pokeball.png',
              width: 250,
              fit: BoxFit.fitHeight,
            ),
          ),
          Positioned(
            top: 90,
            left: 15,
            child: Text(
              "Poke'pedia",
              style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold),
            ),
          ),
          Positioned(
            top: 160,
            bottom: 0,
            width: width,
            child: Column(
              children: [
                pokepedia != null
                    ? Expanded(
                        child: GridView.builder(
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                childAspectRatio: 1.4,
                              ),
                          itemCount: pokepedia.length,
                          itemBuilder: (context, index) {
                            var type = pokepedia[index]['type'][0];
                            return Padding(
                              padding: const EdgeInsets.all(6.0),
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: type == 'Grass'
                                      ? Colors.greenAccent
                                      : type == 'Fire'
                                      ? Colors.redAccent
                                      : type == 'Water'
                                      ? Colors.blueAccent
                                      : type == 'Electric'
                                      ? Colors.yellow
                                      : type == 'Rock'
                                      ? Colors.grey
                                      : type == 'Ground'
                                      ? Colors.brown
                                      : type == 'Psychic'
                                      ? Colors.indigo
                                      : type == 'Fighting'
                                      ? Colors.orange
                                      : type == 'Bug'
                                      ? Colors.lightGreen
                                      : type == 'Ghost'
                                      ? Colors.deepPurple
                                      : type == 'Normal'
                                      ? Colors.black26
                                      : type == 'Poison'
                                      ? Colors.deepPurpleAccent
                                      : Colors.pink,
                                ),
                                child: Stack(
                                  children: [
                                    Positioned(
                                      bottom: -10,
                                      right: -10,
                                      child: Image.asset(
                                        'assets/images/pokeball.png',
                                        width: 100,
                                        fit: BoxFit.fitHeight,
                                      ),
                                    ),
                                    Positioned(
                                      top: 15,
                                      left: 10,
                                      child: Text(
                                        pokepedia[index]['name'],
                                        style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                    Positioned(
                                      top: 40,
                                      left: 10,
                                      child: Container(
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(
                                            20,
                                          ),
                                          color: Colors.white30,
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                            vertical: 4,
                                            horizontal: 8,
                                          ),
                                          child: Text(
                                            type.toString(),
                                            style: TextStyle(
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Positioned(
                                      bottom: 5,
                                      right: 5,
                                      child: CachedNetworkImage(
                                        imageUrl: pokepedia[index]['img'],
                                        height: 110,
                                        fit: BoxFit.fill,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      )
                    : Center(child: CircularProgressIndicator()),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void fetchData() {
    var url = Uri.parse(pokepediaApi);
    http.get(url).then((value) {
      if (value.statusCode == 200) {
        var decodedData = jsonDecode(value.body);
        pokepedia = decodedData["pokemon"];
        setState(() {});
      }
    });
  }
}
