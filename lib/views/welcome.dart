import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';
import 'package:braille_printing/utils/constants.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen();

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Container(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Hero(
                  tag: 'logo',
                  child: Image(
                    image: AssetImage('images/braille.jpg'),
                    height: MediaQuery.of(context).size.height / 4,
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Center(
                  child: Text('Braille Printing App',
                      style: TextStyle(
                          color: Color(0xff333333),
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Zen')),
                ),
                SizedBox(
                  height: 20,
                ),
                Material(
                  elevation: 20,
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                  child: Container(
                    decoration: BoxDecoration(
                      color: kButton,
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                    ),
                    alignment: FractionalOffset.center,
                    width: MediaQuery.of(context).size.width / 2.5,
                    height: 40,
                    child: TextButton(
                      onPressed: () {
                        Navigator.pushNamed(context, 'ocr');
                      },
                      child: Text(
                        "Image To Text",
                        style: TextStyle(
                            color: kButtonText,
                            fontSize: MediaQuery.of(context).size.width / 30,
                            fontFamily: 'Open Sans',
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Material(
                  elevation: 20,
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                  child: Container(
                    decoration: BoxDecoration(
                      color: kButton,
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                    ),
                    alignment: FractionalOffset.center,
                    width: MediaQuery.of(context).size.width / 2.5,
                    height: 40,
                    child: TextButton(
                      onPressed: () {
                        Navigator.pushNamed(context, 'bluetooth');
                      },
                      child: Text(
                        "Type Text",
                        style: TextStyle(
                            color: kButtonText,
                            fontSize: MediaQuery.of(context).size.width / 30,
                            fontFamily: 'Open Sans',
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Material(
                  elevation: 20,
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                  child: Container(
                    decoration: BoxDecoration(
                      color: kButton,
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                    ),
                    alignment: FractionalOffset.center,
                    width: MediaQuery.of(context).size.width / 2.5,
                    height: 40,
                    child: TextButton(
                      onPressed: () {
                        Navigator.pushNamed(context, 'voice');
                      },
                      child: Text(
                        "Voice To Text",
                        style: TextStyle(
                            color: kButtonText,
                            fontSize: MediaQuery.of(context).size.width / 30,
                            fontFamily: 'Open Sans',
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Material(
                  elevation: 20,
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                  child: Container(
                    decoration: BoxDecoration(
                      color: kButton,
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                    ),
                    alignment: FractionalOffset.center,
                    width: MediaQuery.of(context).size.width / 2.5,
                    height: 40,
                    child: TextButton(
                      onPressed: () {
                        Navigator.pushNamed(context, 'pdf');
                      },
                      child: Text(
                        "Upload Pdf",
                        style: TextStyle(
                            color: kButtonText,
                            fontSize: MediaQuery.of(context).size.width / 30,
                            fontFamily: 'Open Sans',
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
