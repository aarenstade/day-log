String formatHour(int hour) {
  String hr = "";
  if (hour <= 11) {
    if (hour == 0) {
      hr = "12 AM";
    } else {
      hr = "$hour AM";
    }
  } else if (hour >= 12) {
    if (hour == 12) {
      hr = "12 PM";
    } else {
      hr = "${hour - 12} PM";
    }
  }
  return hr;
}
