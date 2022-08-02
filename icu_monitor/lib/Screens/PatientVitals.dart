import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:icu_monitor/constants.dart';
import '../Screens/PatientsPage.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import '../widgets/Classes.dart';
import '../Screens/RoomsScreen.dart';
int patientid=PatientId;
int roomid=proomid;

class patientVitals extends StatefulWidget {
  const patientVitals({Key? key}) : super(key: key);

  @override
  State<patientVitals> createState() => _patientVitalsState();
}

class _patientVitalsState extends State<patientVitals> {
  bool showtemp=false;
  bool showpress=false;


  int Tstart=0;
  int Pstart=0;


  late List<chartdata> drawTemp= [];
  late List<chartdata> drawpress= [];
 

  int time = 0;

  @override
  void initstate(){
    super.initState();
    setState(() {
      roomid=proomid;
      patientid=PatientId;
    });
  }
  tempstatus(){
    setState(() {
      showtemp=!showtemp;
    });
  }
  pressstatus(){
    setState(() {
      showpress=!showpress;
    });
  }

  Future<void> WritePress() async{
    dbRef.child('control').update({
      'state':showpress? 2:0
    });
  }
  Future<void> WriteTemp() async{
    dbRef.child('control').update({
      'state':showtemp? 1:0
    });
  }
  @override
  Widget build(BuildContext context) {

    roomid=proomid;
    patientid=PatientId;

    return StreamBuilder(
        stream: dbRef.child('ICU').onValue,
        builder: (context, snapshot) {
          if (snapshot.hasData && !snapshot.hasError && snapshot.data != null) {
            dynamic data = snapshot.data;
            dynamic Data = data.snapshot.value;

          
            int temperature =Data['ROOMS'][proomid]['patients'][patientid]['temp'];
            int pressure =Data['ROOMS'][proomid]['patients'][patientid]['pressure'];

      
            List<chartdata> chartupdatetemp() {
              drawTemp.add(chartdata(Data: temperature, time: time));
              if(drawTemp.length<10){
                return drawTemp;
              }else{
                List<chartdata> list =[];
                for(int i=0;i<10;i++){
                  list.add(drawTemp[i+Tstart]);
                }
                Tstart++;
                return list;            }
            }
            List<chartdata> chartupdatepress() {
              drawpress.add(chartdata(Data: pressure, time: time));
              if(drawpress.length<10){
                return drawpress;
              }else{
                List<chartdata> list =[];
                for(int i=0;i<10;i++){
                  list.add(drawpress[i+Pstart]);
                }
                Pstart++;
                return list;           }
            }
          
            chartupdatepress();
            chartupdatetemp();
            time++;


            return Scaffold(
               backgroundColor: Colors.white,
                appBar: AppBar(
                  backgroundColor: kPrimaryColor,
                  
                  title: Text('Room $roomid __ Patient $patientid'),
                  centerTitle: true,
                  actions: [
                    TextButton(
                        onPressed: () {
                          Navigator.pop(context, MaterialPageRoute(
                              builder: (context) => const PatientsPage()));
                        },
                        child: const Text('Back',
                          style: TextStyle(fontSize: 12, color: Colors.white),)),
                  ],
                ),
                body: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                 

                  children: [
                    const SizedBox(height: 10,),
                    Container(
                      
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 10,),
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
                                      style: TextStyle(fontSize: 25,color: Colors.red,fontWeight: FontWeight.bold))),
                                  const SizedBox(height: 10,),
                                  RichText(text: TextSpan(text: '$temperature',style: const TextStyle(fontSize: 40,color: Colors.black))),
                                 
                                ],
                              ),
                              const Spacer(),
                              const SizedBox(width: 20,),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  RichText(text: const TextSpan(text: 'Pressure',
                                      style: TextStyle(fontSize: 25,color: Colors.red,fontWeight: FontWeight.bold))),
                                  const SizedBox(height: 10,),
                                  RichText(text: TextSpan(text: '$pressure',
                                      style: const TextStyle(fontSize: 40,color: Colors.black))
                                  ),
                                 
                                ],
                              ),
                              const SizedBox(width: 20,),
                         
                              const Spacer(),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const SizedBox(width: 40,),
                              FlatButton.icon(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                onPressed: (){
                                  tempstatus();
                                  WriteTemp();
                                },
                                color: showtemp? Colors.white:kPrimaryLightColor,
                                label: showtemp? RichText(text: const TextSpan(text: 'Turn off',style: TextStyle(fontSize: 14,color:kPrimaryColor,fontWeight: FontWeight.bold))):
                                RichText(text: const TextSpan(text: 'Turn ON',style: TextStyle(fontSize: 14,color: Colors.black,fontWeight: FontWeight.bold))),
                                icon: const Icon(Icons.slideshow,color:Colors.black ,)
                                ,
                              ),
                              const Spacer(),
                              const SizedBox(width: 10,),
                              
                              FlatButton.icon(
                                onPressed: (){
                                  pressstatus();
                                  WritePress();
                                },
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                color: showpress? Colors.white:kPrimaryLightColor,
                                label: showpress? RichText(text: const TextSpan(text: 'Turn off',style: TextStyle(fontSize: 14,color:kPrimaryColor,fontWeight: FontWeight.bold))):
                                RichText(text: const TextSpan(text: 'Turn ON',style: TextStyle(fontSize: 14,color: Colors.black,fontWeight: FontWeight.bold))),
                                icon: const Icon(Icons.slideshow,color:Colors.black ,)
                                ,
                              ),
                              const SizedBox(width: 10,),
                       
