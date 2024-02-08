import 'package:intl/intl.dart';

extension DateTimeExension on DateTime? {
  int compareToNull(DateTime? b) {
    DateTime? a = this;
    if (a != null && b != null) {
      return a.compareTo(b);
    } else {
      return 0;
    }
  }
  ///Format time
  ///HH:mm:ss
  ///
  String formatTime() {
    final DateTime? date = this;
    if (date != null) {
      return DateFormat("hh:mm:ss")
          .format(date);
    } else {
      return "";
    }
  }
  ///dd/MM/yyyy : hh:mm:ss
  String formatDatetimeShort(){
    final DateTime? date = this;
    if(date!=null){
      return DateFormat("dd/MM/yyyy hh:mm:ss").format(date);

    }else{
      return "";
    }

  }
}
