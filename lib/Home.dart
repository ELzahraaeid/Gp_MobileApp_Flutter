import 'dart:io' show Platform;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:testproject/MQTTAppState.dart';
import 'package:testproject/MQTTManager.dart';

class Home extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // return _MQTTViewState();/
    return _HomeState();
  }
}


class _HomeState extends State<Home> {
  
 late MQTTAppState currentAppState;
  late MQTTManager manager;
  List<String> BellImgs = ['images/silentBell.png','images/activeBell.gif'];

  List<String> OvenImgs = ['images/closedOven.jpg','images/cook.gif'];

  List<String> babyImgs = ['images/sleep.png','images/cry.gif'];

  List<String> fireImages = ['images/safe.jpeg','images/fire.gif'];
  
  @override
  Widget build(BuildContext context) {
   
    final MQTTAppState appState = Provider.of<MQTTAppState>(context);
    // Keep a reference to the app state.
    currentAppState = appState;
    //  _configureAndConnect();
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Smart Home'),
          centerTitle: true,
          leading: Icon(Icons.person),
          // actions: [
          //   IconButton(onPressed: (){ 
          //                             manager.disconnect();
          //                             currentAppState.logout();
                                      
                                      
          //                             }
          //                             , icon:Icon(Icons.logout) )
          // ],
          backgroundColor: Color.fromARGB(255, 58, 92, 60),
          elevation: 10,
          shadowColor: Color.fromARGB(255, 8, 61, 39),
        ),
        body: Container(color:Color.fromARGB(255, 233, 193, 132),width: double.infinity,height: double.infinity,
                child: Column(children: [
                  Row(
                    children: [
                       Expanded(flex: 1, child: Container(margin: EdgeInsets.fromLTRB(10,80,10,10),width:180 ,height:200 , decoration: BoxDecoration(
                          color: Color.fromARGB(255, 192, 154, 96),
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(color:Color.fromARGB(255, 163, 130, 80) ),
                          image: DecorationImage(image: AssetImage((BellImgs[currentAppState.getBell])))
                         ), )),
                      Expanded(flex: 1, child: Container(margin: EdgeInsets.fromLTRB(10,80,10,10) ,height:200 ,decoration: BoxDecoration(
                          color: Color.fromARGB(255, 192, 154, 96),
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(color:Color.fromARGB(255, 163, 130, 80) ),
                          image: DecorationImage(image: AssetImage(OvenImgs[currentAppState.getMicrowave]))
                         ), ))
                 ],
                  ),
                  Row(
                    children: [
                      Expanded(flex: 1, child: Container( margin:EdgeInsets.all(10),width:180 ,height:200 ,decoration: BoxDecoration(
                          color: Color.fromARGB(255, 192, 154, 96),
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(color:Color.fromARGB(255, 163, 130, 80) ),
                          image: DecorationImage(image: AssetImage(babyImgs[currentAppState.getBaby]))
                         ),)),

                       Expanded(flex: 1, child:  Container(margin:EdgeInsets.all(10),width:180 ,height:200 ,decoration: BoxDecoration(
                          color: Color.fromARGB(255, 192, 154, 96),
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(color:Color.fromARGB(255, 163, 130, 80) ),
                          image: DecorationImage(image: AssetImage(fireImages[currentAppState.getFire]))
                         ),)),
                 ],
                  )
                ],)
              ),
              
              bottomNavigationBar: Container(
                height: 50, color: Colors.yellow,
                child: Column(children: [
                  Text('MasterOfThings',
                  style: TextStyle(fontSize: 25, color: Colors.brown[700]),),
                ]),
              ),
      ),
      debugShowCheckedModeBanner: false,
    );
    
  }
  

  void _disconnect() {
    manager.disconnect();
  }

  
}














