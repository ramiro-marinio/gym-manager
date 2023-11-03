String displayTime(int secs) {
  int seconds = secs % 60;
  int minutes = (secs - seconds) ~/ 60;
  return seconds >= 10 ? '$minutes:$seconds' : '$minutes:0$seconds';
}
