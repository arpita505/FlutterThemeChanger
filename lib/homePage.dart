import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:theme_changer/themeProvider.dart';
import 'package:day_night_switch/day_night_switch.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

const dayColor = Color(0xFFd58777);
var nightColor = Color(0xFF1e2230);

class _HomePageState extends State<HomePage> with SingleTickerProviderStateMixin{
  AnimationController _animationController;
  var val = true;
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    _animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 800));
    super.initState();
  }

  // function to toggle circle animation
  changeThemeMode(bool theme) {
    if (!theme) {
      _animationController.forward(from: 0.0);
    } else {
      _animationController.reverse(from: 1.0);
    }
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    final themeProvider = Provider.of<ThemeProvider>(context);
    return Scaffold(
      backgroundColor: const Color(0xFF414a4c),
      key: _scaffoldKey,
      body: AnimatedContainer(
        color: val ? nightColor : dayColor,
        duration: Duration(milliseconds: 300),
        child: Stack(
          alignment: Alignment.center,
          children: <Widget>[
            buildStar(top: 100, left: 40, val: val),
            buildStar(top: 200, left: 80, val: val),
            buildStar(top: 300, left: 10, val: val),
            buildStar(top: 500, left: 100, val: val),
            buildStar(top: 300, right: 40, val: val),
            buildStar(top: 250, right: 100, val: val),
            buildStar(top: 450, right: 80, val: val),
            buildStar(top: 100, right: 40, val: val),
            buildStar(top: 450, right: 80, val: val),
            buildStar(top: 500, left: 10, val: val),
            buildStar(top: 650, left: 100, val: val),
            buildStar(top: 700, right: 40, val: val),
            buildStar(top: 750, right: 100, val: val),
            buildStar(top: 850, right: 80, val: val),
            Positioned(
              bottom: 0,
              right: 0,
              left: 0,
              height: 200,
              child: Opacity(
                opacity: val ? 0 : 1.0,
                child: Image.asset(
                  'assets/cloud.png',
                  fit: BoxFit.cover,
                ),
              ),
            ),
            AnimatedBuilder(
              animation: _animationController,
              builder: (context, child) {
                return Stack(
                  children: <Widget>[
                    Positioned(
                      bottom: -20,
                      right: 0,
                      left: 0,
                      child: Transform.translate(
                        offset: Offset(50 * _animationController.value, 0),
                        child: Opacity(
                          opacity: val ? 0.0 : 0.8,
                          child: Image.asset(
                            'assets/cloud2.png',
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: -20,
                      right: 0,
                      left: 0,
                      child: Transform.translate(
                        offset: Offset(100 * _animationController.value, 0),
                        child: Opacity(
                          opacity: val ? 0.0 : 0.4,
                          child: Image.asset(
                            'assets/cloud3.png',
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
          Column(
            children:[
            SizedBox(height: height * 0.3),
            Text(
              'Choose a theme',
              style: TextStyle(
                  fontSize: width * .06, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: height * 0.1),
            Center(
              child: DayNightSwitch(
                value: val,
                moonImage: AssetImage('assets/moon.png'),
                onChanged: (value) {
                  setState(() {
                    val = value;
                  });
                  changeThemeMode(themeProvider.isLightTheme);
                  themeProvider.toggleThemeData();
                },
              ),
            ),
          SizedBox(
            height: height * .05,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
             buildDot(
              width: width * 0.022,
              height: width * 0.022,
              color: const Color(0xFFd9d9d9),
            ),
            buildDot(
              width: width * 0.055,
              height: width * 0.022,
              color: themeProvider.isLightTheme
                  ? Color(0xFF26242e)
                  : Colors.white,
            ),
            buildDot(
              width: width * 0.022,
              height: width * 0.022,
              color: const Color(0xFFd9d9d9),
            ),
          ],
        ),
        ],
      ),
      ],
        ),
    ),
    );
  }

  buildStar({double top, double left, double right, bool val}) {
    return Positioned(
      top: top,
      right: right,
      left: left,
      child: Opacity(
        opacity: val ? 1 : 0,
        child: CircleAvatar(
          radius: 2,
          backgroundColor: Colors.white,
        ),
      ),
    );
  }

  Container buildDot({double width, double height, Color color}) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10),
      width: width,
      height: height,
      decoration: ShapeDecoration(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(40),
        ),
        color: color,
      ),
    );
  }
}
