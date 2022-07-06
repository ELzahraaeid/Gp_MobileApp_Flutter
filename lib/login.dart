import 'dart:io' show Platform;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:testproject/MQTTAppState.dart';
import 'package:testproject/MQTTManager.dart';
 
class Login extends StatelessWidget {
  
  const Login({Key? key}) : super(key: key);
 
  static const String _title = 'Smart Home';
 
  @override
  Widget build(BuildContext context) {
    
    return MaterialApp(
      title: _title,
       
      home: Scaffold(
        appBar: AppBar(title: const Text(_title),
        centerTitle: true,
        leading: Icon(Icons.home),
        backgroundColor: Color.fromARGB(255, 58, 92, 60),
        elevation: 10,
        shadowColor: Color.fromARGB(255, 8, 61, 39),
        ),
        
        body: Container(color:Color.fromARGB(255, 233, 193, 132),width: double.infinity,height: double.infinity, 
                        child:const MyStatefulWidget(),
                         ),
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}
 
class MyStatefulWidget extends StatefulWidget {
  const MyStatefulWidget({Key? key}) : super(key: key);
 
  @override
  State<MyStatefulWidget> createState() => _MyStatefulWidgetState();
}
 
class _MyStatefulWidgetState extends State<MyStatefulWidget> {
  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
   late MQTTAppState currentAppState;
    late MQTTManager manager;
    String _state ='';
  
 
  @override
  Widget build(BuildContext context) {
     final MQTTAppState appState = Provider.of<MQTTAppState>(context);
    // Keep a reference to the app state.
    currentAppState = appState;
    _state = currentAppState.status ;
     _configureAndConnect();
    return Padding(
        padding: const EdgeInsets.all(10),
        child: ListView(
          children: <Widget>[
            
            Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.all(10),
                child: const Text(
                  'Sign in',
                  style: TextStyle(fontSize: 20),
                )),
            Container(
              padding: const EdgeInsets.all(10),
              child: TextFormField(
                validator:(value) {
                    if (value!.isEmpty) {
                    return 'Please enter some text';
                    }
                return null;
                }, 
                controller: nameController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'User Name',
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
              child: TextField(
                obscureText: true,
                controller: passwordController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Password',
                ),
              ),
            ),
            Expanded(flex: 1, child:Container(
                height: 65,
                width: 100,
                padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Color.fromARGB(255, 92, 146, 113)
                  ),
                  child: const Text('Login'),
                  // style: TextStyle(fontSize: 40),),
                  
                  onPressed: () {  
                    manager.publish("iot_intake42/ITI/login", 'email:${nameController.text}, password:${passwordController.text}');
                 
                  },
                )
            ),),
            Container(child: Text(
                          _state,
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Colors.red),
                          )),
            
          ],
        ));
  }
  void _configureAndConnect() {
    String osPrefix = 'Flutter_iOS';
    if (Platform.isAndroid) {
      osPrefix = 'Flutter_Android';
    }
    manager = MQTTManager(
        host : "learning.masterofthings.com",
        topic : "iot_intake42/ITI/#",
        identifier: osPrefix,
        state: currentAppState);
    manager.initializeMQTTClient();
    manager.connect();
  }
}