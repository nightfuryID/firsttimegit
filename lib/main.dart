import 'dart:convert';

import 'package:flutter/material.dart';

void main() => runApp(myApp());

class myApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Converter(),
    );
  }
}

class Converter extends StatefulWidget {

  @override
  State<Converter> createState() => _ConverterState();
}

class _ConverterState extends State<Converter> {
  @override

  void initState(){

    userInput=0;
    super.initState();
  }

      final List<String> measures =[
          'kilometers km',
          'Meters m',
          'kilograms kg',
          'Grams g',
          'feet ft',
          'Miles',
          'pounds lbs',
          'ounces',
     ];

  final Map<String,int>measuresMap
  ={
    'kilometers km':0,
    'Meters m':1,
    'kilograms kg':2,
    'Grams g':3,
    'feet ft':4,
    'Miles':5,
    'pounds lbs':6,
    'ounces':7,
  };
  dynamic formulas ={

    '0':[1000,1,0,0,3280.84,0,6213,0,0],
    '1':[1,0.001,0,0,3.280,0.0006213,0],
    '2':[0,0,1000,1,0,0,2.2046,35.274],
    '3':[0,0,1,0.0001,0,0,0.00220,0.03],
    '4':[0.0348,0.00030,0,0,1,0.000189],
    '5':[1609.34,1.60934,0,05280,1,0,0],
    '6':[0,0,453.592,0.4535,0,0,1,16],
    '7':[0,0,28.3495,0.02834,3.28084,0,0.1]
  };
  void convert (double value, String from,String to )
  {
    int? nFrom=measuresMap[from];
    int? nTo=measuresMap[to];
    var multi=formulas[nFrom.toString()][nTo];
    var result=value * multi;

   setState(() {
     if (result == 0){
       resultMessage='cannot perform this conversion';
     }else{
       resultMessage = '$userInput $_startMeasures are $result $_convertMeasures';
     }
   });

    setState(() {
      resultMessage=resultMessage;
    });

  }




  double? userInput;
  String? _startMeasures;
  String? _convertMeasures;
  String? resultMessage;


  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
        title: Text('unit converter'),
    centerTitle: true,
    backgroundColor: Colors.greenAccent,
    ),
      body: Center(child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 30),
      child: Column(children: [Padding(
        padding: const EdgeInsets.symmetric(vertical:20.0,horizontal: 40),
        child: TextField(
          onChanged: (text){

            var input=double.tryParse(text);
            if(input != null)
              setState(() {
                userInput=input;
              });


          },
          style: TextStyle(
            fontSize: 22.0,
              color: Colors.black
          ),
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.white,
            hintText: 'enter your value',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20.0)
            )
          ),
        ),
      ),
        SizedBox(
          height: 10,
        ),
        Text('from',style: TextStyle(fontSize: 20,color: Colors.black),),
       Padding(padding: const EdgeInsets.symmetric(vertical: 10,horizontal: 40),
           child: Container(
          padding: EdgeInsets.symmetric(horizontal: 10),
          decoration: BoxDecoration(
            color: Colors.greenAccent,
            borderRadius: BorderRadius.circular(20.0)
          ),
          child: DropdownButton(
            value: _startMeasures,
          isExpanded : true,
          dropdownColor: Colors.greenAccent,
          style: TextStyle(fontSize: 20.0,fontWeight: FontWeight.w700),
          hint: Text('Choose a unit', style:  TextStyle(color: Colors.black,fontSize: 20.0),),
          items: measures.map(( String value){
          return DropdownMenuItem(value: value,
          child: Text(value),);
        } ).toList(),

onChanged: (value) {
            setState(() {
              _startMeasures=value;
            });
},
        ),
       )
      ),
        SizedBox(height: 10,),
        Text('to',style: TextStyle(fontSize: 20,color: Colors.black),),
        Padding(padding: const EdgeInsets.symmetric(vertical: 10,horizontal: 40),
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 10),
              decoration: BoxDecoration(
                  color: Colors.greenAccent,
                  borderRadius: BorderRadius.circular(20.0)
              ),
              child: DropdownButton(
                value: _convertMeasures,
                isExpanded : true,
                dropdownColor: Colors.greenAccent,
                style: TextStyle(fontSize: 20.0,fontWeight: FontWeight.w700),
                hint: Text('Choose a unit', style:  TextStyle(color: Colors.black,fontSize: 20.0),),
                items: measures.map(( String value){
                  return DropdownMenuItem(value: value,
                    child: Text(value),);
                } ).toList(),

                onChanged: (value) {
                  setState(() {
                    _convertMeasures=value;
                  });
                },
              ),
            )
        ),
        SizedBox(height: 10,),
       TextButton(onPressed: (){
         if(_startMeasures != null && _convertMeasures!=null && userInput!=0)
           return;
         else
           convert(userInput!, _startMeasures!, _convertMeasures!);


       },
       child: Container(
         alignment: AlignmentDirectional.center,
          width: 200,height: 50,decoration: BoxDecoration(
          color: Colors.greenAccent,borderRadius: BorderRadius.circular(20.0)
        ),
          child: Text('press for answer',style: TextStyle(fontWeight: FontWeight.w700,fontSize: 23,color: Colors.black),
          ),
        ),
       ),
        SizedBox(height: 15,),
        Container(alignment: AlignmentDirectional.center,
        width: 200,height: 50,decoration: BoxDecoration(color: Colors.lightBlueAccent,borderRadius: BorderRadius.circular(20)),
          child:  Text(
            resultMessage ?? 'result',
            style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.w700,color: Colors.black),
          )
        ),

        ],
      ),
      ),
    ),
    );
  }
}

