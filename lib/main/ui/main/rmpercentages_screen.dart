import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../core/bar_weight_cubit.dart';
import 'barloaded_screen.dart';

class RMPercentagesScreen extends StatefulWidget {
  @override
  _RMPercentagesScreenState createState() => _RMPercentagesScreenState();
}

class _RMPercentagesScreenState extends State<RMPercentagesScreen> {
  TextEditingController _rmTextField = TextEditingController();
  Map<int, double> _percentages = {
    130: 0.0,
    120: 0.0,
    110: 0.0,
    100: 0.0,
    95: 0.0,
    90: 0.0,
    85: 0.0,
    80: 0.0,
    75: 0.0,
    70: 0.0,
  };

  bool _pressed = false;
  var _esBarraDe35 = false;
  var _barWeight = 45.0;
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
          backgroundColor: Colors.white,
          appBar: AppBar(
            title: Text("Porcentajes"),
            centerTitle: true,
          ),
          floatingActionButton: _fab(),
          body: SafeArea(
            child: Container(
              width: double.infinity,
              height: double.infinity,
              padding: EdgeInsets.all(0),
              child: SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 20, vertical: 30),
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Peso:',
                                style: TextStyle(
                                    fontSize: 26, color: Colors.grey[900]),
                              ),
                              _textField(),
                              _sizedBox(),
                              _button(),
                              _sizedBox(),
                              ..._percentages.entries.map((e) => (_pressed)
                                  ? _onePercentage(e, size)
                                  : Container()),
                            ]),
                      ),
                    ]),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _onePercentage(MapEntry<int, double> e, Size size) {
    return GestureDetector(
      onTap: () {
        if (e.value < _barWeight) {
          Fluttertoast.showToast(
              msg: (_esBarraDe35) 
                  ? "Lo siento, nada por debajo de 35 libras"
                  : "Lo siento, nada por debajo de 45 libras",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.red,
              textColor: Colors.white,
              fontSize: 16.06);
        } else if (e.value > 495.0) {
          Fluttertoast.showToast(
              msg: "Limite superado",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.red,
              textColor: Colors.white,
              fontSize: 16.06);
        } else {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      BarLoadedScreen(
                        percentage: e.key, 
                        weight: e.value,
                        barWeight: _barWeight)));
        }
      },
      child: Container(
        width: double.infinity,
        height: 80,
        margin: EdgeInsets.only(bottom: 10),
        decoration: BoxDecoration(
            color: Color(0xff222222), borderRadius: BorderRadius.circular(15)),
        child: Row(
          children: [
            Container(
                width: 80,
                height: 80,
                alignment: Alignment.center,
                margin: EdgeInsets.only(right: 20),
                decoration: BoxDecoration(
                    color: Color(0xffd2d2d2),
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(15),
                        bottomLeft: Radius.circular(15))),
                child: Text("${e.key}%",
                    style: TextStyle(
                        color: Color(0xff222222),
                        fontWeight: FontWeight.bold,
                        fontSize: 20))),
            Text("${e.value.toStringAsFixed(2)} lbs",
                style: TextStyle(color: Color(0xffd2d2d2), fontSize: 20)),
            Spacer(),
            Icon(FontAwesomeIcons.dumbbell),
            SizedBox(width: 30)
          ],
        ),
      ),
    );
  }

  FloatingActionButton _fab() {
    return FloatingActionButton(
      child: Icon(FontAwesomeIcons.trash),
      onPressed: () {
        _pressed = false;
        _rmTextField.clear();

        setState(() {});
      },
    );
  }

  TextField _textField() {
    return TextField(
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
            enabledBorder: UnderlineInputBorder(),
            focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Color(0xff088a08)))),
        style: TextStyle(
          color: Colors.black,
          decorationColor: Colors.black,
        ),
        controller: _rmTextField);
  }

  TextButton _button() {
    return TextButton(
        style: ButtonStyle(
            foregroundColor: MaterialStateProperty.all(Colors.white),
            textStyle: MaterialStateProperty.all(TextStyle(fontSize: 22))),
        onPressed: () {
          double _rmWeight = 0.0;
          _pressed = false;

          if (_rmTextField.text.isNotEmpty)
            _rmWeight = double.parse(_rmTextField.text);

          if (_rmWeight < _barWeight) {
            Fluttertoast.showToast(
                msg: (_esBarraDe35) 
                  ? "Deben ser al menos 35 libras"
                  : "Deben ser al menos 45 libras",
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.BOTTOM,
                timeInSecForIosWeb: 1,
                backgroundColor: Colors.red,
                textColor: Colors.white,
                fontSize: 16.06);
          }
          if (_rmWeight <= 495.0 && _rmWeight >= 45.0) {
            _pressed = true;

            _percentages.update(130, (value) => (_rmWeight * 1.3));
            _percentages.update(120, (value) => (_rmWeight * 1.2));
            _percentages.update(110, (value) => (_rmWeight * 1.1));
            _percentages.update(100, (value) => (_rmWeight * 1.0));
            _percentages.update(95, (value) => (_rmWeight * 0.95));
            _percentages.update(90, (value) => (_rmWeight * 0.9));
            _percentages.update(85, (value) => (_rmWeight * 0.85));
            _percentages.update(80, (value) => (_rmWeight * 0.8));
            _percentages.update(75, (value) => (_rmWeight * 0.75));
            _percentages.update(70, (value) => (_rmWeight * 0.7));

            setState(() {});
          }
          if (_rmWeight > 495.0) {
            Fluttertoast.showToast(
                msg: "Limite superado",
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.BOTTOM,
                timeInSecForIosWeb: 1,
                backgroundColor: Colors.red,
                textColor: Colors.white,
                fontSize: 16.06);
          }
          FocusScope.of(context).unfocus();
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0),
          child: Text("Calcular"),
        ));
  }

  SizedBox _sizedBox() => SizedBox(height: 25);
}
