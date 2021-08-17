import 'package:android_intent_plus/android_intent.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:device_apps/device_apps.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:platform/platform.dart';

import '../../core/const.dart';
import '../../core/theme.dart';
import '../blocs/playlist_bloc.dart';
import '../models/playlist_items_response.dart';
import '../models/playlist_list_response.dart';
import 'sabt_helper.dart';


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

  Playlist? _playlist;
  AudioPlayer audioPlayer = AudioPlayer();
  bool sound = false;

  // TODO Check out
  //! Problem openning playlist with podcast episodes!

  @override
  void initState() {
    super.initState();
    _playlist = null;
  }

  play( String url ) async {
    if (url != "") {
      int result = await audioPlayer.play(url);
      if (result == 1 )
        sound = true;
      else 
        showToast("Error, cannot reproduce");
    } else 
      showToast("Song unavailable");
  }

  void _launchApp(String url) async {
    // com.spotify.music
    String spotifyPackage = "com.spotify.music";
    bool installed = await DeviceApps.isAppInstalled(spotifyPackage);
    if (installed) {

      if (LocalPlatform().isAndroid) {
        AndroidIntent intent = AndroidIntent(
            action: 'action_view',
            data: '$url?'
                'id=$spotifyPackage',
        );
        await intent.launch();
      }

    } else {
      showToast("GET SPOTIFY FREE");
    }
  }

  showToast(String text) {
    Fluttertoast.showToast(
      msg: "$text",
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.SNACKBAR,
      timeInSecForIosWeb: 1,
      backgroundColor: AppColors.spotifyGreen,
      textColor: Colors.white,
      fontSize: 16.06
    );
  }

  @override
  Widget build(BuildContext context) {

    final Map arguments = ModalRoute.of(context)!.settings.arguments as Map;
    _playlist = arguments["playlist"] as Playlist;

    String endpoint = _playlist!.tracks.href.substring(23);
    playlistBloc.fetchPlaylistItems( apiUrlSpotify, endpoint);

    return StreamBuilder(
      stream: playlistBloc.playlistItems,
      builder: (BuildContext context, AsyncSnapshot<PlaylistItemsResponse> snapshot) {

        if(snapshot.hasData) {
          return Scaffold(
            backgroundColor: AppColors.spotifyBlack,
            body: CustomScrollView(
              physics: BouncingScrollPhysics(),
              slivers: [ sliverAppBar(_playlist!, snapshot.data!), _sliverList(snapshot.data!) ],
            ),
          );
        } else if (snapshot.hasError) {
          return Scaffold(
            backgroundColor: AppColors.spotifyBlack,
            body: Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.symmetric( horizontal: 20 ),
              child: Text( 
                "There has been an error. e: ${snapshot.error}", 
                style: TextStyle(color: Colors.white), 
              )
            ),
          );
        }

        return Center( child: CircularProgressIndicator( color: AppColors.spotifyGreen ) );
      },
    );
  }

  _sliverList(PlaylistItemsResponse playlist) {

    return  SliverList(
      delegate: SliverChildBuilderDelegate(
        (context, index) {

          return ListTile(
            leading: Image(
              image: NetworkImage(
              playlist.items[index].track.album.images.length > 0
                ? playlist.items[index].track.album.images[0].url
                : "https://st4.depositphotos.com/14953852/22772/v/600/depositphotos_227725020-stock-illustration-no-image-available-icon-flat.jpg"
              ),
              height: 55,
              width: 55,
              fit: BoxFit.cover,
            ),
            title: Text(
              "${playlist.items[index].track.name}", 
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: _titleTrack
            ),
            subtitle: Text(
              "${playlist.items[index].track.artists[0].name}", 
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: _subtitleTrack
            ),
            trailing: InkWell(
              child: Image(
                image: AssetImage("assets/spotify/icon_green.png"),
                height: 30,
                width: 30,
              ),
              onTap: () {
                _launchApp(playlist.items[index].track.externalUrls.spotify);
              },
            ),
            onTap: () async {
              play(playlist.items[index].track.previewUrl);
            },
          );
        },
        childCount: playlist.items.length,
      ),
    );
  }

  SliverAppBar sliverAppBar(Playlist _playlist, PlaylistItemsResponse playlist) {
    return SliverAppBar(
      pinned: true,
      floating: false,
      snap: false,
      expandedHeight: (_playlist.description == "") ? 350 : 400,
      backgroundColor: AppColors.spotifyBlueGrey,
      title: SABT(
        child: Text("${_playlist.name}", style: _titleAppBarPlaylist )
      ),
      flexibleSpace: _flexibleSpaceBar(_playlist, playlist)
    );
  }

  FlexibleSpaceBar _flexibleSpaceBar(Playlist playlistItem, PlaylistItemsResponse playlistTracks) {
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
                    image: NetworkImage(
                      playlistItem.images.length > 0
                        ? playlistItem.images[0].url
                        : "https://st4.depositphotos.com/14953852/22772/v/600/depositphotos_227725020-stock-illustration-no-image-available-icon-flat.jpg"
                      ),
                    height: 180,
                    width: 180,
                    fit: BoxFit.cover,
                  ),
                ),
                SizedBox( height: 30, width: double.infinity, ),
                Text(
                  "${playlistItem.name}",
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: _titlePlaylist,
                ),
                SizedBox( height: 20),
                (playlistItem.description == "") 
                  ? Container()
                  : Text(
                      "${playlistItem.description}",
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: _descriptionPlaylist,
                    ),
                SizedBox( height: (playlistItem.description == "") ? 0 : 15 ),
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
                      "${playlistItem.owner.displayName}",
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