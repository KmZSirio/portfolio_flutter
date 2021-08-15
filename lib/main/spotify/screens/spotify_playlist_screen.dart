import 'dart:async';
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sirio_portfolio/main/core/theme.dart';
import 'package:sirio_portfolio/main/spotify/screens/sabt_helper.dart';


class SpotifyPlaylistScreen extends StatefulWidget {
  @override
  _SpotifyPlaylistScreenState createState() => _SpotifyPlaylistScreenState();
}

class _SpotifyPlaylistScreenState extends State<SpotifyPlaylistScreen> with SingleTickerProviderStateMixin {
  final _titleAppBarPlaylist = GoogleFonts.raleway(
    color: Colors.white,
    fontWeight: FontWeight.w800,
    fontSize: 16,
  );

  final _titlePlaylist = GoogleFonts.raleway(
    color: Colors.white,
    fontWeight: FontWeight.w800,
    fontSize: 21,
  );

  final _descriptionPlaylist = TextStyle(
    color: AppColors.spotifyGreyLighter,
    fontWeight: FontWeight.w500,
    fontSize: 14,
  );

  final _creatorPlaylist = TextStyle(
    color: Colors.white,
    fontWeight: FontWeight.w900,
    fontSize: 13,
  );

  final _titleTrack = TextStyle(
    color: Colors.white,
    fontWeight: FontWeight.w900,
    fontSize: 14,
  );

  final _subtitleTrack = TextStyle(
    color: AppColors.spotifyGreyLighter,
    fontWeight: FontWeight.w500,
    fontSize: 13,
  );

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: AppColors.spotifyBlack,
      body: CustomScrollView(
        physics: BouncingScrollPhysics(),
        slivers: [ sliverAppBar(), _sliverList() ],
      ),
   );
  }

  _sliverList() {

      return  SliverList(
        delegate: SliverChildBuilderDelegate(
          (context, index) {

            return ListTile(
              leading: Image(
                image: AssetImage("assets/no-image.jpg"),
                height: 55,
                width: 55,
                fit: BoxFit.cover,
              ),
              title: Text(
                "I Believe I'm Gonna Love You", 
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: _titleTrack
              ),
              subtitle: Text(
                "Frank Sinatra", 
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: _subtitleTrack
              ),
              trailing: IconButton(
                icon: Icon(Icons.more_vert, color: AppColors.spotifyGreyLighter),
                onPressed: () {},
              ),
              onTap: () {},
            );
          },
          childCount: 20,
        ),
      );
    }

  SliverAppBar sliverAppBar() {
    return SliverAppBar(
      pinned: true,
      floating: false,
      snap: false,
      expandedHeight: 400, //!!! ATTENTION
      backgroundColor: AppColors.spotifyBlueGrey,
      title: SABT(
        child: Text("The Very Best In The Whole Universe", style: _titleAppBarPlaylist )
      ),
      flexibleSpace: _flexibleSpaceBar()
    );
  }

  FlexibleSpaceBar _flexibleSpaceBar() {
    return FlexibleSpaceBar(
      collapseMode: CollapseMode.pin,
      centerTitle: true,
      // stretchModes: [StretchMode.fadeTitle],
      background: Stack(
        alignment: Alignment.center,
        children: [

          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.bottomCenter,
                end: Alignment.center,
                colors: <Color>[
                  AppColors.spotifyBlack,
                  Color(0x60000000),
                ],
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.fromLTRB(20, 40, 20, 0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                Align(
                  alignment: Alignment.center,
                  child: Image(
                    image: AssetImage("assets/no-image.jpg"),
                    height: 180,
                    width: 180,
                    fit: BoxFit.cover,
                  ),
                ),
                SizedBox( height: 30, width: double.infinity, ),
                Text(
                  "The Very Best In The Whole Universe",
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: _titlePlaylist,
                ),
                SizedBox( height: 20),
                Text(
                  "Huesca RAAZ DLTA STARS CSC TLG zG Busta nR ESL KmZ CtF FA",
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: _descriptionPlaylist,
                ),
                SizedBox( height: 15 ),
                Row(
                  children: [

                    Container(
                      height: 25,
                      width: 25,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(50),
                        child: Image(
                          image: AssetImage("assets/no-image.jpg"),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    SizedBox(width: 10),
                    Text( 
                      "Sirio Rodriguez",
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: _creatorPlaylist 
                    ),

                  ],
                )

              ]
            ),
          ),

        ],
      ),
    );
  }
}