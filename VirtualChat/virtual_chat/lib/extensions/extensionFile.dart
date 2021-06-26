extension ExtendedString on String {
  String get formateDate{
    var month = this;
    switch (month.substring(5,7)){
      case '01':
        return month.substring(8,10)+' '+'January '+month.substring(11,16);
      case '02':
        return month.substring(8,10)+' '+'Febuary '+month.substring(11,16);
      case '03':
        return month.substring(8,10)+' '+'March '+month.substring(11,16);
      case '04':
        return month.substring(8,10)+' '+'April '+month.substring(11,16);
      case '05':
        return month.substring(8,10)+' '+'May '+month.substring(11,16);
      case '06':
        return month.substring(8,10)+' '+'June '+month.substring(11,16);
      case '07':
        return month.substring(8,10)+' '+'July '+month.substring(11,16);
      case '08':
        return month.substring(8,10)+' '+'August '+month.substring(11,16);
      case '09':
        return month.substring(8,10)+' '+'September '+month.substring(11,16);
      case '10':
        return month.substring(8,10)+' '+'October '+month.substring(11,16);
      case '11':
        return month.substring(8,10)+' '+'November '+month.substring(11,16);
      case '12':
        return month.substring(8,10)+' '+'December '+month.substring(11,16);
    }
    return "";
  }
}