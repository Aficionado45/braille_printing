import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
import 'package:braille_printing/views/ocr.dart';
import 'package:braille_printing/utils/BrailleConvert.dart';
import 'package:braille_printing/utils/constants.dart';

class ChatPage extends StatefulWidget {
  final BluetoothDevice server;

  const ChatPage({this.server});

  @override
  _ChatPage createState() => new _ChatPage();
}

String initialText = scannedText;

class _Message {
  int whom;
  String text;

  _Message(this.whom, this.text);
}

class _ChatPage extends State<ChatPage> {
  static final clientID = 0;
  BluetoothConnection connection;

  List<_Message> messages = List<_Message>();
  String _messageBuffer = '';

  final TextEditingController textEditingController =
      new TextEditingController();
  final ScrollController listScrollController = new ScrollController();

  bool isConnecting = true;
  bool get isConnected => connection != null && connection.isConnected;

  bool isDisconnecting = false;
  double width;

  @override
  void initState() {
    super.initState();
    textEditingController.text = initialText;

    BluetoothConnection.toAddress(widget.server.address).then((_connection) {
      print('Connected to the device');
      connection = _connection;
      setState(() {
        isConnecting = false;
        isDisconnecting = false;
      });

      connection.input.listen(_onDataReceived).onDone(() {
        if (isDisconnecting) {
          print('Disconnecting locally!');
        } else {
          print('Disconnected remotely!');
        }
        if (this.mounted) {
          setState(() {});
        }
      });
    }).catchError((error) {
      print('Cannot connect, exception occured');
      print(error);
    });
  }

