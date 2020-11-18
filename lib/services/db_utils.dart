import 'package:daylog/models/hourState.dart';
import 'package:intl/intl.dart';
import 'package:daylog/models/day.dart';

class DBUtils {
  static Day formatDateTime(DateTime dt) {
    final year = dt.year.toString();
    final month = DateFormat('MMMM').format(dt);
    final day = dt.day.toString();
    return Day(year: year, month: month, day: day);
  }

  static List<HourState> parseData(Map<String, dynamic> d) {
    print('parsing data');
    List<HourState> todayState = List<HourState>();
    d.forEach((key, value) {
      todayState.add(HourState(hour: int.parse(key), initText: value ?? ""));
    });
    todayState.sort((a, b) => a.hour.compareTo(b.hour));
    return todayState;
  }

  static List<HourState> sortList(List<HourState> list) {
    print("sorting");
    list.sort((a, b) => a.hour.compareTo(b.hour));
    return list;
  }
}
