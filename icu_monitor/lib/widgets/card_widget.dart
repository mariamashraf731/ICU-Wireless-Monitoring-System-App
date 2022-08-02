import 'package:flutter/material.dart';
import 'package:icu_monitor/constants.dart';

class RoomsCard extends StatefulWidget {
   const RoomsCard({ required this.roomid, required this.show});
  final dynamic roomid;
  final void Function() show;

  @override
  State<RoomsCard> createState() => _RoomsCardState(roomid:roomid,show:show);
}

class _RoomsCardState extends State<RoomsCard> {
  final dynamic roomid;
  final void Function() show;

  _RoomsCardState({required this.roomid,required this.show});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const SizedBox(height: 10,),
        SizedBox(
          width: 400,
          height: 100,
          child: Card(
            color: Colors.grey[100],

            elevation: 20,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Spacer(),
                RichText(text: TextSpan(text: 'ROOM ID: ',
                  style: const TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.0,
                    fontSize: 40,
                  ),
                    children: [
                      TextSpan(text: '$roomid',style: const TextStyle(color:Colors.black))
                    ]
                ),
                ),
                const Spacer(),
                TextButton.icon(onPressed: show,
                    style: ButtonStyle(shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(22.0),
                           
                        )
                    )
                    ),
                    icon:  Image.asset('assets/ICU2.png',height:50,
                                 width: 50),
                    label: const Text('',style: TextStyle(fontSize: 30),
                    )
                ),
                const Spacer(),

              ],
            ),
          ),

        ),
      ],
    );
  }
}

class PatientsCard extends StatefulWidget {
  const PatientsCard({required this.patientid,required this.show,required this.temperature, required this.pressure});
  final dynamic patientid;
  final void Function() show;
  final int temperature;
  final int pressure;


  @override
  State<PatientsCard> createState() => _PatientsCardState(patientid: patientid,show:show,pressure: pressure,temperature: temperature);
}

class _PatientsCardState extends State<PatientsCard> {
  _PatientsCardState({required this.show,required this.patientid,required this.temperature, required this.pressure});
  final dynamic patientid;
  final void Function() show;
  final int temperature;
  final int pressure;

  @override
  Widget build(BuildContext context) {
   
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const SizedBox(height: 10,),
        SizedBox(
          width: 400,
          height: 240,
          child: Card(
            color: Colors.grey[100],
            elevation: 20,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                RichText(text: TextSpan(text: 'Patient ID: ',
                    style: const TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.0,
                      fontSize: 40,
                    ),
                    children: [
                      TextSpan(text: '$patientid',
                          style: const TextStyle(color: Colors.teal,
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
                            style: TextStyle(fontSize: 15,color: Colors.teal,fontWeight: FontWeight.bold))),
                        const SizedBox(height: 10,),
                        RichText(text: TextSpan(text: '$temperature',style: const TextStyle(fontSize: 40,color: Colors.black)))
                      ],
                    ),
                    const SizedBox(width: 20,),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        RichText(text: const TextSpan(text: 'pressure',
                            style: TextStyle(fontSize: 15,color: Colors.teal,fontWeight: FontWeight.bold))),
                        const SizedBox(height: 10,),
                        RichText(text: TextSpan(text: '$pressure',
                            style: const TextStyle(fontSize: 40,color: Colors.black)))
                      ],
                    ),
                    const SizedBox(width: 20,),
                    
                    const Spacer(),
                    TextButton.icon(onPressed: show,
                        style: ButtonStyle(shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30.0),
                                side: const BorderSide(color: Colors.teal)
                            )
                        )
                        ),
                        icon: const Icon(Icons.person,color: Colors.black,size: 40,),
                        label: const Text('',style: TextStyle(fontSize: 50),
                        )
                    ),
                    const SizedBox(width: 20,)
                  ],
                ),
                const Spacer(),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
