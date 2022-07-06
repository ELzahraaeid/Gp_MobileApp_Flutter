import 'package:flutter/cupertino.dart';
import 'package:vibration/vibration.dart';
import 'package:torch_light/torch_light.dart';




class MQTTAppState with ChangeNotifier{

  int _bell = 0;
  int _baby = 0;
  int _microwave = 0;
  int _fire = 0;
  int _id = -1;
  String status = "";
  // var funAraa = [turnOnFlash , turnOffFlash];

  void setReceivedText(String message) {
    var messages = message.split(", ");
    var values = {};
    messages.forEach((element) => values[ element.split(":")[0]] =  element.split(":")[1]);
    switch(values["device"]){
      case "bell":
      if(_id != -1){
        _bell = int.parse(values["message"]);
        _notify(_bell);
      } 
        break;
      case "baby" :
      if(_id != -1){
         _baby = int.parse(values["message"]);
        _notify(_baby);
      }
        break;
      case "microwave" :
        if(_id != -1){
          _microwave = int.parse(values["message"]);
         _notiFyMicrowave(_microwave);
        }
        break;
      case "fire" :
        if(_id != -1){
          _fire = int.parse(values["message"]);
        _notify(_fire);
        }
        break;
      case "login" :
        if(_id == -1){
          _id = int.parse(values["message"]);
          int.parse(values["message"])== -1? status="Wrong username or password" : ""; 
          notifyListeners();
        }
        break;
      default:
        print(values);
        break;
    }
    print('subscribed messages is ...... $message');
    if(_id != -1){
      notifyListeners();
    }
  }
  

  int get getBell => _bell;
  int get getBaby => _baby;
  int get getMicrowave => _microwave;
  int get getFire => _fire;
  int get getId => _id;

  void setId(int x) { 
    _id = x;
    notifyListeners();
    }
  void vibrateMobile() async {
    if (await Vibration.hasVibrator()) { //check if device has vibration feature
          Vibration.vibrate(duration: 3000); //500 millisecond vibration
    }
  }
  void turnOnFlash() async{
    try {
        await TorchLight.enableTorch();
      } on Exception catch (_) {
      }
  }
  void turnOffFlash() async {
    try {
      await TorchLight.disableTorch();
    } on Exception catch (_) {
    }
  }
  void _notify(int value){
    if(_id != -1){
      if(value == 1){
      turnOnFlash();
      vibrateMobile();
    }
    else if(value == 0 && _bell == 0 && _baby == 0 && _fire == 0){
      turnOffFlash();
    }
    }
    // else{
    //   turnOnFlash();
    //   vibrateMobile();
    // }
  }
  void _notiFyMicrowave(int value){
    if(_id != -1){
      if(value == 1 && _bell == 0 && _baby == 0 && _fire == 0){
      turnOffFlash();
    }
    else{
      turnOnFlash();
      vibrateMobile();
     
    }
    }
  }

  void logout(){
    int _bell = 0;
  int _baby = 0;
  int _microwave = 0;
  int _fire = 0;
  int _id = -1;
  String status = ""; 
  turnOffFlash();
  notifyListeners();
  }
}