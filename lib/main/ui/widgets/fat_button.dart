import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class FatButton extends StatelessWidget {

  final IconData icon;
  final String texto;
  final Color color1;
  final Color color2;
  final void Function() onPress;

  const FatButton({
    this.icon = FontAwesomeIcons.circle, 
    required this.texto, 
    this.color1 = Colors.blueGrey, 
    this.color2 = Colors.grey, 
    required this.onPress
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: this.onPress,
      child: Stack(
        children: [
          _FatButtonBackground(icon: this.icon, color1: this.color1, color2: this.color2),

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: 120.0, width: 40.0),
              FaIcon(this.icon, color: Colors.white, size: 40.0),
              SizedBox(width: 20.0),
              Expanded(child: Text(this.texto, style: TextStyle(color: Colors.white, fontSize: 18.0))),
              FaIcon(FontAwesomeIcons.chevronRight, color: Colors.white),
              SizedBox(width: 40.0),
            ],
          )
        ],
      ),
    );
  }

}

class _FatButtonBackground extends StatelessWidget {

  final IconData icon;
  final Color color1;
  final Color color2;

  const _FatButtonBackground({
    required this.icon, required this.color1, required this.color2
  });

  @override
  Widget build(BuildContext context) {
    return Container(

      child: ClipRRect(
        borderRadius: BorderRadius.circular(20.0),
        child: Stack(
          children: <Widget>[
            Positioned(
              right: -20,
              top: -28,
              child: FaIcon(this.icon, color: Colors.white.withOpacity(0.2), size: 150.0),
            )
          ],
        ),
      ),

      width: double.infinity,
      height: 100.0,
      margin: const EdgeInsets.fromLTRB(20, 10, 20, 0),
      decoration: BoxDecoration(
        boxShadow: <BoxShadow>[

          BoxShadow(color: Colors.black26, offset: Offset(4, 6), blurRadius: 10.0)
          
        ],
        borderRadius: BorderRadius.circular(15.0),
        gradient: LinearGradient(
          colors: <Color>[

            this.color1,
            this.color2,

          ]
        )
      ),
    );
  }

}