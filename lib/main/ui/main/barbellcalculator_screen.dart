import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../core/bar_weight_cubit.dart';

class BarbellCalculatorScreen extends StatefulWidget {
  @override
  _BarbellCalculatorScreenState createState() =>
      _BarbellCalculatorScreenState();
}

class _BarbellCalculatorScreenState extends State<BarbellCalculatorScreen> {
  List<Widget> _platesOnBar = [];

  int _platesWidth = 0;
  bool _barWithPlates = false;
  var title = "Armar barra";
  var _barWeight = 45;
  var _esBarraDe35 = false;
  var _primeraCarga = false;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return BlocBuilder<BarWeightCubit, bool>(
      builder: (context, state) {
        _esBarraDe35 = state;
        if (!_primeraCarga) {
          _barWeight = (_esBarraDe35) ? 35 : 45;
          _primeraCarga = true;
        }
        return Scaffold(
          appBar: AppBar(
            title: (_esBarraDe35)
              ? Text(_barWithPlates
                ? "${_barWeight}lb | ${((_barWeight - 35) / 2).toStringAsFixed(0)} cada lado"
                : title)
              : Text(_barWithPlates
                ? "${_barWeight}lb | ${((_barWeight - 45) / 2).toStringAsFixed(0)} cada lado"
                : title),
            // title: Text( _barWithPlates ? "lbs   |   ${(_barWeight * 0.453592).toStringAsFixed(1)}kgs" : title ),
            centerTitle: true,
          ),
          floatingActionButton: _fab(),
          body: Container(
            height: double.infinity,
            width: double.infinity,
            padding: EdgeInsets.all(0),
            alignment: Alignment.topCenter,
            child: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Column(
                children: [
                  _sizedBox(),
                  Stack(
                    alignment: Alignment.center,
                    children: [
                      Image(image: AssetImage("assets/bar2.png"), height: 150),
                      Container(
                        padding: EdgeInsets.only(left: size.width / 3 + 2),
                        height: 260,
                        child: Row(
                          children: _platesOnBar,
                        ),
                      )
                    ],
                  ),
                  _sizedBox(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _plateBox(img: "05lb", size: size, text: "2 x 05lb"),
                      _plateBox(img: "10lb", size: size, text: "2 x 10lb"),
                      _plateBox(img: "15lb", size: size, text: "2 x 15lb"),
                    ],
                  ),
                  _sizedBox(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _plateBox(img: "25lb", size: size, text: "2 x 25lb"),
                      _plateBox(img: "35lb", size: size, text: "2 x 35lb"),
                      _plateBox(img: "45lb", size: size, text: "2 x 45lb"),
                    ],
                  ),
                  _sizedBox(),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  SizedBox _sizedBox() => SizedBox(height: 25);

  FloatingActionButton _fab() {
    return FloatingActionButton(
      child: Icon(FontAwesomeIcons.trash),
      onPressed: () {
        _barWeight = (_esBarraDe35) ? 35 : 45;
        _barWithPlates = false;
        _platesOnBar = [];

        _platesWidth = 0;
        Fluttertoast.cancel();
        setState(() {});
      },
    );
  }

  Widget _plateBox(
      {required Size size, required String img, required String text}) {
    int _onePlateWidth = 0;
    int _twoPlateWeight = 0;
    int _tempWidth = 0;

    //* Pixels of each image
    //* 38 52 57 107 127 142
    switch (img) {
      case "05lb":
        _onePlateWidth = 38;
        _twoPlateWeight = 10;
        break;

      case "10lb":
        _onePlateWidth = 52;
        _twoPlateWeight = 20;
        break;

      case "15lb":
        _onePlateWidth = 57;
        _twoPlateWeight = 30;
        break;

      case "25lb":
        _onePlateWidth = 107;
        _twoPlateWeight = 50;
        break;

      case "35lb":
        _onePlateWidth = 127;
        _twoPlateWeight = 70;
        break;

      case "45lb":
        _onePlateWidth = 142;
        _twoPlateWeight = 90;
        break;
    }

    return GestureDetector(
      onTap: () {
        _tempWidth = _platesWidth + _onePlateWidth;

        if (_tempWidth <= 741) {
          _barWithPlates = true;
          _barWeight += _twoPlateWeight;

          _platesOnBar.add(SlideInRight(
              child: (img == "05lb")
                  ? Image(image: AssetImage("assets/$img.png"), height: 180)
                  : Image(image: AssetImage("assets/$img.png"), height: 260)));

          _platesWidth += _onePlateWidth;
          setState(() {});
        } else {
          Fluttertoast.showToast(
              msg: "Alto! Ya no caben más",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.red,
              textColor: Colors.white,
              fontSize: 16.06);
        }
      },
      child: Container(
        width: size.width * 0.30,
        height: size.width * 0.35,
        decoration: BoxDecoration(
            color: Color(0xff222222), borderRadius: BorderRadius.circular(15)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Image(
                image: AssetImage("assets/${img}2.png"),
                height: size.width * 0.25),
            Text(text,
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white))
          ],
        ),
      ),
    );
  }
}
