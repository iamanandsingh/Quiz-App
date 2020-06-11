import 'package:flutter/material.dart';
import 'quiz_brain.dart';
import 'package:rflutter_alert/rflutter_alert.dart';


Quizbank quizbank=Quizbank();
void main() {
  runApp(App());
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
      backgroundColor: Colors.orange,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Quiz(),
      ),
    ));
  }
}

class Quiz extends StatefulWidget {
  @override
  _QuizState createState() => _QuizState();
}

class _QuizState extends State<Quiz> {
  List<Icon> score=[];
  void scorekeeper(bool useranswer)
  {
    bool correctans=quizbank.getanswer();
    setState(() {

      if(quizbank.finished()==true)
        {
          Alert(
            context: context,
            type: AlertType.success,
            title: "ALERT",
            desc: "You have completed the quiz.",
            buttons: [
              DialogButton(
                child: Text(
                  "OK",
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
                onPressed: () => Navigator.pop(context),
                width: 120,
              )
            ],
          ).show();

          quizbank.reset();
          score=[];
        }
else {
        if (correctans == useranswer) {
          score.add(Icon(Icons.check, color: Colors.green,),);
          quizbank.correct();
        }
        else {
          score.add(Icon(Icons.close, color: Colors.red,),);
        }

        quizbank.nextquestion();
      }
    });

        }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          
          Expanded(
              flex: 5,
              child: Container(
                child: Center(
                  child: Text(
                    quizbank.getquestion(),
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight:FontWeight.bold,
                      fontSize: 30,
                    ),
                  ),
                ),
              )),
              Expanded(
            flex: 2,
            child:Center(
              child: RichText(
                text: TextSpan(
                  children: [ 
                    TextSpan(
                      text: quizbank.displayanswer(),
                            style: TextStyle(fontSize: 50,
                            color: Colors.white), ),
                       TextSpan(
                      text: 'Answers are correct',
                            style: TextStyle(fontSize: 20,
                            color: Colors.white), ),     
                             
                  ],
                          )
              )
            ),
          ),
         
           Expanded(
                 flex: 1,
                 child: Container(
               padding: EdgeInsets.all(1),
                 width: double.infinity,
               child: RaisedButton(
                 elevation: 9,
                 color: Colors.green,
                 onPressed: () {
                   scorekeeper(true);
                 },
                   child: Text(
                         "True",
                         textAlign: TextAlign.center,
                         style: TextStyle(
                           color: Colors.white,
                           fontSize: 25,
                         ),
                   ),
                 shape: RoundedRectangleBorder(
                   borderRadius: BorderRadius.circular(80),
                 ),
               ),
             ),
           ),

           SizedBox(
             child: Padding(padding:EdgeInsets.all(8)),
           ),
           Expanded(
             flex: 1,
                        child: Container(
               padding: EdgeInsets.all(1),
                 width: double.infinity,
               child: RaisedButton(
                 elevation: 9,
                 color: Colors.red,
                 onPressed: () {
                   scorekeeper(false);
                 },
                   child: Text(
                         "False",
                         textAlign: TextAlign.center,
                         style: TextStyle(
                           color: Colors.white,
                           fontSize: 25,
                         ),
                   ),
                 shape: RoundedRectangleBorder(
                   borderRadius: BorderRadius.circular(80),
                 ),
               ),
             ),
           ),
          Row(
            children:score,
          ),
        ],
      ),
    );
  }
}
