import 'dart:math';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:braille_printing/utils/constants.dart';
import 'package:pdf_text/pdf_text.dart';

class PdfRead extends StatefulWidget {
  const PdfRead({Key key}) : super(key: key);

  @override
  State<PdfRead> createState() => _PdfReadState();
}

class _PdfReadState extends State<PdfRead> {
  PDFDoc _pdfDoc;
  String _text = "";

  bool _buttonsEnabled = true;

  @override
  void initState() {
    super.initState();
  }

  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.white,
            title: Text(
              "Braille PDF",
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
          floatingActionButton: FloatingActionButton(
            backgroundColor: kButton,
            child: Icon(
              Icons.arrow_forward_sharp,
              color: kButtonText,
            ),
            onPressed: () {
              Navigator.pushNamed(context, 'bluetooth');
            },
          ),
          body: Container(
            alignment: Alignment.center,
            padding: EdgeInsets.all(30),
            child: ListView(
              children: <Widget>[
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
                      onPressed: _pickPDFText,
                      child: Text(
                        "Upload PDF Document",
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
                      onPressed: _buttonsEnabled ? _readRandomPage : () {},
                      child: Text(
                        "Read Specific Page",
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
                      onPressed: _buttonsEnabled ? _readWholeDoc : () {},
                      child: Text(
                        "Read Whole Document",
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
                Padding(
                  child: Text(
                    _pdfDoc == null
                        ? "Upload PDF to Read Text"
                        : "PDF Document Loaded, ${_pdfDoc.length} pages\n",
                    style: TextStyle(fontSize: 18),
                    textAlign: TextAlign.center,
                  ),
                  padding: EdgeInsets.all(15),
                ),
                Padding(
                  child: Text(
                    _text == "" ? "" : "Text:",
                    style: TextStyle(fontSize: 18),
                    textAlign: TextAlign.center,
                  ),
                  padding: EdgeInsets.all(15),
                ),
                Text(_text),
              ],
            ),
          )),
    );
  }

  Future _pickPDFText() async {
    var filePickerResult = await FilePicker.platform.pickFiles();
    if (filePickerResult != null) {
      _pdfDoc = await PDFDoc.fromPath(filePickerResult.files.single.path);
      setState(() {});
    }
  }

  Future _readRandomPage() async {
    if (_pdfDoc == null) {
      return;
    }
    setState(() {
      _buttonsEnabled = false;
    });

    String text =
        await _pdfDoc.pageAt(Random().nextInt(_pdfDoc.length) + 1).text;

    setState(() {
      _text = text;
      _buttonsEnabled = true;
    });
  }

  Future _readWholeDoc() async {
    if (_pdfDoc == null) {
      return;
    }
    setState(() {
      _buttonsEnabled = false;
    });

    String text = await _pdfDoc.text;

    setState(() {
      _text = text;
      _buttonsEnabled = true;
    });
  }
}
