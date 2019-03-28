import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MainPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MainPageState();
  }
}

class _MainPageState extends State<MainPage> {
  String _assetLocation = 'images/moon.png';
  int _radioGroupVal = 0;
  final _formKey = GlobalKey<FormState>();
  final _controller = TextEditingController();
  final _focusNode = new FocusNode();
  var _gravities = {
    'Moon': 1.62,
    'Mars': 3.711,
    'Jupiter': 24.79,
    'Pluto': 0.62,
  }.entries.toList();
  @override
  Widget build(BuildContext context) {
    void update(String assetLocation, int _rgval) {
      setState(() {
        if (_controller.text.isNotEmpty) {
          _formKey.currentState.validate();
        }
        _focusNode.unfocus();
        _radioGroupVal = _rgval;
        _assetLocation = assetLocation;
      });
    }

    final _width = MediaQuery.of(context).size.width;
    final _height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: GestureDetector(
        onTap: () {
          _focusNode.unfocus();
        },
        child: Stack(
          children: <Widget>[
            BackgroundImage(),
            Positioned(
              top: 20,
              left: 0,
              right: 0,
              child: AppBar(
                title: Text(
                  'Calculate Your Weight',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 26,
                      letterSpacing: 3,
                      wordSpacing: 7,
                      fontWeight: FontWeight.w300),
                  textAlign: TextAlign.center,
                ),
                backgroundColor: Colors.transparent,
                elevation: 0,
              ),
            ),
            SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Center(
                  child: Column(
                    children: <Widget>[
                      SizedBox(
                        height: _height / 5,
                      ),
                      Image(
                        image: AssetImage(_assetLocation),
                        height: _height / 4,
                        width: _width / 2,
                      ),
                      SizedBox(
                        height: _height / 30,
                      ),
                      WeightTextField(
                        controller: _controller,
                        focusNode: _focusNode,
                      ),
                      SizedBox(
                        height: _height / 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          Text(
                            'Moon',
                            style: TextStyle(
                                color: Colors.yellowAccent.shade100,
                                fontSize: 20,
                                fontWeight: _radioGroupVal == 0
                                    ? FontWeight.w500
                                    : FontWeight.w300),
                          ),
                          PlanetRadioButton(
                            update: update,
                            val: 0,
                            groupVal: _radioGroupVal,
                            assetLocation: 'images/moon.png',
                            activeColor: Colors.yellowAccent.shade100,
                          ),
                          Text(
                            'Mars',
                            style: TextStyle(
                                color: Colors.redAccent.shade200,
                                fontSize: 20,
                                fontWeight: _radioGroupVal == 1
                                    ? FontWeight.w500
                                    : FontWeight.w300),
                          ),
                          PlanetRadioButton(
                            update: update,
                            val: 1,
                            groupVal: _radioGroupVal,
                            assetLocation: 'images/mars.png',
                            activeColor: Colors.redAccent.shade200,
                          ),
                          Text(
                            'Jupiter',
                            style: TextStyle(
                                color: Colors.deepOrange.shade300,
                                fontSize: 20,
                                fontWeight: _radioGroupVal == 2
                                    ? FontWeight.w500
                                    : FontWeight.w300),
                          ),
                          PlanetRadioButton(
                            update: update,
                            val: 2,
                            groupVal: _radioGroupVal,
                            assetLocation: 'images/jupyter.png',
                            activeColor: Colors.deepOrange.shade300,
                          ),
                          Text(
                            'Pluto',
                            style: TextStyle(
                                color: Colors.brown.shade200,
                                fontSize: 20,
                                fontWeight: _radioGroupVal == 3
                                    ? FontWeight.w500
                                    : FontWeight.w300),
                          ),
                          PlanetRadioButton(
                            update: update,
                            val: 3,
                            groupVal: _radioGroupVal,
                            assetLocation: 'images/pluto.png',
                            activeColor: Colors.brown.shade200,
                          ),
                        ],
                      ),
                      SizedBox(
                        height: _height / 20,
                      ),
                      _controller.text.isNotEmpty&&_formKey.currentState.validate()
                          ? Text(
                              'You weigh ${(double.parse(_controller.text)*(_gravities[_radioGroupVal].value/9.807)).toStringAsFixed(2)} kilograms on ${_gravities[_radioGroupVal].key}',
                              style: TextStyle(
                                  color: Colors.white70, fontSize: 20),
                            )
                          : Container(),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class WeightTextField extends StatelessWidget {
  final TextEditingController controller;
  final GlobalKey<FormState> key;
  final FocusNode focusNode;
  WeightTextField({this.controller, this.key, this.focusNode});
  bool isNumeric(String s) {
    if (s == null) {
      return false;
    }
    return double.parse(s, (e) => null) != null;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width / 5 * 4,
      child: TextFormField(
        key: key,
        controller: controller,
        focusNode: focusNode,
        onEditingComplete: () {},
        decoration: InputDecoration(
          enabledBorder:
              OutlineInputBorder(borderSide: BorderSide(color: Colors.white)),
          labelText: 'Your Weight on Earth',
          suffixText: 'kg',suffixStyle: TextStyle(color: Colors.white70,fontSize: 25),
          labelStyle: TextStyle(color: Colors.white70),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(6)),
        ),
        keyboardType: TextInputType.number,
        style: TextStyle(
          color: Colors.white,
          fontSize: 24,
          fontWeight: FontWeight.w300,
        ),
        validator: (value) {
          if (value.isEmpty || !isNumeric(value)) {
            return 'Please provide a valid number.';
          }
        },
      ),
    );
  }
}

class PlanetRadioButton extends StatelessWidget {
  final int val;
  final int groupVal;
  final String assetLocation;
  final Color activeColor;
  final Function update;
  PlanetRadioButton(
      {this.assetLocation,
      this.update,
      this.val,
      this.groupVal,
      this.activeColor});
  @override
  Widget build(BuildContext context) {
    return Radio<int>(
      activeColor: activeColor,
      value: val,
      onChanged: (value) {
        update(assetLocation, value);
      },
      groupValue: groupVal,
    );
  }
}

class BackgroundImage extends StatelessWidget {
  final Widget child;
  BackgroundImage({this.child});
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
            image: AssetImage('images/space.jpg'), fit: BoxFit.cover),
      ),
      child: child,
    );
  }
}

class CalculateButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FlatButton(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
      child: Text(
        'Calculate',
        style: TextStyle(
            color: Colors.white70, fontWeight: FontWeight.w400, fontSize: 22),
      ),
      onPressed: () {},
    );
  }
}
