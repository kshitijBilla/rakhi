import 'package:flutter/material.dart';
import '../config/app_config.dart';
import '../models/contact_model.dart';

class ContactsProvider extends ChangeNotifier {
  final List<ContactModel> _contacts = List.from(AppConfig.demoContacts);

  List<ContactModel> get contacts => List.unmodifiable(_contacts);
  int get contactCount => _contacts.length;

  void addContact(ContactModel contact) {
    _contacts.add(contact);
    notifyListeners();
  }

  void removeContact(String id) {
    _contacts.removeWhere((c) => c.id == id);
    notifyListeners();
  }

  void updateContact(ContactModel updated) {
    final index = _contacts.indexWhere((c) => c.id == updated.id);
    if (index != -1) {
      _contacts[index] = updated;
      notifyListeners();
    }
  }
}
