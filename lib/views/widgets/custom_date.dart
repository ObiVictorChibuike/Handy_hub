import 'package:intl/intl.dart';
import 'package:jiffy/jiffy.dart';

class CustomDate{

  static String slash(String date) {
    final formattedDate = Jiffy.parse(date).yMMMd;
    return formattedDate;
  }

  static String getDate(String date) {
    var inputFormat = DateFormat('yyyy-MM-dd HH:mm');
    var inputDate = inputFormat.parse(date);
    var outputFormat = DateFormat('dd/MM/yyyy');
    return outputFormat.format(inputDate);
  }
}
