import 'package:jiffy/jiffy.dart';

class CustomDate{

  // static String slash(String date) {
  //   var parsedDate = DateTime.parse(date);
  //   var day = parsedDate.day;
  //   var month = parsedDate.month;
  //   var year = parsedDate.year;
  //
  //   return "$day/$month/$year";
  // }

  static String slash(String date) {
    final formattedDate = Jiffy.parse(date).yMMMdjm;
    return formattedDate;
  }
}
