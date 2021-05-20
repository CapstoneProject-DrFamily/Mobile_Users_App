import 'package:intl/intl.dart';

class Common {
  static String convertDate(String date) {
    DateTime dateTime = DateTime.parse(date);
    String month;
    switch (dateTime.month) {
      case 1:
        month = "Jan";
        break;
      case 2:
        month = "Feb";
        break;
      case 3:
        month = "Mar";
        break;
      case 4:
        month = "Apr";
        break;
      case 5:
        month = "May";
        break;
      case 6:
        month = "Jun";
        break;
      case 7:
        month = "Jul";
        break;
      case 8:
        month = "Aug";
        break;
      case 9:
        month = "Sep";
        break;
      case 10:
        month = "Oct";
        break;
      case 11:
        month = "Nov";
        break;
      case 12:
        month = "Dec";
        break;
    }

    String display = dateTime.day.toString() +
        "-" +
        month +
        " " +
        dateTime.hour.toString().padLeft(2, '0') +
        ":" +
        dateTime.minute.toString().padLeft(2, '0');

    return display;
  }

  static String convertTime(String date) {
    DateTime dateTime = DateTime.parse(date);
    return dateTime.hour.toString().padLeft(2, '0') +
        ":" +
        dateTime.minute.toString().padLeft(2, '0');
  }

  static String convertSchedule(String date) {
    DateTime dateTime = DateTime.parse(date);
    String month;
    switch (dateTime.month) {
      case 1:
        month = "Jan";
        break;
      case 2:
        month = "Feb";
        break;
      case 3:
        month = "Mar";
        break;
      case 4:
        month = "Apr";
        break;
      case 5:
        month = "May";
        break;
      case 6:
        month = "Jun";
        break;
      case 7:
        month = "Jul";
        break;
      case 8:
        month = "Aug";
        break;
      case 9:
        month = "Sep";
        break;
      case 10:
        month = "Oct";
        break;
      case 11:
        month = "Nov";
        break;
      case 12:
        month = "Dec";
        break;
    }

    String display =
        dateTime.day.toString() + "-" + month + "-" + dateTime.year.toString();

    return display;
  }

  static String getLocationName(String data) {
    var list = data.split(";");
    var temp = list[1].split(":");
    return temp[1];
  }

  static String getLocationShort(String data, int length) {
    if (data.length < length) {
      return data;
    } else {
      return data.substring(0, length) + "...";
    }
  }

  static String convertPrice(double price) {
    return NumberFormat.currency(locale: 'vi').format(price);
  }
}
