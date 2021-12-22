//import 'dart:html';
//import 'dart:html';
import 'dart:ui';

import 'package:calculator/util/hexcolor.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
class Calculator extends StatefulWidget {
  const Calculator({Key? key}) : super(key: key);

  @override
  _CalculatorState createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator> {

  int _tipPercentage = 0;
  int _personCounter = 1;
  double _billAmount = 0.00;

  Color _purple = HexColor("6908D6");


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: EdgeInsets.only(top: MediaQuery
            .of(context)
            .size
            .height * 0.1),
        alignment: Alignment.center,
        color: Colors.white,
        child: ListView(
          scrollDirection: Axis.vertical,
          padding: EdgeInsets.all(20.5),
          children: <Widget>[
            Container(
              width: 150,
              height: 150,
              decoration: BoxDecoration(
                color: _purple.withOpacity(0.1), //Colors.cyanAccent.shade100,
                borderRadius: BorderRadius.circular(12.0),
              ),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text("Total Per Person", style: TextStyle(
                        fontWeight: FontWeight.normal,
                        fontSize: 15.0,
                        color: _purple
                    ),),
                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Text("\$ ${ calculateTotalPerPerson(_billAmount, _personCounter,_tipPercentage)}", style: TextStyle(
                          fontSize: 34.9,
                          fontWeight: FontWeight.bold,
                          color: _purple
                      ),),
                    )
                  ],
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 20),
              padding: EdgeInsets.all(12.0),
              decoration: BoxDecoration(
                  color: Colors.transparent,
                  border: Border.all(
                      color: Colors.blueGrey.shade100,
                      style: BorderStyle.solid
                  ),
                  borderRadius: BorderRadius.circular(12.0)
              ),
              child: Column(
                children: <Widget>[
                  TextField(
                    keyboardType: TextInputType.numberWithOptions(
                        decimal: true),
                    style: TextStyle(color: _purple),
                    decoration: InputDecoration(
                        prefixText: "Bill Amount",
                        prefixIcon: Icon(Icons.attach_money)
                    ),
                    onChanged: (String value) {
                      try {
                        _billAmount = double.parse(value);
                      } catch (exception) {
                        _billAmount = 0.00;
                      }
                    },
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text("Split", style: TextStyle(
                          color: Colors.grey.shade700
                      ),),
                      Row(
                        children: <Widget>[
                          InkWell(
                            onTap: () {
                              setState(() {
                                if (_personCounter > 1) {
                                  _personCounter--;
                                } else {
                                  //do nothing

                                }
                              });
                            },
                            child: Container(
                              width: 40.0,
                              height: 40.0,
                              margin: EdgeInsets.all(10.0),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(7.0),
                                  color: _purple.withOpacity(0.1)
                              ),
                              child: Center(
                                child: Text(
                                  "_", style: TextStyle(
                                    color: _purple,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 17.0
                                ),
                                ),
                              ),
                            ),
                          ),
                          Text("$_personCounter", style: TextStyle(
                              color: _purple,
                              fontWeight: FontWeight.bold,
                              fontSize: 17.0
                          ),),

                          InkWell(
                            onTap: () {
                              setState(() {
                                _personCounter++;
                              });
                            },
                            child: Container(
                              width: 40.0,
                              height: 40.0,
                              margin: EdgeInsets.all(10.0),
                              decoration: BoxDecoration(
                                  color: _purple.withOpacity(0.1),
                                  borderRadius: BorderRadius.circular(7.0)
                              ),
                              child: Center(
                                child: Text("+", style: TextStyle(
                                    color: _purple,
                                    fontSize: 17.0,
                                    fontWeight: FontWeight.bold
                                ),),
                              ),
                            ),
                          ),

                        ],
                      ),

                    ],

                  ),
                  //Tip
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text("Tip", style: TextStyle(
                          color: Colors.grey.shade700
                      ),),
                      Padding(
                        padding: const EdgeInsets.all(18.0),
                        child: Text("\$ ${(calculateTotalTip(_billAmount,
                            _personCounter, _tipPercentage)).toStringAsFixed(2)}", style: TextStyle(
                            color: _purple,
                            fontWeight: FontWeight.bold,
                            fontSize: 17.0
                        ),),
                      )
                    ],
                  ),

                  //Slider
                  Column(
                    children: <Widget>[
                      Text("$_tipPercentage%", style: TextStyle(
                          color: _purple,
                          fontSize: 17.0,
                          fontWeight: FontWeight.bold
                      ),),

                      Slider(
                          min: 0,
                          max: 100,
                          activeColor: _purple,
                          inactiveColor: Colors.grey,
                          divisions: 10,
                          //optional
                          value: _tipPercentage.toDouble(),
                          onChanged: (double newValue) {
                            setState(() {
                              _tipPercentage = newValue.round();
                            });
                          })
                    ],

                  )


                ],
              ),
            )

          ],
        ),
      ),
    );
  }

  calculateTotalPerPerson(double billAmount, int splitBy, int tipPercentage) {

    var totalPerPerson = (calculateTotalTip(billAmount, splitBy,tipPercentage)+ billAmount) /splitBy;

    return totalPerPerson;

  }

  calculateTotalTip(double billAmount, int splitBy, int tipPercentage) {
    double totalTip = 0.00;

    if (_billAmount < 0 || billAmount
        .toString().isEmpty || _billAmount == null) {
      //no go!

    }else {
      totalTip = (billAmount * _tipPercentage) / 100;

    }

    return totalTip;
  }
}

