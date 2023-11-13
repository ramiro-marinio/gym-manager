import 'package:shared_preferences/shared_preferences.dart';

class Settings {
  bool kgUnit = true;
  Future<bool> getUnit() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    bool? val = prefs.getBool('kgUnit');
    if (val == null) {
      prefs.setBool('kgUnit', true);
      return true;
    }
    kgUnit = prefs.getBool('kgUnit')!;
    return kgUnit;
  }

  void setUnit(bool unit) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('kgUnit', unit);
  }
}
