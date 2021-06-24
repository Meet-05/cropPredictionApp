import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:io';
import './result_screen.dart';
import './constants.dart';

class LandingScreen extends StatefulWidget {
  @override
  _LandingScreenState createState() => _LandingScreenState();
}

class _LandingScreenState extends State<LandingScreen> {
  final _form = GlobalKey<FormState>();
  String nitrogen;
  String phosphorous;
  String pottasium;
  String temperature;
  String humidity;
  String ph_level;
  String rainfall;

  void predictCrop() async {
    bool validate = _form.currentState.validate();
    if (validate) {
      _form.currentState.save();
      String url =
          'http://10.0.2.2:5000/crop_predict?nitrogen=$nitrogen&phosphorous=$phosphorous&pottasium=$pottasium&temperature=$temperature&humidity=$humidity&ph_level=$ph_level&rainfall=$rainfall';
      print(url);
      final uri = Uri.parse(url);
      print('before request---');
      final response = await http.get(uri);
      print('after after request---');
      print(response.statusCode);
      if (response.statusCode == 200) {
        print('s');
        var response_decoded = jsonDecode(response.body);
        String result = response_decoded['result'];
        print(result);
        // return jsonDecode(data);
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ResultScreen(result: result)));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          backgroundColor: Colors.grey[200],
          body: SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.all(10.0),
              child: Form(
                key: _form,
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      buildTextContainer(
                        'nitrogen',
                      ),
                      buildTextFormField(
                          onTap: (value) {
                            nitrogen = value;
                          },
                          key: 'nitrogen'),
                      buildTextContainer('Phosphorous'),
                      buildTextFormField(
                          onTap: (value) {
                            phosphorous = value;
                          },
                          key: 'phosphorous'),
                      buildTextContainer('pottasium'),
                      buildTextFormField(
                          onTap: (value) {
                            pottasium = value;
                          },
                          key: 'pottasium'),
                      buildTextContainer('temperature'),
                      buildTextFormField(
                          onTap: (value) {
                            temperature = value;
                          },
                          key: 'temperature'),
                      buildTextContainer('humidity'),
                      buildTextFormField(
                          onTap: (value) {
                            humidity = value;
                          },
                          key: 'humidity'),
                      buildTextContainer('ph_level'),
                      buildTextFormField(
                          onTap: (value) {
                            ph_level = value;
                          },
                          key: 'ph_level'),
                      buildTextContainer('rainfall'),
                      buildTextFormField(
                          onTap: (value) {
                            rainfall = value;
                          },
                          key: 'rainfall'),
                      Center(
                        child: MaterialButton(
                          child: Container(
                              margin: EdgeInsets.symmetric(vertical: 15.0),
                              padding: EdgeInsets.all(20.0),
                              decoration: BoxDecoration(
                                  color: Colors.green,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10.0))),
                              child: Text(
                                'predict',
                                style: kStyle.copyWith(fontSize: 25.0),
                              )),
                          onPressed: predictCrop,
                        ),
                      )
                    ]),
              ),
            ),
          )),
    );
  }

  Container buildTextContainer(String text) {
    return Container(
        margin: EdgeInsets.symmetric(vertical: 10.0),
        child: Text(
          text,
          style: kStyle,
        ));
  }

  TextFormField buildTextFormField({Function onTap, String key}) {
    return TextFormField(
      keyboardType: TextInputType.number,
      key: ValueKey(key),
      validator: (value) {
        if (value.isEmpty) {
          return 'field should not be empty';
        }
        return null;
      },
      onSaved: onTap,
      decoration: InputDecoration(
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(10.0)),
              borderSide: BorderSide(color: Colors.black)),
          contentPadding:
              EdgeInsets.only(left: 15, bottom: 11, top: 11, right: 15),
          hintText: "Enter a Value example(20.0) "),
    );
  }
}
