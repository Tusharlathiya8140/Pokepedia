import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class PokeDetails extends StatefulWidget {
  final tag;
  final pokedetails;
  final Color color;
  const PokeDetails({
    super.key,
    required this.tag,
    required this.pokedetails,
    required this.color,
  });

  @override
  State<PokeDetails> createState() => _PokeDetailsState();
}

class _PokeDetailsState extends State<PokeDetails> {
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: widget.color,
      body: Stack(
        children: [
          Positioned(
            top: height * 0.04,
            left: width * 0.01,
            child: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(
                Icons.arrow_back,
                color: Colors.white,
                size: width * 0.08,
              ),
            ),
          ),
          Positioned(
            top: height * 0.09,
            left: width * 0.04,
            child: Text(
              widget.pokedetails['name'],
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: height * 0.04,
                color: Colors.white,
              ),
            ),
          ),
          Positioned(
            top: height * 0.145,
            left: width * 0.04,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(width * 0.05),
                color: Colors.black26,
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(
                  vertical: width * 0.01,
                  horizontal: width * 0.03,
                ),
                child: Text(
                  widget.pokedetails['type'].join(' , '),
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: height * 0.02,
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            bottom: height * 0.54,
            right: width * -0.1,
            child: Image.asset(
              'assets/images/pokeball.png',
              width: width * 0.6,
              fit: BoxFit.fitHeight,
            ),
          ),
          Positioned(
            bottom: height * 0.6,
            right: width * 0.05,
            child: CachedNetworkImage(
              imageUrl: widget.pokedetails['img'],
              height: height * 0.25,
              fit: BoxFit.fill,
            ),
          ),
          Positioned(
            bottom: 0,
            child: Container(
              height: height * 0.6,
              width: width,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(width * 0.08),
                  topRight: Radius.circular(width * 0.08),
                ),
              ),
              child: Padding(
                padding: EdgeInsets.all(width * 0.03),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(height: height * 0.01),
                    Padding(
                      padding: EdgeInsets.all(width * 0.01),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: width * 0.4,
                            child: Text(
                              'Name',
                              style: TextStyle(
                                fontSize: height * 0.028,
                                color: Colors.blueGrey,
                              ),
                            ),
                          ),
                          Expanded(
                            child: Container(
                              child: Text(
                                widget.pokedetails['name'],
                                style: TextStyle(
                                  fontSize: height * 0.028,
                                  color: Colors.black87,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(width * 0.01),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: width * 0.4,
                            child: Text(
                              'Height',
                              style: TextStyle(
                                fontSize: height * 0.028,
                                color: Colors.blueGrey,
                              ),
                            ),
                          ),
                          Expanded(
                            child: Container(
                              child: Text(
                                widget.pokedetails['height'],
                                style: TextStyle(
                                  fontSize: height * 0.028,
                                  color: Colors.black87,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(width * 0.01),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: width * 0.4,
                            child: Text(
                              'Weight',
                              style: TextStyle(
                                fontSize: height * 0.028,
                                color: Colors.blueGrey,
                              ),
                            ),
                          ),
                          Expanded(
                            child: Container(
                              child: Text(
                                widget.pokedetails['weight'],
                                style: TextStyle(
                                  fontSize: height * 0.028,
                                  color: Colors.black87,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(width * 0.01),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: width * 0.4,
                            child: Text(
                              'Spawn Time',
                              style: TextStyle(
                                fontSize: height * 0.028,
                                color: Colors.blueGrey,
                              ),
                            ),
                          ),
                          Expanded(
                            child: Container(
                              child: Text(
                                widget.pokedetails['spawn_time'],
                                style: TextStyle(
                                  fontSize: height * 0.028,
                                  color: Colors.black87,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(width * 0.01),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: width * 0.4,
                            child: Text(
                              'Weaknesses',
                              style: TextStyle(
                                fontSize: height * 0.028,
                                color: Colors.blueGrey,
                              ),
                            ),
                          ),
                          Expanded(
                            child: Container(
                              child: Text(
                                widget.pokedetails['weaknesses'].join(', '),
                                style: TextStyle(
                                  fontSize: height * 0.028,
                                  color: Colors.black87,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(width * 0.01),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: width * 0.4,
                            child: Text(
                              'Evolution',
                              style: TextStyle(
                                fontSize: height * 0.028,
                                color: Colors.blueGrey,
                              ),
                            ),
                          ),
                          widget.pokedetails['next_evolution'] != null
                              ? Expanded(
                                  child: Text(
                                    (widget.pokedetails['next_evolution']
                                            as List)
                                        .map<String>(
                                          (e) => e['name'].toString(),
                                        )
                                        .join(', '),
                                    style: TextStyle(
                                      fontSize: height * 0.028,
                                      color: Colors.black87,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                )
                              : Text(
                                  'Maxed Out',
                                  style: TextStyle(
                                    fontSize: height * 0.028,
                                    color: Colors.black87,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
