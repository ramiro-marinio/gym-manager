List moveElement(List list, int index, int newposition,
    {bool moveToBeggining = false}) {
  if (index == newposition) {
    return list;
  }
  bool forward = newposition > index;
  List listA = [];
  //This for loop adds every item that is not the "index" item, effectively removing it
  for (var i = 0; i < list.length; i++) {
    if (list[i] != list[index]) {
      listA += [list[i]];
    }
  }

  List halfA = [];
  List halfB = [];
  if (moveToBeggining == true) {
    return [list[index]] + listA;
  }
  if (forward) {
    newposition--;
  }
  halfA = listA.getRange(0, newposition + 1).toList();
  halfB = listA.getRange(newposition + 1, listA.length).toList();
  return halfA + [list[index]] + halfB;
}
