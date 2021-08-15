import 'package:flutter/material.dart';

class SABT extends StatefulWidget {
  final Widget child;

  const SABT({ Key? key, required this.child }) : super(key: key);

  @override
  _SABTState createState() => _SABTState();
}

class _SABTState extends State<SABT> {
  //* https://medium.com/@eibaan_54644/reappearing-app-bar-titles-eff8b35f6826
  //* I have used this to only show title of sliverapp when collapsed

  ScrollPosition? _position;
  bool _visible = false;

  @override
  void dispose() {
    _removeListener();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _removeListener();
    _addListener();
  }
  
  void _addListener() {
    _position = Scrollable.of(context)?.position;
    _position?.addListener(_positionListener);
    _positionListener();
  }  

  void _removeListener() {
    _position?.removeListener(_positionListener);
  }

  void _positionListener() {

    final settings =
      context.dependOnInheritedWidgetOfExactType<FlexibleSpaceBarSettings>();
    bool visible = settings == null || settings.currentExtent <= settings.minExtent;

    if (_visible != visible) {
      setState(() {
        _visible = visible;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: _visible,
      child: widget.child
    );
  }
}