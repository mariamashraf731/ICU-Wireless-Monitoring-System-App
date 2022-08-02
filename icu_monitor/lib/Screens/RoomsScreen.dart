
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:icu_monitor/Screens/login.dart';
import 'package:icu_monitor/Screens/signup.dart';
import 'package:icu_monitor/Screens/PatientsPage.dart';
import 'package:icu_monitor/constants.dart';

import 'package:icu_monitor/widgets/Classes.dart';
import '/widgets/card_widget.dart';

late int RoomId;
final dbRef = FirebaseDatabase.instance.reference();
List<RoomsClass> rooms = [(RoomsClass(patients: [(Patients( pressure: 0, temperature: 0, patientid: -1))], roomid: -1)),(RoomsClass(patients: [(Patients( pressure: 0, temperature: 0, patientid: -1))], roomid: -1))];



class Rooms extends StatefulWidget {
  const Rooms({Key? key}) : super(key: key);
  
  @override
  State<Rooms> createState() => _RoomsState();
}

class _RoomsState extends State<Rooms> {
  @override
  Widget build(BuildContext context) {
      
      int time=0;
      return Scaffold(
      appBar: AppBar(
        backgroundColor: kPrimaryColor,
        title: Text('Hello Doctor',style: TextStyle(fontSize: 16),),
   
      ),
      body:
      StreamBuilder(
          stream: dbRef.child('ICU').onValue,
          builder: (context, snapshot) {
            if(snapshot.connectionState == ConnectionState.waiting)
            {return const Center(child: CircularProgressIndicator());}
            else if(snapshot.hasData && !snapshot.hasError && snapshot.data != null) 
            {   dynamic data=snapshot.data;
              dynamic Data = data.snapshot.value;

               
              //print('data ${Data['ROOMS']}');

              List<RoomsClass> UpdateRooms(){
                for(int roomid =0;roomid < Data['ROOMS'].length;roomid++){
                  List patients=Data['ROOMS'][roomid]['patients'];
                  print('data ${patients}');
                  List<Patients> patientslist=[];
                  for(int patientid =0;patientid < patients.length;patientid++){
                   
                    patientslist.add(Patients( pressure: patients[patientid]['pressure'], temperature: patients[patientid]['temp'], patientid: patientid));
                  
                  }
                  rooms[roomid]=RoomsClass(patients: patientslist, roomid: roomid);
                }
                time++;
                return rooms;
              }

              UpdateRooms();

              print('room 0 patients no are ${rooms[0].patients.length}');
              for(int i =0;i< rooms[0].patients.length;i++){
          
                print('patient id ${rooms[0].patients[i].patientid},'
                    'temp = ${rooms[0].patients[i].temperature},'
                    'pressure= ${rooms[0].patients[i].pressure}');
              }
              return
                Column(
                  children: rooms.map((room)=> RoomsCard(
                    show: (){
                      RoomId=room.roomid;
                      print(RoomId);
                      Navigator.push(context,MaterialPageRoute(builder: (context) => const PatientsPage()));
                    },
                    roomid: room.roomid,)).toList(),
                );
              
              }
            else {return const Center(child:  Text('something went wrong'),);}
          }
      )
      );
  }
  
}

