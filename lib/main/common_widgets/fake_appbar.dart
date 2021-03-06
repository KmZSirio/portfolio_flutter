import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sirio_portfolio/main/core/theme.dart';

Row fakeAppBar({
  required BuildContext context,
  required Size size,
  required String text,
  bool showButton = true,
  bool buttonBorder = true }) {

    return Row(
      children: [

        ( showButton ) 
          ? GestureDetector(
            onTap: () => Navigator.pop(context),
            child: Container(
              width: size.width / 9,
              height: size.width / 9,
              child: Icon( FontAwesomeIcons.chevronLeft, color: Theme.of(context).buttonColor ),
              decoration: BoxDecoration(
                color: AppColors.trans,
                borderRadius: BorderRadius.circular(10),
                border: (showButton == true && buttonBorder == true)
                  ? Border.all( color: Theme.of(context).buttonColor, width: 1.5 )
                  : Border.all( color: AppColors.trans, width: 1.5 )
              ),
            ),
          ) 
          : Container(),
        SizedBox( width: size.width / 18 ),
        Text( text, style: Theme.of(context).textTheme.headline4 )

      ],
    );
}