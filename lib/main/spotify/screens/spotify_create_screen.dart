import 'dart:io';

import 'package:flutter/material.dart';
import 'package:sirio_portfolio/main/core/theme.dart';

class SpotifyCreateScreen extends StatefulWidget {
  @override
  _SpotifyCreateScreenState createState() => _SpotifyCreateScreenState();
}

class _SpotifyCreateScreenState extends State<SpotifyCreateScreen> {
  final TextStyle _titleStyle = TextStyle(
    fontSize: 30,
    color: Colors.white,
    fontWeight: FontWeight.w400
  );

  final TextStyle _titleItem = TextStyle(
    fontSize: 24,
    color: Colors.white,
    fontWeight: FontWeight.w400
  );
  
  final TextStyle _button = TextStyle(
    fontSize: 20,
    color: Colors.white,
    fontWeight: FontWeight.w400
  );

  final List<String> _topChoices = ["Last 4 weeks","Last 6 months","Lifetime"];
  int? _defaultTopIndex;

  @override
  Widget build(BuildContext context) {

    final Size size = MediaQuery.of(context).size;


    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [

            _appBar(context),
            Expanded(
              child: SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: Column(
                  children: [
              
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                      width: double.infinity,
                      height: 180,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        border: Border.all( 
                          color: AppColors.spotifyGreyLighter.withOpacity(0.5), 
                          width: 1.0
                        )
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          
                          Text("Top tracks", style: _titleItem),
                          Expanded(
                            
                            child: ListView.builder(
                              itemCount: _topChoices.length,
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (BuildContext context, int index) {
                                return Padding(
                                  padding: const EdgeInsets.only(right: 8.0),
                                  child: ChoiceChip(
                                    label: Text(
                                      _topChoices[index],
                                      style: (_defaultTopIndex == index)
                                        ? TextStyle(color: AppColors.spotifyBlack)
                                        : TextStyle(color: Colors.white),  
                                    ),
                                    selected: _defaultTopIndex == index,
                                    selectedColor: AppColors.spotifyGreen,
                                    onSelected: (selected) {
                                      _defaultTopIndex = selected ? index : null;
                                      setState(() {});
                                    },
                                  ),
                                );
                              },
                            ),
                          ),
                          TextButton(
                            onPressed: () {},
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all(AppColors.trans)
                            ), 
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [

                                Image(
                                  image: AssetImage("assets/spotify/icon_green.png"),
                                  height: 22,
                                  width: 22,
                                ),
                                SizedBox(width: 5),
                                Text("Create", style: _button),
                                SizedBox(width: 20),

                              ],
                            )
                          ),

                        ]
                      ),
                    ),
              
                  ],
                ),
              ),
            )

          ]
        ),
      ),
    );
  }

  Container _appBar(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(15, 20, 15, 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [

            GestureDetector(
            onTap: () => Navigator.pop(context),
            child: Icon(Icons.chevron_left, color: Colors.white, size: 40),
          ),
          Text( "Create playlist", style: _titleStyle ),
          Container(width: 40, height: 40)
          
        ]
      ),
    );
  }
}