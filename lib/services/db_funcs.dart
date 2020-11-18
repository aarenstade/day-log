import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:daylog/models/hourState.dart';
import 'auth_functions.dart';
import 'db_utils.dart';

class DBFuncs {
  static Map<String, String> todayFields = Map<String, String>();
  static final FirebaseFirestore db = FirebaseFirestore.instance;

  static DocumentReference todayRef() {
    var user = AuthFunctions.getUser();
    var now = DBUtils.formatDateTime(DateTime.now());
    return db
        .collection(user[0])
        .doc(now.year)
        .collection(now.month)
        .doc(now.day);
  }

  //get data for today or create new today fields in db
  static Future<List<HourState>> getToday() async {
    print('getting today data');
    try {
      var doc = await todayRef().get();
      var e = doc.exists;
      if (e) {
        var data = doc.data();
        final gotData = DBUtils.parseData(data);
        final sorted = DBUtils.sortList(gotData);
        return sorted;
      } else {
        final fields = await createTodayFields();
        final gotData = DBUtils.parseData(fields);
        final sorted = DBUtils.sortList(gotData);
        return sorted;
      }
    } catch (e) {
      print("ERROR getting today data: $e");
      return null;
    }
  }

  //save this hour text
  static Future<bool> saveHour({int hour, String text}) async {
    try {
      print('saving hour $hour w/ $text');
      await todayRef().update({hour.toString(): text});
      return true;
    } catch (e) {
      print("ERROR saveHour: $e");
      return false;
    }
  }

  //create new fields for today
  static Future<Map<String, String>> createTodayFields() async {
    print('creating today fields');
    try {
      for (var i = 0; i < 24; i++) {
        todayFields[i.toString()] = "";
      }
      await todayRef().set(todayFields);
      return todayFields;
    } catch (e) {
      print("ERROR creating today fields: $e");
      return null;
    }
  }

  //get data of any past day
  static Future<List<HourState>> getPastDay(DateTime dateTime) async {
    print('getting past day: ${dateTime.toString()}');
    try {
      var user = AuthFunctions.getUser();
      var date = DBUtils.formatDateTime(dateTime);
      var dayData = await db
          .collection(user[0])
          .doc(date.year)
          .collection(date.month)
          .doc(date.day)
          .get()
          .then((doc) {
        if (doc.exists) {
          var gotData = DBUtils.parseData(doc.data());
          var sorted = DBUtils.sortList(gotData);
          return sorted;
        } else {
          return null;
        }
      });
      return dayData;
    } catch (e) {
      print('ERROR getting ${dateTime.toString()} : $e');
      return null;
    }
  }
}
