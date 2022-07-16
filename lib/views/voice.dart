import 'package:flutter/material.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;
import 'package:avatar_glow/avatar_glow.dart';
import 'package:braille_printing/utils/constants.dart';
import 'package:braille_printing/views/bluetooth.dart';

class VoiceText extends StatefulWidget {
  const VoiceText({Key key}) : super(key: key);

  @override
  State<VoiceText> createState() => _VoiceTextState();
}

class _VoiceTextState extends State<VoiceText> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Voice',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.red,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: SpeechScreen(),
    );
  }
}

class SpeechScreen extends StatefulWidget {
  @override
  _SpeechScreenState createState() => _SpeechScreenState();
}

class _SpeechScreenState extends State<SpeechScreen> {
  stt.SpeechToText _speech;
  bool _isListening = false;
  String _text = 'Press the button and start speaking';

  @override
  void initState() {
    super.initState();
    _speech = stt.SpeechToText();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: Text(
            "Braille Speech",
            style: TextStyle(color: Colors.black),
          ),
          toolbarHeight: MediaQuery.of(context).size.height / 10,
          elevation: 0,
          leadingWidth: MediaQuery.of(context).size.width / 4,
          leading: Padding(
            padding: const EdgeInsets.all(0),
            child: Hero(
              tag: 'logo',
              child: Image(
                image: AssetImage('images/braille.jpg'),
              ),
            ),
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: AvatarGlow(
          animate: _isListening,
          glowColor: Theme.of(context).primaryColor,
          endRadius: 75.0,
          duration: const Duration(milliseconds: 2000),
          repeatPauseDuration: const Duration(milliseconds: 100),
          repeat: true,
          child: FloatingActionButton(
            backgroundColor: kButton,
            onPressed: _listen,
            child: Icon(
              _isListening ? Icons.mic : Icons.mic_none,
              color: kButtonText,
            ),
          ),
        ),
        body: Column(
          children: [
            SingleChildScrollView(
              reverse: true,
              child: Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.fromLTRB(30.0, 30.0, 30.0, 450),
                child: Text(
                  _text,
                  style: TextStyle(fontSize: 15),
                ),
              ),
            ),
            Ink(
              height: 50,
              width: 50,
              decoration: const ShapeDecoration(
                color: Color(0xff333333),
                shape: CircleBorder(),
              ),
              child: IconButton(
                icon: const Icon(Icons.arrow_forward_sharp),
                color: kButtonText,
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Bluetooth(
                          scannedText: _text,
                        ),
                      ));
                },
              ),
            ),
          ],
        ));
  }

  void _listen() async {
    if (!_isListening) {
      bool available = await _speech.initialize(
        onStatus: (val) => print('onStatus: $val'),
        onError: (val) => print('onError: $val'),
      );
      if (available) {
        setState(() => _isListening = true);
        _speech.listen(
          onResult: (val) => setState(() {
            _text = val.recognizedWords;
          }),
        );
      }
    } else {
      setState(() => _isListening = false);
      _speech.stop();
    }
  }
}
