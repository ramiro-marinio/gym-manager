double average(List<num> numbers) {
  num sum = 0;
  int i = 0;
  for (num number in numbers) {
    sum += number;
    i++;
  }
  return numbers.isNotEmpty ? sum / i : 0;
}
