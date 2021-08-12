import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sirio_portfolio/main/common_widgets/fat_button.dart';
import 'package:sirio_portfolio/main/core/theme.dart';

import 'settings/settings_screen.dart';

class HomeScreen extends StatefulWidget {

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _stackIndex = 1;

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

              SettingsScreen(),
              _homePage(context),
              Container(
                color: Colors.blue,
                width: double.infinity,
                height: double.infinity,
              ),

            ]
          ),
        )
      ),
   );
  }

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
            icon: Icon( FontAwesomeIcons.cog ),
            tooltip: "Settings button",
            label: "Settings"
          ),
          
          BottomNavigationBarItem(
            icon: Icon( FontAwesomeIcons.home ),
            tooltip: "Home button",
            label: "Home"
          ),

          BottomNavigationBarItem(
            icon: Icon( FontAwesomeIcons.bookOpen ),
            tooltip: "About button",
            label: "About"
          ),

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
        texto: "Rounds counter",
        icon: FontAwesomeIcons.tasks,
        color1: Color(0xff2c3e50),
        color2: Color(0xff3498db),
        onPress: () => Navigator.pushNamed(context, '/roundcounter')
      ),
      FatButton(
        texto: "Barbell calculator",
        icon: FontAwesomeIcons.calculator,
        color1: Color(0xff525252),
        color2: Color(0xff3d72b4),
        onPress: () => Navigator.pushNamed(context, '/barbellcalculator')
      ),
      FatButton(
        texto: "RM percentages",
        icon: FontAwesomeIcons.percentage,
        color1: Color(0xff28313B),
        color2: Color(0xff485461),
        onPress: () => Navigator.pushNamed(context, '/rmpercentages')
      ),
      FatButton(
        texto: "Now playing",
        icon: FontAwesomeIcons.film,
        color1: Color(0xff000000),
        color2: Color(0xff801434),
        onPress: () {
          Navigator.pushNamed(context, '/tmdb_home');
        }
      ),
      FatButton(
        texto: "Spotify API",
        icon: FontAwesomeIcons.spotify,
        color1: AppColors.spotifyBlack,
        color2: AppColors.spotifyGreen,
        onPress: () {
          Navigator.pushNamed(context, '/spotify_splash');
        }
      ),
    ];
  }
}