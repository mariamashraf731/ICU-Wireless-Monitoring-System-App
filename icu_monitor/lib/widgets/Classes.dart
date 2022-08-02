import 'package:flutter/material.dart';
class RoomsClass{
  int roomid;
  List<Patients> patients;
  RoomsClass({required this.patients,required this.roomid});
}
class Patients{
  int patientid;
  int temperature;
  int pressure;
  
  Patients({required this.patientid,required this.pressure,required this.temperature});
}
class chartdata{
  late final int Data;
  late final int time;
  chartdata({required this.Data,required this.time});
}

