import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:o_color_picker/o_color_picker.dart';
import 'package:http/http.dart' as http;
import 'package:currency/models/currency.dart';
import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int x = 0;
  void stocker(int x) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt('lang', x);
  }

  void getter() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    setState(() {
      x = prefs.getInt('lang') ?? 1;
    });
  }

  List<String> countries = [
    "Tunisia",
    "France",
    "USA",
    "Kuwait",
    "Libya",
    "Algeria",
    "Saudi Arabia",
    "Canada",
  ];
  List<String> currencies = [
    "TND",
    "EUR",
    "USD",
    "KWD",
    "LYD",
    "DZD",
    "SAR",
    "CAD",
  ];
  List<String> flags = [
    "tn",
    "fr",
    "us",
    "kw",
    "ly",
    "dz",
    "sa",
    "ca",
  ];
  TextEditingController _calculatorController = TextEditingController(text: "1");

  Color selectedColor = Colors.blue;
  String _myCurrency;

  String _trimCurrency(String ch) {
    return ch.substring(0, 2).toLowerCase();
  }

  Future<String> _getCurrentCurrency() async {
    await http.read('https://ipapi.co/currency/', headers: {
      'User-agent': 'your bot 0.1'
    }).then((value) => {
          setState(() {
            _myCurrency = value;
          }),
          print("currency is : " + value),
        });

    return _myCurrency;
  }

  String ch = "";
  Future<Currency> _getResult(String from, String to) async {

    
        // .then((value) => {
        //       // print('abcd : '+value.substring(11,value.indexOf('.')+3)),
        //       setState(() {
        //         ch = value.substring(value.lastIndexOf('result') +8,value.lastIndexOf('result') +12 );
        //       })
        //     });
        //     print("la valeur est : "+ch);
   http.Response myresponse = await http.get("https://api.exchangerate.host/convert?from=$from&to=$to");
   if(myresponse.statusCode == 200){
     return Currency.fromJson(json.decode(myresponse.body));
   }
   else{
     throw Exception('Cannot connect to server');
   }


  }


  @override
  void initState() {
    super.initState();
    _getCurrentCurrency();
  }

  TextEditingController _searchController = TextEditingController();
  bool validate = true;
  bool sumvalidate = true;
  double somme=0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: selectedColor,
      appBar: AppBar(
        backgroundColor: selectedColor,
        actions: [
          IconButton(
              icon: Icon(Icons.translate),
              onPressed: () {
                // showDialog(
                //     context: context,
                //     builder: (BuildContext context) {
                //       return CustomDialog();
                //     });
                _getResult('EUR', 'SAR');
                
              }),
        ],
        leading: IconButton(
          icon: Icon(Icons.color_lens),
          onPressed: () {
            showDialog<void>(
              context: context,
              builder: (_) => Material(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    OColorPicker(
                      selectedColor: selectedColor,
                      colors: primaryColorsPalette,
                      onColorChange: (color) {
                        setState(() {
                          selectedColor = color;
                        });
                        Navigator.of(context).pop();
                      },
                    ),
                  ],
                ),
              ),
            );
// ${_trimCurrency(_myCurrency)}
          },
        ),
        centerTitle: true,
        title: Text(
          "My Dollar",
          style: GoogleFonts.muli(fontWeight: FontWeight.bold,
                                             ),
        ),
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
            // margin:EdgeInsets.symmetric(horizontal: 10),
            height: MediaQuery.of(context).size.height - 20,
            // padding: EdgeInsets.only(top:30),
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: Colors.white, width: 1),
              borderRadius: BorderRadius.circular(20),
            ),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        // mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                            height: 80,
                            width: 120,
                            decoration: BoxDecoration(
                              border: Border.all(
                                  color: Colors.transparent, width: 1),
                              // color:Colors.black,
                              borderRadius: BorderRadius.circular(15),
                              image: DecorationImage(
                                image: AssetImage(
                                    'icons/flags/png/${_trimCurrency(_myCurrency).toLowerCase()}.png',
                                    package: 'country_icons'),
                                fit: BoxFit.cover,
                              ),
                            ),
                            // child:Flag('TN',fit: BoxFit.cover,)
                          ),
                          SizedBox(width: 15),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Country Code: ${_trimCurrency(_myCurrency).toUpperCase()}",
                                style: GoogleFonts.muli(fontWeight: FontWeight.bold,
                                              fontSize: 15,),
                              ),
                              SizedBox(height: 5),
                              Text(
                                "Currency: ${_myCurrency.toUpperCase()}",
                                style: GoogleFonts.muli(fontWeight: FontWeight.bold,
                                              fontSize: 15,),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  Divider(
                    color: Colors.black,
                    indent: 30,
                    endIndent: 30,
                  ),
                  SizedBox(height: 15),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: TextField(
                      controller: _searchController,
                      onChanged: (newWord) {
                        if (newWord.isEmpty) {
                          setState(() {
                            validate = true;
                          });
                        } else if (newWord.length != 3) {
                          setState(() {
                            validate = false;
                          });
                        } else {
                          setState(() {
                            validate = true;
                          });
                        }
                      },

                      // controller: teSeach,
                      decoration: InputDecoration(
                          errorText: validate ? null : 'Invalide Currency code',
                          hintText: 'Search for currency',
                          labelText: 'Search',
                          suffixIcon: IconButton(
                            icon: Icon(Icons.search),
                            onPressed: () {},
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                          )),
                    ),
                  ),
                  SizedBox(height: 5),
                  Container(
                    height: 300,
                    child: ListView.builder(
                      itemCount: countries.length,
                      itemBuilder: (context, index) {
                        if (currencies[index] == _myCurrency) {
                          return SizedBox();
                        } else {
                          return FutureBuilder<Currency>(
                            future:_getResult(currencies[index],_myCurrency ) ,
                            builder: (context, snapshot) {
                              if(!snapshot.hasData){
                                return Text("Loading...");
                              }
                              else{
                                TextEditingController feedctrl = TextEditingController(text:snapshot.data.result.toString().substring(0,4));
                                return Column(
                                      children: [
                                        SizedBox(height: 15),
                                        ListTile(
                                          leading: Container(
                                            width: 50,
                                            height: 50,
                                            decoration: BoxDecoration(
                                              image: DecorationImage(
                                                image: AssetImage(
                                                    'icons/flags/png/${flags[index].toLowerCase()}.png',
                                                    package: 'country_icons'),
                                                fit: BoxFit.cover,
                                              ),
                                              shape: BoxShape.circle,
                                            ),
                                          ),
                                          title: Text(
                                            "1 ${currencies[index]} = ${snapshot.data.result.toString().substring(0,4)} $_myCurrency",
                                            style: GoogleFonts.muli(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 15,
                                              
                                            ),
                                          ),
                                          trailing: IconButton(
                                            icon: Icon(Icons.calculate,
                                                color: selectedColor),
                                            onPressed: () {
                                              showDialog(
                                                context:context,
                                                barrierDismissible: true,

                                                builder: (context){
                                                  _calculatorController.text="1";
                                                  return Dialog(
                                                    insetPadding: EdgeInsets.symmetric(horizontal: 20,vertical:60),

                                                insetAnimationCurve: Curves.easeInOut,
                                                insetAnimationDuration: const Duration(milliseconds: 680),
                                                

                                                shape: RoundedRectangleBorder(
                                                  borderRadius: BorderRadius.circular(10),
                                                ),


                                                backgroundColor: Colors.transparent,

                                                    child:Container(
                                                      color:Colors.white,
                                                      child: Column(
                                                          mainAxisAlignment: MainAxisAlignment.center,
                                                          children: [
                                                            Padding(
                                                              padding: const EdgeInsets.all(8.0),
                                                              child: TextField(
                                                                textAlign: TextAlign.center,
                      controller:_calculatorController ,
                      keyboardType: TextInputType.number,
                      
                      onChanged: (value){




                        if(value.isNotEmpty){

                          setState(() {
                            
                            feedctrl.text = (double.parse(value)*double.parse(snapshot.data.result.toString().substring(0,4))).toString();
                          });

                        }
                        


                        else{
                          setState(() {
                            feedctrl.text=snapshot.data.result.toString().substring(0,4);
                           
                          });
                        }

                        


                      },
                      
                      
                      

           
                      decoration: InputDecoration(
                        hintText: '1',
                        
                        
                          
                         
                          labelText: _myCurrency,
                          
                         
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                          )),
                    ),
                                                            ),
                    SizedBox(height:15),
                    Text("=",style: TextStyle(fontSize: 25)),

                    SizedBox(height:15),


                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextField(
                        
                                              enabled: false,
                                              maxLines: null,
                                              controller: feedctrl,
                                              decoration: InputDecoration(
                                                
                                                border: OutlineInputBorder(),
                                                labelText: currencies[index],
                                              ),
                                              textAlign: TextAlign.center,
                                            ),
                    ),


                                                        ],),
                                                    )
                                                  );


                                                }


                                              );



                                            },
                                          ),
                                        ),
                                        SizedBox(height: 5),
                                        Divider(
                                          color: Colors.black,
                                          indent: 30,
                                          endIndent: 30,
                                        ),
                                      ],
                                    );
                              }
                            }
                          );
                        }
                      },
                    ),
                  ),
                ],
              ),
            )),
      ),
    );
  }
}

