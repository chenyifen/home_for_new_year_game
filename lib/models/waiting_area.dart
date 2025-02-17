import 'person.dart';

class WaitingArea {
  List<Person> _waitingPersons = [];

  bool addPerson(Person person) {
    if (_waitingPersons.length < 2) {
      _waitingPersons.add(person);
      return true;
    }
    return false;
  }

  List<Person> get waitingPersons => _waitingPersons;

  List<Person> removePersonsByColor(String color) {
    List<Person> matchingPersons = _waitingPersons.where((p) => p.color == color).toList();
    _waitingPersons.removeWhere((p) => p.color == color);
    return matchingPersons;
  }
}
