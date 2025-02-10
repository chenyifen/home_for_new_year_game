import 'person.dart';

class WaitingArea {
  List<Person> _waitingPersons = [];

  bool addPerson(Person person) {
    if (_waitingPersons.length < 3) {
      _waitingPersons.add(person);
      return true;
    }
    return false;
  }

  List<Person> get waitingPersons => _waitingPersons;
}