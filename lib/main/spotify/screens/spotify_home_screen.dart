import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sirio_portfolio/main/core/theme.dart';
import 'package:sirio_portfolio/main/spotify/blocs/top_bloc.dart';
import 'package:sirio_portfolio/main/spotify/models/top_artists_response.dart';
import 'package:sirio_portfolio/main/spotify/screens/spotify_screens.dart';

class SpotifyHomeScreen extends StatefulWidget {
  @override
  _SpotifyHomeScreenState createState() => _SpotifyHomeScreenState();
}

class _SpotifyHomeScreenState extends State<SpotifyHomeScreen> {

  final _titleStyle = TextStyle(
    color: Colors.white,
    fontWeight: FontWeight.w900,
    fontSize: 24,
  );
  
  int _stackIndex = 0;

  @override
  void initState() {
    super.initState();
    topBloc.fetchTopArtists();
  }

  @override
  Widget build(BuildContext context) {

    final size = MediaQuery.of(context).size;

    return Scaffold(
      extendBody: true,
      backgroundColor: AppColors.spotifyBlack,
      body: IndexedStack(
        index: _stackIndex,
        children: [
          _body(size),
          SpotifySearchScreen(),
          SpotifyLibraryScreen(),
        ],
      ),
      bottomNavigationBar: _navBar(),
    );
  }

  Row _title20width(String text) {
    return Row(
      children: [
        SizedBox(width: 20),
        Text( "$text", style: _titleStyle ),
      ],
    );
  }

