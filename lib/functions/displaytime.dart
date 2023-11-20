String displayTime({required Duration duration, required bool displayHours}) {
  String sDuration = !displayHours
      ? "${duration.inMinutes.remainder(60)}:${(duration.inSeconds.remainder(60)).toString().padLeft(2, '0')}"
      : "${duration.inHours.remainder(60)}:${duration.inMinutes.remainder(60).toString().padLeft(2, '0')}:${(duration.inSeconds.remainder(60)).toString().padLeft(2, '0')}";
  return sDuration;
}
