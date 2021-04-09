
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:o_color_picker/o_color_picker.dart';
import 'package:http/http.dart' as http;

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

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

Color selectedColor = Colors.blue;
String _myCurrency;

String _trimCurrency(String ch){
  return ch.substring(0,2).toLowerCase();
}




Future<String> _getCurrentCurrency()async{

await http.read('https://ipapi.co/currency/',headers : {'User-agent': 'your bot 0.1'}).then((value) => {
  setState((){
    _myCurrency = value;
  }),
print("currency is : "+value),
});

  
return "TND";


}

@override
  void initState() {
    
    super.initState();
    _getCurrentCurrency();
    
  }







  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: selectedColor,
      appBar: AppBar(
        backgroundColor: selectedColor,
        actions: [
          IconButton(
            icon:Icon(Icons.translate),
            onPressed: (){
              _getCurrentCurrency();
            },
          ),
        
        ],
        leading: IconButton(
            icon:Icon(Icons.color_lens),
            onPressed: (){
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
        title: Text("My Dollar",
          style: GoogleFonts.muli(),
),
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          // margin:EdgeInsets.symmetric(horizontal: 10),
            height:MediaQuery.of(context).size.height-20,
          // padding: EdgeInsets.only(top:30),
          decoration: BoxDecoration(
            color:Colors.white,
            border: Border.all(color:Colors.white,width:1),
            borderRadius: BorderRadius.circular(20),
          ),
          child:SingleChildScrollView(
                      child: Column(
              children: [
                SizedBox(width: MediaQuery.of(context).size.width,),
                Align(
                  alignment: Alignment.centerLeft,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    // mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Container(
                    
                    height:80,
                    width:120,
                    decoration:BoxDecoration(
                      border: Border.all(color:Colors.transparent,width: 1),
                      // color:Colors.black,
                      borderRadius: BorderRadius.circular(15),
                      image: DecorationImage(
                        image: 
                        AssetImage('icons/flags/png/${_trimCurrency(_myCurrency).toLowerCase()}.png', package: 'country_icons'),
                        fit: BoxFit.cover,
                      ),
               


                    ),
                    // child:Flag('TN',fit: BoxFit.cover,)
                  ),
                  SizedBox(width:15),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Country Code: ${_trimCurrency(_myCurrency).toUpperCase()}",style: GoogleFonts.muli(),),
                      SizedBox(height:5),
                       Text("Currency: ${_myCurrency.toUpperCase()}",style: GoogleFonts.muli(),),
                    ],
                  ),
                                    ],
                                  ),
                                ),
                ),
                Divider(
                  color:Colors.black,
                  indent: 30,
                  endIndent: 30,
                ),
                SizedBox(height:15),
             
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: TextField(
                    
               
                  // controller: teSeach,
                  decoration: InputDecoration(
                    
                    
                    hintText: 'Search for currency',
                    labelText: 'Search',
                                      suffixIcon: IconButton(
                        icon:Icon(Icons.search),
                        onPressed: (){},

                      ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    )
                  ),
              ),
                ),
                

                 SizedBox(height:5),
                 Container(
                   height:300,
                   child: ListView.builder(
                     itemCount: countries.length,
                     itemBuilder: (context,index){

                       if(currencies[index]==_myCurrency){
                         return SizedBox();



                       }
                       else{
                         return Column(
                         children: [
                           SizedBox(height:15),
                           ListTile(
                    leading: Container(
                      width: 60,
                      height:60,
                      decoration: BoxDecoration(
                            image: DecorationImage(
                              image: 
                              AssetImage('icons/flags/png/${flags[index].toLowerCase()}.png', package: 'country_icons'),
                              fit: BoxFit.cover,
                            ),
                            shape: BoxShape.circle,
                            
                      ),
                    ),
                    title: Text("1 ${currencies[index]} = 50 DZD",style: GoogleFonts.muli(),),
                    trailing: IconButton(
                      icon:Icon(Icons.calculate,color:selectedColor),
                      onPressed: (){},
                    ),

                ),
                SizedBox(height:5),
                 Divider(
                  color:Colors.black,
                  indent: 30,
                  endIndent: 30,
                ),

               
                         ],
                       );


                       }





                       
                     },

                   
                   ),
                 ),

                


              ],
            ),
          )

        ),
      ),
      
    );
  }
}