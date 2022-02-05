import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class SwitchPage extends StatefulWidget {
  const SwitchPage({Key? key}) : super(key: key);

  @override
  _SwitchPageState createState() => _SwitchPageState();
}

class _SwitchPageState extends State<SwitchPage> {
  bool isSwitched = false;
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  CollectionReference irrigation = FirebaseFirestore.instance.collection('irrigation');

  void setIsSwitched(String _value){
    setState(() {
      if(_value == 'true'){
        isSwitched = true;
      } else {
        isSwitched = false;
      }
    });

  }

  void initState(){
    irrigation.doc("Harbiq84b3LeyVzPL8QE").get().then((value) =>{
      setIsSwitched(value.get('state').toString()),
    }).then((value) => print("State $isSwitched"));

    //Listener para mudar o isSwitched ao acontecer mudança no banco de dados
    irrigation.snapshots().listen((event) {

      event.docChanges.forEach((element) {
        print("Database state was changed to "+ element.doc.get('state').toString());
        setIsSwitched(element.doc.get('state').toString());
      });
    });
  }

  //Muda o estado no banco de dados
  Future<void> changeState(bool value){
    return irrigation.doc('Harbiq84b3LeyVzPL8QE').update({
      'state':value
    }).then((value) => print("State changed!")).catchError((error)=>{print("Failed $error")});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Switch(
            value: isSwitched,
            onChanged: (value){
              setState(() {
                changeState(value);
                isSwitched = value;
              });
            },
            activeTrackColor: Colors.lightGreenAccent,
            activeColor: Colors.green,
          )
      ),
    );
  }
}
