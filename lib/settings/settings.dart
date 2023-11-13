import 'package:shared_preferences/shared_preferences.dart';

class Settings {
  Future<bool> getUnit() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    bool? val = prefs.getBool('kgUnit');
    if (val == null) {
      prefs.setBool('kgUnit', true);
      return true;
    }
    return prefs.getBool('kgUnit')!;
  }

  void setUnit(bool unit) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('kgUnit', unit);
  }
}
