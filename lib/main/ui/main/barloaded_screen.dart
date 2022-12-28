import 'package:flutter/material.dart';


class BarLoadedScreen extends StatefulWidget {

  final int percentage;
  final double weight;
  final double barWeight;

  BarLoadedScreen({required this.percentage, required this.weight, required this.barWeight});

  @override
  _BarLoadedScreenState createState() => _BarLoadedScreenState();
}

class _BarLoadedScreenState extends State<BarLoadedScreen> {

  List<double> _plates = [];
  List<Widget> _platesOnBar = [];
  List<String> _platesOnBarText = [];

  double _weightOnBar = 0;
  double _weightLeft = 0;

  final TextStyle _whiteTitle = TextStyle(
    color: Color(0xffd2d2d2),
    fontSize: 30,
    fontWeight: FontWeight.w400
  ); 

  final TextStyle _blackText = TextStyle(
    color: Color(0xff222222),
    fontSize: 28,
    fontWeight: FontWeight.w300
  ); 
  
  final TextStyle _blackNumber = TextStyle(
    color: Color(0xff222222),
    fontSize: 28,
  ); 

  final TextStyle _listaText = TextStyle(
    color: Colors.red[800],
    fontSize: 23,
    fontWeight: FontWeight.w300
  ); 

  @override
  void initState() { 
    _barSetting();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    final size = MediaQuery.of(context).size;
    
    return Scaffold(
      body: SafeArea(
        child: Container(
          color: Colors.white,
          width: double.infinity,
          height: double.infinity,
          padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
          child: SingleChildScrollView(
            child: Column(
              children: [
          
                Container(
                  width: double.infinity,
                  height: 80,
                  alignment: Alignment.center,
                  color: Color(0xff222222),
                  child: Text( "${widget.percentage}% - ${widget.weight.toStringAsFixed(2)} lb", style: _whiteTitle ),
                ),
                _sizedBox(),
                Container(
                  padding: EdgeInsets.only( left: 15, right: 15 ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
          
                      Row(
                        children: [
                          Text( "Peso en barra: ", style: _blackText ),
                          Text( "${_weightOnBar.floor()} lb", style: _blackNumber ),
                        ]
                      ),
                      ( _weightLeft != 0.0 )
                        ? Row(
                          children: [
                            Text( "Peso sobrante: ", style: _blackText ),
                            Text( "${_weightLeft.toStringAsFixed(2)} lb", style: _blackNumber ),
                          ]
                        )
                        : Container(),
          
                    ]
                  ),
                ),
                
                _sizedBox(),
                Stack(
                  alignment: Alignment.center,
                  children: [
          
                    Image(image: AssetImage("assets/bar2.png"), height: 150 ),
                    Container(
                      padding: EdgeInsets.only( left: size.width / 3 + 2 ),
                      height: 260,
                      child: Row(
                        children: _platesOnBar
                      ),
                    ),
                    
                  ],
                ),

                _sizedBox(),
                for(var texto in _platesOnBarText ) Text(texto, style: _listaText),

                _sizedBox(),
                _sizedBox(),
                _sizedBox(),

                (_weightLeft > 5.0) 
                ?
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text("*Si el peso sobrante es mas de 5lb, puedes agregar par de discos de 2.5lb", style: TextStyle(fontSize: 18)),
                  )
                : Container(),

                _sizedBox(),
                _sizedBox(),
          
              ]
            ),
          ),
        ),
      ),
    );
  }

  SizedBox _sizedBox() => SizedBox( height: 25 );

  void _barSetting() {

    _platesOnBar = [];
    _platesOnBarText = [];
    _weightOnBar = 0;
    _weightLeft = 0;

    double _restante;
    double _valorDivision;
    int i;

    _restante = ( widget.weight - widget.barWeight ) / 2; 
    print( _restante );

    if ( _restante != 0 ) {
      _valorDivision = (_restante / 45).truncateToDouble();
      for ( i = 0; i < _valorDivision; i++ ){
        _plates.add(45);
        _platesOnBar.add( Image(image: AssetImage("assets/45lb.png"), height: 260 ) );
        _platesOnBarText.add( "2x45lb" );
        _restante -= 45;
      }
    }

    if ( _restante != 0 ) {
      _valorDivision = (_restante / 35).truncateToDouble();
      for ( i = 0; i < _valorDivision; i++ ){
        _plates.add(35);
        _platesOnBar.add( Image(image: AssetImage("assets/35lb.png"), height: 260 ) );
        _platesOnBarText.add( "2x35lb" );
        _restante -= 35;
      }
    }

    if ( _restante != 0 ) {
      _valorDivision = (_restante / 25).truncateToDouble();
      for ( i = 0; i < _valorDivision; i++ ){
        _plates.add(25);
        _platesOnBar.add( Image(image: AssetImage("assets/25lb.png"), height: 260 ) );
        _platesOnBarText.add( "2x25lb" );
        _restante -= 25;
      }
    }

    if ( _restante != 0 ) {
      _valorDivision = (_restante / 15).truncateToDouble();
      for ( i = 0; i < _valorDivision; i++ ){
        _plates.add(15);
        _platesOnBar.add( Image(image: AssetImage("assets/15lb.png"), height: 260 ) );
        _platesOnBarText.add( "2x15lb" );
        _restante -= 15;
      }
    }

    if ( _restante != 0 ) {
      _valorDivision = (_restante / 10).truncateToDouble();
      for ( i = 0; i < _valorDivision; i++ ){
        _plates.add(10);
        _platesOnBar.add( Image(image: AssetImage("assets/10lb.png"), height: 260 ) );
        _platesOnBarText.add( "2x10lb" );
        _restante -= 10;
      }
    }

    if ( _restante != 0 ) {
      _valorDivision = (_restante / 5).truncateToDouble();
      for ( i = 0; i < _valorDivision; i++ ){
        _plates.add(5);
        _platesOnBar.add( Image(image: AssetImage("assets/05lb.png"), height: 180 ) );
        _platesOnBarText.add( "2x5lb" );
        _restante -= 5;
      }
    }

    _weightOnBar = widget.weight - _restante * 2;
    if( _restante != 0 )
      _weightLeft = _restante * 2;

  }
}