  @override
  void dispose() {
    if (isConnected) {
      isDisconnecting = true;
      connection.dispose();
      connection = null;
    }

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final List<Row> list = messages.map((_message) {
      return Row(
        children: <Widget>[
          Container(
            child: Text(
                (text) {
                  return text == '/shrug' ? '¯\\_(ツ)_/¯' : text;
                }(_message.text.trim()),
                style: TextStyle(color: Color(0xffffb973))),
            padding: EdgeInsets.all(12.0),
            margin: EdgeInsets.only(bottom: 8.0, left: 8.0, right: 8.0),
            width: 222.0,
            decoration: BoxDecoration(
                color:
                    _message.whom == clientID ? Color(0xff333333) : Colors.grey,
                borderRadius: BorderRadius.circular(7.0)),
          ),
        ],
        mainAxisAlignment: _message.whom == clientID
            ? MainAxisAlignment.end
            : MainAxisAlignment.start,
      );
    }).toList();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
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
        title: (isConnecting
            ? Text('Connecting chat to ' + widget.server.name + '...')
            : isConnected
                ? Text('Send Text To ' + widget.server.name)
                : Text('Chat log with ' + widget.server.name)),
        titleTextStyle: TextStyle(
            color: Colors.black, fontWeight: FontWeight.bold, fontSize: 20),
      ),
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(20)),
              ),
              margin: EdgeInsets.all(20),
              width: MediaQuery.of(context).size.width / 1.3,
              height: MediaQuery.of(context).size.height / 13.6,
              child: TextField(
                textAlign: TextAlign.start,
                style: TextStyle(
                  color: Colors.black,
                  fontFamily: 'Open Sans',
                  fontSize: 20,
                ),
                onChanged: (value) {
                  if (value.isEmpty)
                    return null;
                  else {
                    String input = value;

                    width = double.parse(input);
                  }
                },
                decoration: InputDecoration(
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(32.0)),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        // color: Colors.redAccent,
                        width: 1.0),
                    borderRadius: BorderRadius.all(Radius.circular(32.0)),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        // color: Colors.redAccent,
                        width: 2.0),
                    borderRadius: BorderRadius.all(Radius.circular(32.0)),
                  ),
                  filled: true,
                  labelStyle: kSubHeaderStyle,
                  labelText: "Enter Page Width in cm",
                ),
              ),
            ),
            Flexible(
              child: ListView(
                  padding: const EdgeInsets.all(12.0),
                  controller: listScrollController,
                  children: list),
            ),
            Row(
              children: <Widget>[
                Flexible(
                  child: Container(
                    margin: const EdgeInsets.only(left: 16.0),
                    child: TextField(
                      style: const TextStyle(fontSize: 15.0),
                      controller: textEditingController..text,
                      decoration: InputDecoration.collapsed(
                        hintText: isConnecting
                            ? 'Wait until connected...'
                            : isConnected
                                ? 'Type your message...'
                                : 'Chat got disconnected',
                        hintStyle: const TextStyle(color: Colors.grey),
                      ),
                      enabled: isConnected,
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.all(8.0),
                  child: IconButton(
                      icon: const Icon(Icons.send),
                      onPressed: isConnected
                          ? () => _sendMessage(textEditingController.text)
                          : null),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  void _onDataReceived(Uint8List data) {
    int backspacesCounter = 0;
    data.forEach((byte) {
      if (byte == 8 || byte == 127) {
        backspacesCounter++;
      }
    });
    Uint8List buffer = Uint8List(data.length - backspacesCounter);
    int bufferIndex = buffer.length;

    backspacesCounter = 0;
    for (int i = data.length - 1; i >= 0; i--) {
      if (data[i] == 8 || data[i] == 127) {
        backspacesCounter++;
      } else {
        if (backspacesCounter > 0) {
          backspacesCounter--;
        } else {
          buffer[--bufferIndex] = data[i];
        }
      }
    }

    String dataString = String.fromCharCodes(buffer);
    int index = buffer.indexOf(13);
    if (~index != 0) {
      setState(() {
        messages.add(
          _Message(
            1,
            backspacesCounter > 0
                ? _messageBuffer.substring(
                    0, _messageBuffer.length - backspacesCounter)
                : _messageBuffer + dataString.substring(0, index),
          ),
        );
        _messageBuffer = dataString.substring(index);
      });
    } else {
      _messageBuffer = (backspacesCounter > 0
          ? _messageBuffer.substring(
              0, _messageBuffer.length - backspacesCounter)
          : _messageBuffer + dataString);
    }
  }

  void _sendMessage(String text) async {
    text = text.trim();
    textEditingController.clear();
    print(text);

    if (text.length > 0) {
      try {
        String converted = convert(text, width);
        print(converted);
        connection.output.add(utf8.encode(converted + "\r\n"));
        await connection.output.allSent;

        setState(() {
          messages.add(_Message(clientID, text));
        });

        Future.delayed(Duration(milliseconds: 333)).then((_) {
          listScrollController.animateTo(
              listScrollController.position.maxScrollExtent,
              duration: Duration(milliseconds: 333),
              curve: Curves.easeOut);
        });
      } catch (e) {
        setState(() {});
      }
    }
  }

  initialvalue(val) {
    return TextEditingController(text: val);
  }

  String convert(String text, double width) {
    text.toLowerCase();
    String converted = "";
    Map table = {
      'a': '100000',
      'b': '110000',
      'c': '100100',
      'd': '100110',
      'e': '100010',
      'f': '110100',
      'g': '110110',
      'h': '110010',
      'i': '010100',
      'j': '010110',
      'k': '101000',
      'l': '111000',
      'm': '101100',
      'n': '101110',
      'o': '101010',
      'p': '111100',
      'q': '111110',
      'r': '111010',
      's': '011100',
      't': '011110',
      'u': '101001',
      'v': '111001',
      'w': '010111',
      'x': '101101',
      'y': '101111',
      'z': '101011',
      '#': '001111',
      '1': '100000',
      '2': '110000',
      '3': '100100',
      '4': '100110',
      '5': '100010',
      '6': '110100',
      '7': '110110',
      '8': '110010',
      '9': '010100',
      '0': '010110',
      ' ': '000000'
    };
    for (int i = 0; i < text.length; i++) {
      converted = converted + table[text[i]];
    }
    converted += "98";
    return converted;
  }
}
