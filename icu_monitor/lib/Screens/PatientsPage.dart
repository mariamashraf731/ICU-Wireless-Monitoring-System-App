import 'package:flutter/material.dart';
import '../Screens/RoomsScreen.dart';
import '../Screens/PatientVitals.dart';
import '../Screens/login.dart';
import '/constants.dart';

int proomid=RoomId;
late int PatientId;
class PatientsPage extends StatefulWidget {
  const PatientsPage({Key? key}) : super(key: key);

  @override
  State<PatientsPage> createState() => _PatientsPageState();
}

class _PatientsPageState extends State<PatientsPage> {

  @override
  void initstate(){
    super.initState();
    setState(() {
      proomid=RoomId;
      print(  proomid);
    });
  }
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: dbRef.child('ICU').onValue,
        builder: (context, snapshot) {
          if (snapshot.hasData && !snapshot.hasError && snapshot.data != null) {
            dynamic data = snapshot.data;
            dynamic Data = data.snapshot.value;
            return Scaffold(
              appBar: AppBar(
                backgroundColor: kPrimaryColor,
                title: Text('ROOM $proomid'),
                centerTitle: true,
                actions: [
                  TextButton(
                      onPressed: () {
                        Navigator.pop(context, MaterialPageRoute(
                            builder: (context) => LoginScreen()));
                      },
                      child: const Text('Back',
                        style: TextStyle(fontSize: 12, color:Colors.white),)),
                ],
              ),
              body: Column(
                children:
                getcards(Data),
              ),
            );
          } else
            return Container();
        }
    );

  }

  getcards(Data) {
    late List<Widget> list=[];
   
    late int temperature;
    late int pressure;

    for(int i =0;i< rooms[proomid].patients.length ;i++ ){

    
      temperature =Data['ROOMS'][proomid]['patients'][i]['temp'];
      pressure =Data['ROOMS'][proomid]['patients'][i]['pressure'];

      list.add(
          Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 10,),
              SizedBox(
                width: 400,
                height: 180,
                child: Card(
                  color: Colors.white,
                  elevation: 20,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    
                    children: [
                      RichText(text: TextSpan(text: 'Patient ID: ',
                          style: const TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1.0,
                            fontSize: 40,
                            
                          ),
                          children: [
                            TextSpan(text: '$i',
                                style: const TextStyle(color:Colors.black,
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 1.0,
                                  fontSize: 45,
                                ))
                          ]
                      ),),
                      const Spacer(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Spacer(),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              RichText(text: const TextSpan(text: 'Temperature',
                                  style: TextStyle(fontSize: 15,color: Colors.red,fontWeight: FontWeight.bold))),
                              const SizedBox(height: 10,),
                              RichText(text: TextSpan(text: '$temperature',style: const TextStyle(fontSize: 40,color: Colors.red)))
                            ],
                          ),
                          const SizedBox(width: 20,),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              RichText(text: const TextSpan(text: 'pressure',
                                  style: TextStyle(fontSize: 15,color:Colors.red,fontWeight: FontWeight.bold))),
                              const SizedBox(height: 10,),
                              RichText(text: TextSpan(text: '$pressure',
                                  style: const TextStyle(fontSize: 40,color: Colors.red)))
                            ],
                          ),
                          const SizedBox(width: 15,),
                          
                          const Spacer(),
                          TextButton.icon(
                              onPressed: (){
                                setState(() {
                                  PatientId=i;
                                  print('PatientId  $PatientId');
                                });
                              Navigator.push(context,MaterialPageRoute(builder: (context) => const patientVitals()));
                              },
                              style: ButtonStyle(shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(30.0),
                                    
                                  )
                              )
                              ),
                               icon: Image.asset('assets/patient3.png',height:70,
                                 width: 70),
                              label: const Text('',style: TextStyle(fontSize: 50),
                              )
                          ),
                          const SizedBox(width: 15,)
                        ],
                      ),
                      const Spacer(),
                    ],
                  ),
                ),
              ),
            ],
          )
      );
    }
    return list;
  }
}
