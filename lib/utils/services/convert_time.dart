class ConvertTime {
  String convertTimeToString(int timeInMilliseconds) {
    double seconds = (timeInMilliseconds / 1000) % 60;
    double minutes = (seconds / (1000 * 60)) % 60;
    double hours = minutes / (1000 * 60 * 60);
    return '${hours.toStringAsFixed(2)} h ${minutes.toStringAsFixed(2)} min ${seconds.toStringAsFixed(2)} s';
  }

  String convertTimeToStringCompressed(int timeInMilliseconds) {
    int seconds = (timeInMilliseconds ~/ 1000) % 60;
    int minutes = (seconds ~/ (1000 * 60)) % 60;
    int hours = minutes ~/ (1000 * 60 * 60);
    return '$hours:$minutes:$seconds';
  }
}
