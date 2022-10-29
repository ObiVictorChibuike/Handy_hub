class CustomDate{

  static String slash(String date) {
    var parsedDate = DateTime.parse(date);
    var day = parsedDate.day;
    var month = parsedDate.month;
    var year = parsedDate.year;

    return "$day/$month/$year";
  }
}
