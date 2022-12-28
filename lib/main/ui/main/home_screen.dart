import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sirio_portfolio/main/common_widgets/fat_button.dart';

import 'settings/settings_screen.dart';

class HomeScreen extends StatefulWidget {

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _stackIndex = 0;

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      bottomNavigationBar: _navBar(),

      body: Container(
        width: double.infinity,
        height: double.infinity,
        // padding: EdgeInsets.fromLTRB(5, 20, 5, 20),
        padding: EdgeInsets.all(0),
        child: SafeArea(
          child: IndexedStack(
            index: _stackIndex,
            children: [

              _homePage(context),
              SettingsScreen(),
              // _aboutPage(),

            ]
          ),
        )
      ),
   );
  }

  // Container _aboutPage() {

  //   return Container(
  //     width: double.infinity,
  //     height: double.infinity,
  //     child: Column(
  //       crossAxisAlignment: CrossAxisAlignment.start,
  //       children: [

  //         Container(
  //           alignment: Alignment.center,
  //           padding: const EdgeInsets.fromLTRB(20, 30, 20, 20),
  //           child: Text("Portfolio App",
  //             style: TextStyle(fontSize: 32),
  //           ),
  //         ),
  //         Divider(),
  //         SizedBox(height: 10),
  //         Padding(
  //           padding: const EdgeInsets.symmetric(horizontal: 20),
  //           child: Text("First three apps",
  //             style: TextStyle(fontSize: 16, fontWeight: FontWeight.w900),
  //             textAlign: TextAlign.justify,
  //           ),
  //         ),
  //         SizedBox(height: 5),
  //         Padding(
  //           padding: const EdgeInsets.symmetric(horizontal: 20),
  //           child: Text("They only use Timer, and math calculations for bar weights.",
  //             style: TextStyle(fontSize: 16),
  //             textAlign: TextAlign.justify,
  //           ),
  //         ),
  //         SizedBox(height: 20),
  //         Padding(
  //           padding: const EdgeInsets.symmetric(horizontal: 20),
  //           child: Text("Now playing app",
  //             style: TextStyle(fontSize: 16, fontWeight: FontWeight.w900),
  //             textAlign: TextAlign.justify,
  //           ),
  //         ),
  //         SizedBox(height: 5),
  //         Padding(
  //           padding: const EdgeInsets.symmetric(horizontal: 20),
  //           child: Text("Uses TMDB API, multiple endpoints used.\nProvider as state management.",
  //             style: TextStyle(fontSize: 16),
  //             textAlign: TextAlign.justify,
  //           ),
  //         ),
  //         SizedBox(height: 20),
  //         Padding(
  //           padding: const EdgeInsets.symmetric(horizontal: 20),
  //           child: Text("Spotify",
  //             style: TextStyle(fontSize: 16, fontWeight: FontWeight.w900),
  //             textAlign: TextAlign.justify,
  //           ),
  //         ),
  //         SizedBox(height: 5),
  //         Padding(
  //           padding: const EdgeInsets.symmetric(horizontal: 20),
  //           child: Text("Uses Spotify API, user authentication with " +
  //             "OAuth 2.0, multiple endpoints used, shared prefs used, most songs have a preview " +
  //             "which can be reproduced. Also, there are intents to open Spotify App.\n" +
  //             "Design almost the same as Official Spotify App.\n" +
  //             "Bloc as state management and Streams for data from providers.",
  //             style: TextStyle(fontSize: 16),
  //             textAlign: TextAlign.justify,
  //           ),
  //         ),
  //         SizedBox(height: 20),
  //         Padding(
  //           padding: const EdgeInsets.symmetric(horizontal: 20),
  //           child: Text("Settings",
  //             style: TextStyle(fontSize: 16, fontWeight: FontWeight.w900),
  //             textAlign: TextAlign.justify,
  //           ),
  //         ),
  //         SizedBox(height: 5),
  //         Padding(
  //           padding: const EdgeInsets.symmetric(horizontal: 20),
  //           child: Text("Cubits and Shared Prefs used for Light/Dark modes.",
  //             style: TextStyle(fontSize: 16),
  //             textAlign: TextAlign.justify,
  //           ),
  //         ),
  //         Spacer(flex: 2),
  //         Padding(
  //           padding: const EdgeInsets.symmetric(horizontal: 20),
  //           child: Text("Repository on BitBucket, might move it to GitHub.",
  //             style: TextStyle(fontSize: 16),
  //             textAlign: TextAlign.justify,
  //           ),
  //         ),
  //         Spacer(flex: 1),
  //         Row(
  //           mainAxisAlignment: MainAxisAlignment.center,
  //           children: [

  //             Text( "Made with",
  //               style: TextStyle( fontSize: 24 ),
  //             ),
  //             SizedBox(width: 10),
  //             FlutterLogo(
  //               style: FlutterLogoStyle.horizontal,
  //               size: 100,
  //               textColor: Color(0xff115599),
  //             ),
  //           ]
  //         ),

  //       ],
  //     ),
  //   );
  // }

  Theme _navBar() {

    return Theme(
      data: Theme.of(context).copyWith(
        canvasColor: Theme.of(context).canvasColor,
      ),
      child: BottomNavigationBar(
        backgroundColor: Colors.red,
        type: BottomNavigationBarType.shifting,
        currentIndex: _stackIndex,
        onTap: (i) {
          _stackIndex = i;
          setState(() {});
        },
        elevation: 0.0,
        items: [
          
          BottomNavigationBarItem(
            icon: Icon( FontAwesomeIcons.house ),
            tooltip: "Boton de inicio",
            label: "Inicio"
          ),

          BottomNavigationBarItem(
            icon: Icon( FontAwesomeIcons.gear ),
            tooltip: "Boton de configuración",
            label: "Configuración"
          ),

          // BottomNavigationBarItem(
          //   icon: Icon( FontAwesomeIcons.bookOpen ),
          //   tooltip: "About button",
          //   label: "About"
          // ),

        ],
      ),
    );
  }

  SingleChildScrollView _homePage(BuildContext context) {

    return SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: BounceInLeft(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(5, 20, 5, 20),
              child: Column(
                children: _buttons(context),
              ),
            ),
          ),
        );
  }

  List<Widget> _buttons( BuildContext context ) {

    return [
      FatButton(
        texto: "Armar barra",
        icon: FontAwesomeIcons.calculator,
        color1: Color(0xff525252),
        color2: Color(0xff3d72b4),
        onPress: () => Navigator.pushNamed(context, '/barbellcalculator')
      ),
      FatButton(
        texto: "Porcentajes",
        icon: FontAwesomeIcons.percent,
        color1: Color(0xff28313B),
        color2: Color(0xff485461),
        onPress: () => Navigator.pushNamed(context, '/rmpercentages')
      )
    ];
  }
}