                              const Spacer(),
                            ],
                          ),
                          const SizedBox(height: 5,)
                        ],
                      ),
                    ),

                    Expanded(
                      child: GridView.count(
                        mainAxisSpacing: 1,
                        crossAxisCount: 1,
                        children: [ListView(
                          scrollDirection: Axis.vertical,
                          children:[
                          showtemp?
                          Container(
                            color: Colors.white60,
                            width: 400,
                            height: 400,
                            child: Column(
                              
                              children: [
                                const SizedBox(height: 20,width: 20,),
                                Padding(
                                  padding: const EdgeInsets.all(2.0),
                                  child: RichText(text: const TextSpan(text: 'Temperature',style: TextStyle(color: Colors.red,fontWeight: FontWeight.bold,fontSize: 20)),),
                                ),
                                SfCartesianChart(
                                  // legend: Legend(isVisible: true),
                                  series:<ChartSeries>[
                                    LineSeries<chartdata,double>(
                                      name: 'Temperature',
                                      dataSource: chartupdatetemp(),
                                      xValueMapper: (chartdata chart,_)=> double.parse(chart.time.toString()),
                                      yValueMapper: (chartdata chart,_)=> double.parse(chart.Data.toString()),
                                      // dataLabelSettings: DataLabelSettings(isVisible: true),
                                      xAxisName: 'time',
                                      yAxisName: 'temp',

                                      color: Colors.orange[900],
                                    )
                                  ],
                                  primaryXAxis: NumericAxis(edgeLabelPlacement: EdgeLabelPlacement.shift),
                                  primaryYAxis: NumericAxis(edgeLabelPlacement: EdgeLabelPlacement.shift),
                                ),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                   const Spacer(),
                                    FlatButton.icon(onPressed: (){
                                      setState(() {
                                        if(Tstart>6){
                                          Tstart=Tstart~/2;
                                        }else{
                                          Tstart=0;
                                        }
                                      });
                                    }, icon: const Icon(Icons.keyboard_arrow_left
                                 ), label: RichText(text: const TextSpan(text: 'left'),)),
                                    FlatButton.icon(onPressed: (){
                                      setState(() {
                                        Tstart=0;
                                      });
                                    }, icon: const Icon(Icons.replay_circle_filled), label: RichText(text: const TextSpan(text: 'start'),)),
                                    FlatButton.icon(onPressed: (){
                                      setState(() {
                                        if(Tstart<drawpress.length-10){
                                          Tstart++;
                                        }
                                      });
                                    }, icon: const Icon(Icons.keyboard_arrow_right), label: RichText(text: const TextSpan(text: 'right'),)),

                                 
                                  ],
                                )
                              ],
                            ),
                          )
                              :const SizedBox(height: 2,width: 2,),
                          showpress?
                          Container(
                            color: Colors.white60,
                            width: 400,
                            height: 400,
                            child: Column(
                              children: [

                                const SizedBox(height: 20,width: 20,),
                                Padding(
                                  padding: const EdgeInsets.all(2.0),
                                  child: RichText(text: const TextSpan(text: 'Pressure',style: TextStyle(color: Colors.red,fontWeight: FontWeight.bold,fontSize: 20)),),
                                ),
                                SfCartesianChart(
                                  // legend: Legend(isVisible: true),
                                  series:<ChartSeries>[
                                    LineSeries<chartdata,double>(
                                      name: 'Pressure',
                                      dataSource: chartupdatepress(),
                                      xValueMapper: (chartdata chart,_)=> double.parse(chart.time.toString()),
                                      yValueMapper: (chartdata chart,_)=> double.parse(chart.Data.toString()),
                                      // dataLabelSettings: DataLabelSettings(isVisible: true),
                                      color: Colors.blue[900],
                                    )
                                  ],
                                  primaryXAxis: NumericAxis(edgeLabelPlacement: EdgeLabelPlacement.shift),
                                  primaryYAxis: NumericAxis(edgeLabelPlacement: EdgeLabelPlacement.shift),
                                ),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  
                                  children: [
                                    const Spacer(),
                                    FlatButton.icon(onPressed: (){
                                      setState(() {
                                        if(Pstart>6){
                                          Pstart=Pstart~/2;
                                        }else{
                                          Pstart=0;
                                        }
                                      });
                                      
                                    }, 
                                    
                                    icon: const Icon(Icons.keyboard_arrow_left), label: RichText(text: const TextSpan(text: 'left'),)),
                                    
                                    FlatButton.icon(onPressed: (){
                                      setState(() {
                                        Pstart=0;
                                      });
                                    }, icon: const Icon(Icons.replay_circle_filled), label: RichText(text: const TextSpan(text: 'start'),)),
                                    FlatButton.icon(onPressed: (){
                                      setState(() {
                                        if(Pstart<drawpress.length-10){
                                        Pstart++;
                                        }
                                      });
                                    }, icon: const Icon(Icons.keyboard_arrow_right), label: RichText(text: const TextSpan(text: 'right'),)),

                                   const SizedBox(height: 20,width: 20,),
                                  ],
                                )
                                
                              ],
                              
                            ),
                          )
                              :const SizedBox(height: 20,width: 20,),

                       
                            
                        ],
                         ) ]),
                    ),


                  ],
                )

            );
          }else return Container();
        }
    );
  }
}

