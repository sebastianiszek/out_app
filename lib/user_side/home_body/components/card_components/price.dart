String getPriceFromInt(int number) {
  String string = "";
  for (var i = 0; i < number; i++) {
    string += "£";
  }
  return string;
}
