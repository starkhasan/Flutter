import 'package:intl/intl.dart';
extension on String{
  String get convertTime{
    var createdDate = this;
    String time = DateFormat.jm().format(DateTime.parse(createdDate));
    switch (createdDate.substring(5,7)){
      case '01':
        return createdDate.substring(8,10)+' Jan '+createdDate.substring(0,4) +' '+time;
      case '02':
        return createdDate.substring(8,10)+' Feb '+createdDate.substring(0,4)+' '+time;
      case '03':
        return createdDate.substring(8,10)+' Mar '+createdDate.substring(0,4)+' '+time;
      case '04':
        return createdDate.substring(8,10)+' Apr '+createdDate.substring(0,4)+' '+time;
      case '05':
        return createdDate.substring(8,10)+' May '+createdDate.substring(0,4)+' '+time;
      case '06':
        return createdDate.substring(8,10)+' Jun '+createdDate.substring(0,4)+' '+time;
      case '07':
        return createdDate.substring(8,10)+' Jul '+createdDate.substring(0,4)+' '+time;
      case '08':
        return createdDate.substring(8,10)+' Aug '+createdDate.substring(0,4)+' '+time;
      case '09':
        return createdDate.substring(8,10)+' Sep '+createdDate.substring(0,4)+' '+time;
      case '10':
        return createdDate.substring(8,10)+' Oct '+createdDate.substring(0,4)+' '+time;
      case '11':
        return createdDate.substring(8,10)+' Nov '+createdDate.substring(0,4)+' '+time;
      case '12':
        return createdDate.substring(8,10)+' Dec '+createdDate.substring(0,4)+' '+time;
    }
    return '';
  }
}