class CustomDialog extends StatefulWidget {
  @override
  _CustomDialogState createState() => _CustomDialogState();
}

class _CustomDialogState extends State<CustomDialog> {
  int x = 0;
  void stocker(int x) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt('lang', x);
  }

  void getter() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    setState(() {
      x = prefs.getInt('lang') ?? 1;
    });
  }

  dialogContent(BuildContext context, int v) {
    getter();

    // x = v;
    return SingleChildScrollView(
      child: Container(
        height: 300,
        decoration: new BoxDecoration(
          color: Colors.red[700],
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 10.0,
              offset: const Offset(0.0, 10.0),
            ),
          ],
        ),
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 20),
              child: Text(
                "Choose Language",
                style: GoogleFonts.tajawal(
                    textStyle: TextStyle(fontSize: 25, color: Colors.white)),
              ),
            ),
            RadioListTile(
              title: Text("English",
                  style: GoogleFonts.tajawal(
                      textStyle: TextStyle(color: Colors.white))),
              activeColor: Colors.white,
              value: 1,
              groupValue: x,
              onChanged: (value) {
                setState(() {
                  x = value;
                });
                stocker(value);
                Navigator.pop(context, 'en_US');
              },
            ),
            RadioListTile(
              title: Text("Français",
                  style: GoogleFonts.tajawal(
                      textStyle: TextStyle(color: Colors.white))),
              activeColor: Colors.white,
              value: 2,
              groupValue: x,
              onChanged: (value) {
                setState(() {
                  x = value;
                });
                stocker(value);
                Navigator.pop(context, 'fr');
              },
            ),
            RadioListTile(
              title: Text("Española",
                  style: GoogleFonts.tajawal(
                      textStyle: TextStyle(color: Colors.white))),
              activeColor: Colors.white,
              value: 3,
              groupValue: x,
              onChanged: (value) {
                setState(() {
                  x = value;
                });
                stocker(value);
                Navigator.pop(context, 'es');
              },
            ),
            RadioListTile(
              title: Text("Deutsche",
                  style: GoogleFonts.tajawal(
                      textStyle: TextStyle(color: Colors.white))),
              activeColor: Colors.white,
              value: 4,
              groupValue: x,
              onChanged: (value) {
                setState(() {
                  x = value;
                });
                stocker(value);
                Navigator.pop(context, 'ar');
              },
            ),
          ],
        ),
      ),
    );
  }

  int v;

  Future<int> getter1(int v) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    v = prefs.getInt('lang');

    return v;
  }

  @override
  void initState() {
    super.initState();
    getter();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      elevation: 0.0,
      backgroundColor: Colors.transparent,
      child: dialogContent(context, v),
    );
  }
}
