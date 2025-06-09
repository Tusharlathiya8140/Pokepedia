import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:pokepedia/screens/login_screen.dart';
import 'package:pokepedia/screens/pokemon_detals.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List pokepedia = [];
  List filteredPokepedia = [];
  bool showSearchField = false;

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
  TextEditingController searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return WillPopScope(
      onWillPop: () async {
        if (showSearchField) {
          setState(() {
            showSearchField = false;
            searchController.clear();
            filteredPokepedia = pokepedia;
          });
          return false; // don't exit app
        }
        return true;
      },
      child: Scaffold(
        body: GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus(); // Hide keyboard
            if (showSearchField) {
              setState(() {
                showSearchField = false;
                searchController.clear();
                filteredPokepedia = pokepedia;
              });
            }
          },
          child: Stack(
            children: [
              Positioned(
                top: height * -0.05,
                right: width * -0.1,
                child: Image.asset(
                  'assets/images/pokeball.png',
                  width: width * 0.5,
                  fit: BoxFit.fitHeight,
                ),
              ),
              Positioned(
                top: height * 0.08,
                left: width * 0.03,
                child: Container(
                  width: width * 0.95,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Poke'Pedia",
                        style: TextStyle(
                          fontSize: height * 0.04,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Row(
                        children: [
                          IconButton(
                            onPressed: () {
                              setState(() {
                                showSearchField = !showSearchField;
                              });
                            },
                            icon: Icon(
                              Icons.search_rounded,
                              color: Colors.black,
                              size: height * 0.037,
                            ),
                          ),
                          IconButton(
                            onPressed: () async {
                              await FirebaseAuth.instance.signOut();
                              Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => LoginScreen(),
                                ),
                                (route) => false,
                              );
                            },
                            icon: Icon(
                              Icons.logout,
                              color: Colors.black,
                              size: height * 0.037,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),

              Positioned(
                top: height * 0.14,
                bottom: 0,
                width: width,
                child: Column(
                  children: [
                    showSearchField
                        ? Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: width * 0.016,
                            ),
                            child: Container(
                              width: width,
                              child: TextField(
                                controller: searchController,
                                decoration: InputDecoration(
                                  hintText: "Search Pokémon...",
                                  fillColor: Colors.black26,
                                  filled: true,
                                  contentPadding: EdgeInsets.symmetric(
                                    vertical: 10,
                                    horizontal: 15,
                                  ),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12),
                                    borderSide: BorderSide.none,
                                  ),
                                  prefixIcon: Icon(Icons.search),
                                  suffixIcon: IconButton(
                                    onPressed: () {
                                      String query = searchController.text
                                          .toLowerCase();
                                      setState(() {
                                        filteredPokepedia = pokepedia
                                            .where(
                                              (pokemon) => pokemon['name']
                                                  .toString()
                                                  .toLowerCase()
                                                  .contains(query),
                                            )
                                            .toList();
                                      });
                                    },
                                    icon: Icon(Icons.arrow_forward),
                                  ),
                                ),
                              ),
                            ),
                          )
                        : SizedBox(height: 0, width: 0),

                    pokepedia != null
                        ? Expanded(
                            child: GridView.builder(
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2,
                                    childAspectRatio: 1.4,
                                  ),
                              itemCount: filteredPokepedia.length,
                              itemBuilder: (context, index) {
                                var type = filteredPokepedia[index]['type'][0];
                                return Padding(
                                  padding: EdgeInsets.all(width * 0.015),
                                  child: InkWell(
                                    child: Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(
                                          width * 0.03,
                                        ),
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
                                            bottom: width * -0.05,
                                            right: width * -0.05,
                                            child: Image.asset(
                                              'assets/images/pokeball.png',
                                              width: width * 0.25,
                                              fit: BoxFit.fitHeight,
                                            ),
                                          ),
                                          Positioned(
                                            top: width * 0.04,
                                            left: width * 0.03,
                                            child: Text(
                                              filteredPokepedia[index]['name'],
                                              style: TextStyle(
                                                fontSize: height * 0.02,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.white,
                                              ),
                                            ),
                                          ),
                                          Positioned(
                                            top: width * 0.11,
                                            left: width * 0.02,
                                            child: Container(
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(
                                                      width * 0.05,
                                                    ),
                                                color: Colors.white30,
                                              ),
                                              child: Padding(
                                                padding: EdgeInsets.symmetric(
                                                  vertical: width * 0.007,
                                                  horizontal: width * 0.02,
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
                                            bottom: width * 0.01,
                                            right: width * 0.01,
                                            child: CachedNetworkImage(
                                              imageUrl:
                                                  filteredPokepedia[index]['img'],
                                              height: height * 0.11,
                                              fit: BoxFit.fill,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => PokeDetails(
                                            tag: index,
                                            pokedetails: pokepedia[index],
                                            color: type == 'Grass'
                                                ? Colors.greenAccent
                                                : type == 'Fire'
                                                ? Colors.redAccent
                                                : type == 'Water'
                                                ? Colors.blueAccent
                                                : type == 'Electric'
                                                ? Colors.amber
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
                                                ? Colors.grey
                                                : type == 'Poison'
                                                ? Colors.deepPurpleAccent
                                                : Colors.pink,
                                          ),
                                        ),
                                      );
                                    },
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
        ),
      ),
    );
  }

  void fetchData() {
    var url = Uri.parse(pokepediaApi);
    http.get(url).then((value) {
      if (value.statusCode == 200) {
        var decodedData = jsonDecode(value.body);
        pokepedia = decodedData["pokemon"];
        filteredPokepedia = pokepedia;
        setState(() {});
      }
    });
  }
}
