import 'package:flutter/material.dart';
import 'dart:math';
import 'package:google_fonts/google_fonts.dart';
import 'package:os_project/inputpages.dart';

int hit5 = 0;
int fault5 = 0;
List <List> toprint5 = new List();
List <int> fault5_arr = new List();
List <int> hit5_arr = new List();

int randomalgo(List <int> pages, int n, int capacity) {
  List<int> s = new List();
  int pagefault = 0;
  int hit = 0;
  var j = new Random();
  for (int i = 0; i < n; i++) {
    List<int> s1 = new List();
    int n = j.nextInt(capacity);
    if (s.length < capacity) {
      if (!s.contains(pages[i])) {
        print(s);
        s.add(pages[i]);
        s1.addAll(s);
        for (int j = 0; j < capacity - s.length; j++) {
          s1.add(null);
        }
        toprint5.add(s1);
        pagefault++;
      }
    } else {
      if (s.contains(pages[i])) {
        s1.addAll(s);
        for (int j = 0; j < capacity - s.length; j++) {
          s1.add(null);
        }
        toprint5.add(s1);
        hit++;
      } else {
        s.removeAt(n);
        s.insert(n, pages[i]);
        s1.addAll(s);
        for (int j = 0; j < capacity - s.length; j++) {
          s1.add(null);
        }
        toprint5.add(s1);
        pagefault++;
      }
    }
  }
  print(hit);
  return pagefault;
}


class RANDOM extends StatefulWidget {
  @override
  _RANDOMState createState() => _RANDOMState();
}

class _RANDOMState extends State<RANDOM> {

  int click = 0;
  int pclick = 1;
  final int length = toprint5.length;

  Widget createTable() {
    List<TableRow> rows = [];
    rows.add(
        TableRow(
            children: <Widget> [
              Text("Pages",style: GoogleFonts.montserrat(fontSize: 25.0,color: Colors.orange), textAlign: TextAlign.center,),
            ]
        )
    );
    for (int i = 0; i < frame_capacity; i++) {
      if(click == 0)
        rows.add(
            TableRow(
                children: <Widget> [
                  Text(toprint5.elementAt(click).elementAt(i).toString(), style: GoogleFonts.montserrat(fontSize: 25.0,color: Colors.red), textAlign: TextAlign.center,),
                ]
            )
        );
      else if(toprint5.elementAt(click-1).contains(toprint5.elementAt(click).elementAt(i)))
        rows.add(
            TableRow(
                children: <Widget> [
                  Text(toprint5.elementAt(click).elementAt(i).toString(), style: GoogleFonts.montserrat(fontSize: 25.0,color: Colors.green), textAlign: TextAlign.center,),
                ]
            )
        );
      else{
        rows.add(
            TableRow(
                children: <Widget> [
                  Text(toprint5.elementAt(click).elementAt(i).toString(), style: GoogleFonts.montserrat(fontSize: 25.0,color: Colors.red), textAlign: TextAlign.center,),
                ]
            )
        );
      }
    }
    return Table(children: rows);
  }


  showAlertDialog(BuildContext context) {
    Widget cancelButton = FlatButton(
      child: Text("EXIT"),
      onPressed:  () {
        Navigator.push(context, MaterialPageRoute(builder: (context)=> GetTextFieldValue()),);
        frame_capacity = 0;
        pagesEntryTextBox.text = '';
        pageCapacityTextBox.text = '';
        pages_arr.clear();
        toprint5.clear();
      },
    );

    Widget continueButton = FlatButton(
      child: Text("STAY"),
      onPressed:  () {
        return _RANDOMState();
      },
    );

    AlertDialog alert = new AlertDialog(
      title: Text("PROCESS COMPLETED"),
      content: Text("YOU HAVE REACHED END OF THE ALGORITHM WHAT WOULD YOU LIKE TO DO?"),
      actions: [
        cancelButton,
        continueButton,
      ],
    );

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget> [
            Padding(
                padding: EdgeInsets.fromLTRB(8, 8, 8, 10),
                child : Text('Click on arrows to see sets', style: GoogleFonts.montserrat(fontSize: 25.0,color: Colors.orange))
            ),
            Padding(
                padding: EdgeInsets.fromLTRB(8, 8, 8, 40),
                child : Text('Set: $pclick / $length', style: GoogleFonts.montserrat(fontSize: 25.0,color: Colors.orange))
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(8, 8, 8, 40),
              child : createTable(),
            ),
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.center,
            //   children: <Widget> [
            //     Padding(
            //       padding: EdgeInsets.fromLTRB(8, 8, 8, 8),
            //       child : Text(hit1_arr.elementAt(1).toString(), style: GoogleFonts.montserrat(fontSize: 25.0,color: Colors.orange)),
            //     ),
            //     Padding(
            //       padding: EdgeInsets.fromLTRB(8, 8, 8, 8),
            //       child : Text(fault1_arr.elementAt(1).toString(), style: GoogleFonts.montserrat(fontSize: 25.0,color: Colors.orange)),
            //     ),
            //   ],
            // ),
            Row (
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget> [
                IconButton(
                  icon: Icon(Icons.arrow_back),
                  onPressed: () {
                    setState(() {
                      if(click > 0) {
                        click--;
                        pclick--;
                      }
                    });
                  },
                ),
                Padding(
                  padding: EdgeInsets.all(40),
                ),
                IconButton(
                  icon: Icon(Icons.arrow_forward),
                  onPressed: () {
                    print(fault5_arr);
                    setState(() {
                      if(toprint5.length > click+1) {
                        click++;
                        pclick++;
                      }
                      else {
                        showAlertDialog(context);
                      }
                    });
                  },
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}