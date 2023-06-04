import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({super.key});

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  bool isAbout = false;

  TextEditingController emailcontroller = TextEditingController();

  Future<void> _launchInBrowser(String url) async {
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(
        Uri.parse(url),
        // forceSafariVC: false,
        // forceWebView: false,
      );
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    var Height = MediaQuery.of(context).size.height;
    var Width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: isAbout == false ? Home(Width, Height) : About(Width, Height),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  Home(var Width, var Height) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
          width: Width,
          height: Height,
          decoration: BoxDecoration(
              image: DecorationImage(
                  fit: BoxFit.cover,
                  image: NetworkImage(
                      'https://images.pexels.com/photos/143640/pexels-photo-143640.jpeg?cs=srgb&dl=pexels-brigitte-tohm-143640.jpg&fm=jpg'))),
        ),
        Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(colors: [
              Colors.black.withOpacity(.5),
              Colors.black.withOpacity(.5),
              // Colors.white.withOpacity(.2),
              // Colors.white.withOpacity(.2),
            ]),
          ),
        ),
        Positioned(
            top: 30,
            right: 0,
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.deepOrange,
                  borderRadius:
                      BorderRadius.horizontal(left: Radius.circular(50))),
              child: Row(
                children: [
                  // SizedBox(width: 20,),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        isAbout = false;
                      });
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.horizontal(
                            left: Radius.circular(50),
                            right: Radius.circular(50)),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(
                            left: 30, right: 30, top: 8, bottom: 8),
                        child: Text(
                          'Home',
                          style: GoogleFonts.poppins(
                              fontSize: 20,
                              // fontWeight: FontWeight.bold,
                              color: Colors.deepOrange),
                        ),
                      ),
                    ),
                  ),
                  // SizedBox(width: 20,),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        isAbout = true;
                      });
                    },
                    child: Container(
                      child: Padding(
                        padding: const EdgeInsets.only(
                            left: 20, right: 40, top: 8, bottom: 8),
                        child: Text(
                          'About',
                          style: GoogleFonts.poppins(
                              fontSize: 20,
                              // fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                  // SizedBox(width: 40,),
                ],
              ),
            )),
        Positioned(
          top: 150,
          child: Image.asset(
            'images/myrestroqr_white.png',
            height: 80,
          ),
        ),
        Positioned(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Image.asset(r'myrestroqr_white.png',height: 80,),
            // SizedBox(height: 10,),
            // Stack(
            //   children: [
            //     // Text('Coming Soon',style: GoogleFonts.rockSalt(
            //     //   fontWeight: FontWeight.bold,
            //     //
            //     //   fontSize: 90,
            //     //   foreground: Paint(
            //     //   )
            //     //     ..style = PaintingStyle.stroke
            //     //     ..strokeWidth = 4
            //     //     ..color = Colors.deepOrange[700],
            //     //
            //     // ),),
            //     Text('Coming Soon',style: GoogleFonts.rockSalt(
            //       fontWeight: FontWeight.bold,
            //       color: Colors.white,
            //       fontSize: 90,
            //
            //
            //     ),),
            //   ],
            // ),
            Text(
              'Coming Soon',
              style: GoogleFonts.rockSalt(
                fontWeight: FontWeight.bold,
                color: Colors.white,
                fontSize: 90,
              ),
            ),
            // SizedBox(height: 20,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(50)),
                  width: Width / 3,
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Center(
                    child: TextFormField(
                      controller: emailcontroller,
                      cursorColor: Colors.deepOrange,
                      keyboardType: TextInputType.emailAddress,
                      decoration: new InputDecoration(
                          border: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          enabledBorder: InputBorder.none,
                          errorBorder: InputBorder.none,
                          disabledBorder: InputBorder.none,
                          //   suffixIcon: IconButton(
                          // onPressed: (){
                          //   print('hello');
                          // },
                          //     icon: Icon(Icons.arrow_forward,color: Colors.blueAccent,),
                          //   ),
                          contentPadding: EdgeInsets.only(
                              left: 15, bottom: 11, top: 11, right: 15),
                          hintText: "Enter Email Address"),
                    ),
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                GestureDetector(
                  onTap: () {
                  },
                  child: CircleAvatar(
                    radius: 25,
                    backgroundColor: Colors.deepOrange,
                    child: Icon(
                      Icons.arrow_forward,
                      color: Colors.white,
                    ),
                  ),
                )
              ],
            ),
          ],
        )),
        Positioned(
            bottom: 30,
            left: 0,
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.deepOrange,
                  borderRadius:
                      BorderRadius.horizontal(right: Radius.circular(50))),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    SizedBox(
                      width: 20,
                    ),
                    GestureDetector(
                        onTap: () {
                          _launchInBrowser(
                              "https://www.instagram.com/restroqr/?hl=en");
                        },
                        child: CircleAvatar(
                            backgroundColor: Colors.deepOrange,
                            radius: 20,
                            child: FaIcon(
                              FontAwesomeIcons.facebookF,
                              color: Colors.white,
                            ))),
                    SizedBox(
                      width: 20,
                    ),
                    GestureDetector(
                        onTap: () {
                          setState(() {
                            _launchInBrowser(
                                "https://www.instagram.com/restroqr/?hl=en");
                          });
                        },
                        child: CircleAvatar(
                            backgroundColor: Colors.deepOrange,
                            radius: 20,
                            child: FaIcon(
                              FontAwesomeIcons.instagram,
                              color: Colors.white,
                            ))),
                    SizedBox(
                      width: 20,
                    ),
                    GestureDetector(
                        onTap: () {
                          _launchInBrowser(
                              "https://www.instagram.com/restroqr/?hl=en");
                        },
                        child: CircleAvatar(
                            backgroundColor: Colors.deepOrange,
                            radius: 20,
                            child: FaIcon(
                              FontAwesomeIcons.twitter,
                              color: Colors.white,
                            ))),
                    SizedBox(
                      width: 20,
                    ),
                  ],
                ),
              ),
            )),
        Positioned(
          bottom: 30,
          right: 50,
          child: Text(
            "\u00a9 Editors Chamber",
            style: GoogleFonts.poppins(fontSize: 15, color: Colors.white),
          ),
        ),
      ],
    );
  }

  About(var Width, var Height) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
          width: Width,
          height: Height,
          decoration: BoxDecoration(
              image: DecorationImage(
                  fit: BoxFit.cover,
                  image: NetworkImage(
                      'https://images.pexels.com/photos/143640/pexels-photo-143640.jpeg?cs=srgb&dl=pexels-brigitte-tohm-143640.jpg&fm=jpg'))),
        ),
        Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(colors: [
              Colors.black.withOpacity(.5),
              Colors.black.withOpacity(.5),
              // Colors.white.withOpacity(.2),
              // Colors.white.withOpacity(.2),
            ]),
          ),
        ),
        Positioned(
            top: 30,
            right: 0,
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.deepOrange,
                  borderRadius:
                      BorderRadius.horizontal(left: Radius.circular(50))),
              child: Row(
                children: [
                  // SizedBox(width: 20,),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        isAbout = false;
                      });
                    },
                    child: Container(
                      child: Padding(
                        padding: const EdgeInsets.only(
                            left: 30, right: 30, top: 8, bottom: 8),
                        child: Text(
                          'Home',
                          style: GoogleFonts.poppins(
                              fontSize: 20,
                              // fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                  // SizedBox(width: 20,),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        isAbout = true;
                      });
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius:
                            BorderRadius.horizontal(left: Radius.circular(50)),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(
                            left: 30, right: 40, top: 8, bottom: 8),
                        child: Text(
                          'About',
                          style: GoogleFonts.poppins(
                              fontSize: 20,
                              // fontWeight: FontWeight.bold,
                              color: Colors.deepOrange),
                        ),
                      ),
                    ),
                  ),
                  // SizedBox(width: 40,),
                ],
              ),
            )),
        Positioned(
          top: 150,
          child: Image.asset(
            'images/myrestroqr_white.png',
            height: 80,
          ),
        ),
        Positioned(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Image.asset(r'myrestroqr_white.png',height: 80,),
            // SizedBox(height: 10,),
            // Stack(
            //   children: [
            //     // Text('Coming Soon',style: GoogleFonts.rockSalt(
            //     //   fontWeight: FontWeight.bold,
            //     //
            //     //   fontSize: 90,
            //     //   foreground: Paint(
            //     //   )
            //     //     ..style = PaintingStyle.stroke
            //     //     ..strokeWidth = 4
            //     //     ..color = Colors.deepOrange[700],
            //     //
            //     // ),),
            //     Text('Coming Soon',style: GoogleFonts.rockSalt(
            //       fontWeight: FontWeight.bold,
            //       color: Colors.white,
            //       fontSize: 90,
            //
            //
            //     ),),
            //   ],
            // ),
            Text(
              'Coming Soon',
              style: GoogleFonts.rockSalt(
                fontWeight: FontWeight.bold,
                color: Colors.white,
                fontSize: 90,
              ),
            ),
            // SizedBox(height: 20,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(50)),
                  width: Width / 3,
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Center(
                    child: TextFormField(
                      controller: emailcontroller,
                      cursorColor: Colors.deepOrange,
                      keyboardType: TextInputType.emailAddress,
                      decoration: new InputDecoration(
                          border: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          enabledBorder: InputBorder.none,
                          errorBorder: InputBorder.none,
                          disabledBorder: InputBorder.none,
                          //   suffixIcon: IconButton(
                          // onPressed: (){
                          //   print('hello');
                          // },
                          //     icon: Icon(Icons.arrow_forward,color: Colors.blueAccent,),
                          //   ),
                          contentPadding: EdgeInsets.only(
                              left: 15, bottom: 11, top: 11, right: 15),
                          hintText: "Enter Email Address"),
                    ),
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      emailcontroller.clear();
                    });
                  },
                  child: CircleAvatar(
                    radius: 25,
                    backgroundColor: Colors.deepOrange,
                    child: Icon(
                      Icons.arrow_forward,
                      color: Colors.white,
                    ),
                  ),
                )
              ],
            ),
          ],
        )),
        Positioned(
            bottom: 30,
            left: 0,
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.deepOrange,
                  borderRadius:
                      BorderRadius.horizontal(right: Radius.circular(50))),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    SizedBox(
                      width: 20,
                    ),
                    GestureDetector(
                        onTap: () {
                          _launchInBrowser(
                              "https://www.instagram.com/restroqr/?hl=en");
                        },
                        child: CircleAvatar(
                            backgroundColor: Colors.deepOrange,
                            radius: 20,
                            child: FaIcon(
                              FontAwesomeIcons.facebookF,
                              color: Colors.white,
                            ))),
                    SizedBox(
                      width: 20,
                    ),
                    GestureDetector(
                        onTap: () {
                          setState(() {
                            _launchInBrowser(
                                "https://www.instagram.com/restroqr/?hl=en");
                          });
                        },
                        child: CircleAvatar(
                            backgroundColor: Colors.deepOrange,
                            radius: 20,
                            child: FaIcon(
                              FontAwesomeIcons.instagram,
                              color: Colors.white,
                            ))),
                    SizedBox(
                      width: 20,
                    ),
                    GestureDetector(
                        onTap: () {
                          _launchInBrowser(
                              "https://www.instagram.com/restroqr/?hl=en");
                        },
                        child: CircleAvatar(
                            backgroundColor: Colors.deepOrange,
                            radius: 20,
                            child: FaIcon(
                              FontAwesomeIcons.twitter,
                              color: Colors.white,
                            ))),
                    SizedBox(
                      width: 20,
                    ),
                  ],
                ),
              ),
            )),
        Positioned(
          bottom: 30,
          right: 50,
          child: Text(
            "\u00a9 Editors Chamber",
            style: GoogleFonts.poppins(fontSize: 15, color: Colors.white),
          ),
        ),
      ],
    );
  }
}
