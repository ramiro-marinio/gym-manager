String displayTime(Duration duration) {
  String sDuration =
      "${duration.inMinutes.remainder(60)}:${(duration.inSeconds.remainder(60)).toString().padLeft(2, '0')}";
  return sDuration;
}
