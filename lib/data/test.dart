void main() {

  List<DateTime> disabledDates = [DateTime.parse('2023-02-25'), DateTime.parse('2023-02-26'),DateTime.parse('2023-02-02')]; // example list of disabled dates

  bool isDisabled(DateTime day) {

    return disabledDates.contains(day); // return true if the day is in the list of disabled dates, false otherwise
  }

  print(isDisabled(DateTime.parse('2023-02-25'))); // true

}
