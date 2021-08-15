import 'package:flutter/material.dart';
import 'package:sirio_portfolio/main/core/theme.dart';
import 'package:sirio_portfolio/main/spotify/blocs/playlist_bloc.dart';
import 'package:sirio_portfolio/main/spotify/models/playlist_list_response.dart';


class SpotifyLibraryScreen extends StatefulWidget {

  @override
  _SpotifyLibraryScreenState createState() => _SpotifyLibraryScreenState();
}

class _SpotifyLibraryScreenState extends State<SpotifyLibraryScreen> {
  final _titleStyle = TextStyle(
    color: Colors.white,
    fontWeight: FontWeight.w900,
    fontSize: 23,
  );

  final _titlePlaylist = TextStyle(
    color: Colors.white,
    fontWeight: FontWeight.w900,
    fontSize: 16,
  );

  final _subtitlePlaylist = TextStyle(
    color: AppColors.spotifyGreyLighter,
    fontWeight: FontWeight.w500,
    fontSize: 13,
  );

  @override
  void initState() {
    super.initState();
    playlistBloc.fetchPlaylistList();
  }

  @override
  Widget build(BuildContext context) {

    final Size size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: AppColors.spotifyBlack,
      body: _body(size, context),
   );
  }

  SafeArea _body(Size size, BuildContext context) {
    return SafeArea(
      bottom: false,
      child: Stack(
        children: [

          StreamBuilder(
            stream: playlistBloc.playlistList,
            builder: (context, AsyncSnapshot<PlaylistListResponse> snapshot) {
              
              if (snapshot.hasData) 
                return _listView(snapshot.data!);
              else if (snapshot.hasError) {
                return Container(
                  alignment: Alignment.center,
                  padding: const EdgeInsets.symmetric( horizontal: 20 ),
                  child: Text( "There has been an error. e: ${snapshot.error}" )
                );
              }

              return Center( child: CircularProgressIndicator( color: AppColors.spotifyGreen ) );
            }
          ),
          _appBar(context),
        
        ]
      ),
    );
  }

  ListView _listView(PlaylistListResponse list) {
    return ListView.builder(
      physics: BouncingScrollPhysics(),
      itemCount: list.items.length,
      padding: EdgeInsets.only( top: 120, bottom: 70 ),
      itemBuilder: ( context, int index ) {
    
        return GestureDetector(
          onTap: (){
            // print(list.items[index].tracks.href);
            Navigator.pushNamed(context, "/spotify_playlist");
          },
          child: _playlistItem(list, index)
        );
      },
    );
  }

  Container _playlistItem(PlaylistListResponse list, int index) {
    return Container(
      width: double.infinity,
      height: 65,
      margin: const EdgeInsets.only( top: 15 ),
      padding: const EdgeInsets.only( left: 20),
      child: Row(
        children: [
          
          Image(
            image: NetworkImage(
              list.items[index].images.length > 0
                ? list.items[index].images[0].url
                : "https://st4.depositphotos.com/14953852/22772/v/600/depositphotos_227725020-stock-illustration-no-image-available-icon-flat.jpg"
            ),
            height: 65,
            width: 65,
            fit: BoxFit.cover,
          ),
          SizedBox(width: 20),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                
                Text(
                  "${list.items[index].name}", 
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: _titlePlaylist
                ),
                SizedBox(height: 5),
                Text(
                  ( list.items[index].type == "playlist" ) 
                    ? "Playlist • ${list.items[index].owner.displayName}"
                    : "${list.items[index].type} • ${list.items[index].owner.displayName}", 
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: _subtitlePlaylist
                ),
          
              ]
            ),
          )

        ]
      ),
    );
  }

  Container _appBar(BuildContext context) {
    return Container(
      height: 120,
      padding: const EdgeInsets.fromLTRB(20, 30, 20, 0),
      alignment: Alignment.topCenter,
      decoration: BoxDecoration(
        color: AppColors.spotifyBlack,
        boxShadow: [
          BoxShadow(
            color: Colors.black87,
            blurRadius: 2.5,
            spreadRadius: 1.0,
            offset: Offset( 0, 1.0 )
          )
        ]
      ),
      child: Row(
        children: [
          
          GestureDetector(
            onTap: () => Navigator.pushNamed(context, "/spotify_profile"),
            child: Container(
              height: 35,
              width: 35,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(50),
                child: Image(
                  image: AssetImage("assets/no-image.jpg"),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          SizedBox(width: 15),
          Text( "Your Library", style: _titleStyle ),
          Spacer(),
          Icon( Icons.search, size: 32 ),
          SizedBox(width: 20),
          Icon( Icons.add, size: 32 )

        ],
      ),
    );
  }
}