  Widget _navBar() {

    return Stack(
      children: [

        IgnorePointer(
          ignoring: true,
          child: Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: 150,
              width: double.infinity,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  stops: [
                    0.0,
                    1.0
                  ],
                  colors: [
                    AppColors.trans,
                    Colors.black
                  ]
                )
              ),
            ),
          ),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            height: 60,
            child: Theme(
              data: Theme.of(context).copyWith(
                splashColor: AppColors.trans,
                highlightColor: AppColors.trans,
                toggleableActiveColor: AppColors.trans
              ),
              child: BottomNavigationBar(
                type: BottomNavigationBarType.fixed,
                iconSize: 22,
            
                backgroundColor: AppColors.trans,
                selectedItemColor: Colors.white,
                unselectedItemColor: AppColors.spotifyGreyLighter,
                currentIndex: _stackIndex,
                onTap: (i) {
                  _stackIndex = i;
                  setState(() {});
                },
                elevation: 0.0,
                items: [
              
                  BottomNavigationBarItem(
                    icon: Icon( Icons.home_filled ),
                    tooltip: "Home button",
                    label: "Home"
                  ),
              
                  BottomNavigationBarItem(
                    icon: Icon( Icons.search ),
                    tooltip: "Search button",
                    label: "Search"
                  ),
                  
                  BottomNavigationBarItem(
                    icon: Icon( FontAwesomeIcons.gitter ),
                    tooltip: "Your Library button",
                    label: "Your Library"
                  ),
              
                ],
              ),
            ),
          ),
        ),

      ],
    );
  }

  SafeArea _body(Size size) {
    return SafeArea(
      bottom: false,
      child: Stack(
        children: [
          
          SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Container(
              padding: const EdgeInsets.fromLTRB(0, 20, 0, 30),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                
                  _title20width("Good afternoon"),
                  SizedBox(height: 25),
                  Row(
                    children: [
                      SizedBox(width: 20),
                      _rowsAndColumn(size),
                    ]
                  ),
                  SizedBox(height: 35),
                  _title20width("Your top artists (last 6 months)"),
                  SizedBox(height: 25),
                  _slideArtists(),
                  SizedBox(height: 25),
                  _title20width("Show you might like"),
                  SizedBox(height: 25),
                  _slide( _slidePodcastItem() ),
                  SizedBox(height: 35),
                  _title20width("Uniquely yours"),
                  SizedBox(height: 25),
                  _slide( _slideYoursItem() ),
                  SizedBox(height: 35),
                  _title20width("Recently played"),
                  SizedBox(height: 25),
                  _slide( _slideRecentlyItem() ),
                
                ]
              ),
            ),
          ),
    
        ]
      ),
    );
  }

  Container _slideArtists() {
    return Container(
      height: 210,
      child: StreamBuilder(
        stream: topBloc.topArtists,
        builder: (BuildContext context, AsyncSnapshot<TopArtistsResponse> snapshot) {
          
          if (snapshot.hasData) 
            return ListView.builder(
              itemCount: snapshot.data!.items.length,
              physics: BouncingScrollPhysics(),
              scrollDirection: Axis.horizontal,
              itemBuilder: (BuildContext context, int index) {
              return _slideArtistItem(snapshot.data!.items[index]);
             },
            );
          else if (snapshot.hasError) {
            return Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.symmetric( horizontal: 20 ),
              child: Text( 
                "There has been an error. e: ${snapshot.error}", 
                style: TextStyle(color: Colors.white), 
              )
            );
          }

          return Center( child: CircularProgressIndicator( color: AppColors.spotifyGreen ) );
        },
      ),
    );
  }

  Container _slide( Container item ) {
    return Container(
      child: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        child: Row(
          children: [
            
            SizedBox(width: 20),
            item,
            SizedBox(width: 20),
            item,
            SizedBox(width: 20),
            item,
            SizedBox(width: 20),
            item,
            SizedBox(width: 20),
      
          ],
        ),
      ),
    );
  }

  Container _slideRecentlyItem() {
    return Container(
      width: 110,
      height: 160,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [

          ClipRRect(
            borderRadius: BorderRadius.circular(0),
            child: Image(
              image: AssetImage("assets/no-image.jpg"),
              height: 110,
              width: 110,
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(height: 10),
          Text(
            "Liked songs",
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w900,
              fontSize: 13
            ),
          ),
          
        ]
      ),
    );
  }

  Container _slideArtistItem(Artists response) {
    return Container(
      width: 155,
      height: 210,
      margin: const EdgeInsets.only( left: 20 ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [

          ClipRRect(
            borderRadius: BorderRadius.circular(0),
            child: (response.images.length > 0)
              ? Image(
                  image: NetworkImage(response.images[0].url),
                  height: 155,
                  width: 155,
                  fit: BoxFit.cover,
                )
              : Image(
                  image: AssetImage("assets/spotify/no-artist.png"),
                  height: 155,
                  width: 155,
                  fit: BoxFit.cover,
                )
          ),
          SizedBox( height: 10 ),
          Text(
            "${response.name}",
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w600,
              fontSize: 15
            ),
          ),
          
        ]
      ),
    );
  }

  Container _slideYoursItem() {
    return Container(
      width: 155,
      height: 210,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [

          ClipRRect(
            borderRadius: BorderRadius.circular(0),
            child: Image(
              image: AssetImage("assets/no-image.jpg"),
              height: 155,
              width: 155,
              fit: BoxFit.cover,
            ),
          ),
          Text(
            "We made you a personalized playlist with nice songs",
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              color: AppColors.spotifyGreyLighter,
              fontWeight: FontWeight.w600,
              fontSize: 13
            ),
          ),
          Container()
          
        ]
      ),
    );
  }

  Container _slidePodcastItem() {
    return Container(
      width: 155,
      height: 225,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [

          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image(
              image: AssetImage("assets/no-image.jpg"),
              height: 155,
              width: 155,
              fit: BoxFit.cover,
            ),
          ),
          Container(),
          Text(
            "Education",
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              color: AppColors.spotifyGreen,
              fontWeight: FontWeight.w600,
              fontSize: 11
            ),
          ),
          Text(
            "Psicologia Oscura",
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w900,
              fontSize: 13
            ),
          ),
          Text(
            "Show * Mauricio Salazar",
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              color: AppColors.spotifyGreyLighter,
              fontWeight: FontWeight.w600,
              fontSize: 13
            ),
          ),
          
        ]
      ),
    );
  }

  Column _rowsAndColumn( Size size ){
    return Column(
      children: [

        Row(
          children: [
            _horizontal(size),
            SizedBox( width: 10 ),
            _horizontal(size),
          ]
        ),
        SizedBox( height: 10 ),
        Row(
          children: [
            _horizontal(size),
            SizedBox( width: 10 ),
            _horizontal(size),
          ]
        ),
        SizedBox( height: 10 ),
        Row(
          children: [
            _horizontal(size),
            SizedBox( width: 10 ),
            _horizontal(size),
          ]
        ),

      ]
    );
  }

  Container _horizontal(Size size) {
    return Container(
      width: (size.width / 2) - 25,
      height: 55,
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.only( 
              topLeft: Radius.circular(4),
              bottomLeft: Radius.circular(4),
            ),
            child: Image(
              image: AssetImage("assets/no-image.jpg"),
              height: 55,
              width: 55,
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(width: 6),
          Container(
            width: (size.width / 2) - 25 - 55 - 12,
            alignment: Alignment.center,
            child: Text(
              "Dolore ipsum ea enim do consequat enim.",
              style: TextStyle(
                fontSize: 13.5,
                color: Colors.white,
                fontWeight: FontWeight.w600
              ),
              overflow: TextOverflow.ellipsis,
              maxLines: 2,
            ),
          )
        ],
      ),
      decoration: BoxDecoration(
        color: AppColors.spotifyGreyDarker,
        borderRadius: BorderRadius.circular(4)
      ),
    );
  }
}