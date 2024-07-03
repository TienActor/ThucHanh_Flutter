import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tien/Screen/welcome/welcomePage.dart';
import 'package:tien/Screen/welcome/welcome_image.dart';

class IntroPage extends StatefulWidget {
  @override
  _IntroPageState createState() => _IntroPageState();
}

class _IntroPageState extends State<IntroPage> {
  @override
  Widget build(BuildContext context) {
    // Figma Flutter Generator Group343Widget - GROUP

    return Container(
        width: 412,
        height: 892,
        child: Stack(children: <Widget>[
          Positioned(
              top: 0,
              left: 0,
              child: Container(
                  width: 412,
                  height: 892,
                  child: Stack(children: <Widget>[
                    Positioned(
                        top: 0,
                        left: 0,
                        child: Container(
                            width: 412,
                            height: 892,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(30),
                                topRight: Radius.circular(30),
                                bottomLeft: Radius.circular(30),
                                bottomRight: Radius.circular(30),
                              ),
                              color: Color.fromRGBO(255, 255, 255, 1),
                            ),
                            child: Stack(children: <Widget>[]))),
                    Positioned(
                        width: 380,
                        top: 593.201904296875,
                        left: 20,
                        child: Text(
                          'Đừng bỏ lỡ cơ hội biết được bộ sưu tập giày thời thượng của chúng tôi.',
                          textAlign: TextAlign.left,
                          style: GoogleFonts.aBeeZee(
                              color: Color.fromRGBO(112, 123, 129, 1),
                              fontSize: 20,
                              letterSpacing: 0,
                              fontWeight: FontWeight.normal,
                              height: 1.6),
                        )),
                    Positioned(
                        top: 201,
                        left: 35,
                        child: Container(
                            width: 329.6000061035156,
                            height: 119.7389144897461,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: AssetImage(
                                      'assets/images/Imageremovebgpreview2.png'),
                                  fit: BoxFit.fitWidth),
                            ))),
                    Positioned(
                        width: 380,
                        top: 453.689697265625,
                        left: 20,
                        child: Text(
                          'Chào mừng bạn đã đến với chúng tôi!',
                          textAlign: TextAlign.left,
                          style: GoogleFonts.pacifico(
                              color: Color.fromRGBO(26, 36, 47, 1),
                              fontSize: 40,
                              letterSpacing: 0,
                              fontWeight: FontWeight.normal,
                              height: 1.5),
                        )),
                    Positioned(
                        top: 750,
                        left: 38,
                        child: Container(
                            width: 350,
                            height: 80,
                            child: Stack(children: <Widget>[
                              Positioned(
                                top: 0,
                                left: 180,
                                width: 170,
                                height: 80,
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(50),
                                      topRight: Radius.circular(50),
                                      bottomLeft: Radius.circular(50),
                                      bottomRight: Radius.circular(50),
                                    ),
                                    color: Color.fromRGBO(91, 158, 225, 1),
                                  ),
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 32, vertical: 16),
                                  child: TextButton(
                                    style: TextButton.styleFrom(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 20, vertical: 10),
                                      backgroundColor:
                                          Color.fromRGBO(91, 158, 225, 1),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(50),
                                      ),
                                    ),
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                WelcomeScreen()),
                                      );
                                    },
                                    child: Text(
                                      'Bắt đầu',
                                      style: GoogleFonts.zillaSlab(fontSize: 18,color: Colors.white),
                                    )
                                  ),
                                ),
                              ),
                              Positioned(
                                  top: 27.463043212890625,
                                  left: 0,
                                  child: Container(
                                      width: 73.61066436767578,
                                      height: 5.492610931396484,
                                      child: Stack(children: <Widget>[
                                        Positioned(
                                            top: 0,
                                            left: 0,
                                            child: Container(
                                                width: 38.45333480834961,
                                                height: 5.492610931396484,
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.only(
                                                    topLeft:
                                                        Radius.circular(16),
                                                    topRight:
                                                        Radius.circular(16),
                                                    bottomLeft:
                                                        Radius.circular(16),
                                                    bottomRight:
                                                        Radius.circular(16),
                                                  ),
                                                  color: Color.fromRGBO(
                                                      91, 158, 225, 1),
                                                ))),
                                        Positioned(
                                            top: 0,
                                            left: 47.24267578125,
                                            child: Container(
                                                width: 8.78933334350586,
                                                height: 5.492610931396484,
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.only(
                                                    topLeft:
                                                        Radius.circular(16),
                                                    topRight:
                                                        Radius.circular(16),
                                                    bottomLeft:
                                                        Radius.circular(16),
                                                    bottomRight:
                                                        Radius.circular(16),
                                                  ),
                                                  color: Color.fromRGBO(
                                                      229, 238, 247, 1),
                                                ))),
                                        Positioned(
                                            top: 0,
                                            left: 64.8212890625,
                                            child: Container(
                                                width: 8.78933334350586,
                                                height: 5.492610931396484,
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.only(
                                                    topLeft:
                                                        Radius.circular(16),
                                                    topRight:
                                                        Radius.circular(16),
                                                    bottomLeft:
                                                        Radius.circular(16),
                                                    bottomRight:
                                                        Radius.circular(16),
                                                  ),
                                                  color: Color.fromRGBO(
                                                      229, 238, 247, 1),
                                                ))),
                                      ]))),
                            ]))),
                  ]))),
          Positioned(
              top: 145.00494384765625,
              left: 20.44189453125,
              child: Container(
                  width: 346.0799865722656,
                  height: 303.0526123046875,
                  child: Stack(children: <Widget>[
                    Positioned(
                      top: 289.3299560546875,
                      left: 0,
                      child: Image.asset('assets/images/ellipse903.png'),
                    ),
                    Positioned(
                      top: 290.14947509765625,
                      left: 331.79736328125,
                      child: Image.asset('assets/images/ellipse904.png'),
                    ),
                    Positioned(
                        top: 0,
                        left: 22.5224609375,
                        child: Container(
                            width: 17.57866668701172,
                            height: 15.88088607788086,
                            decoration: BoxDecoration(
                              color: Color.fromRGBO(164, 205, 246, 1),
                              borderRadius: BorderRadius.all(Radius.elliptical(
                                  17.57866668701172, 15.88088607788086)),
                            ))),
                  ]))),
        ]));
  }
}