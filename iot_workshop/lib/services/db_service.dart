import 'package:firebase_database/firebase_database.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_firebase_auth/stacked_firebase_auth.dart';

import '../app/app.locator.dart';
import '../app/app.logger.dart';
import '../models/models.dart';

class DbService with ReactiveServiceMixin {
  final log = getLogger('RealTimeDB_Service');

  FirebaseDatabase _db = FirebaseDatabase.instance;
  final _authenticationService = locator<FirebaseAuthenticationService>();

  DeviceData? _node;
  DeviceData? get node => _node;

  void setupNodeListening() {
    DatabaseReference starCountRef =
        _db.ref('/devices/${_authenticationService.currentUser!.uid}/reading');
    starCountRef.onValue.listen((DatabaseEvent event) {
      if (event.snapshot.exists) {
        _node = DeviceData.fromMap(event.snapshot.value as Map);
        // log.v(_node?.lastSeen); //data['time']
        notifyListeners();
      }
    });
  }

  Future<DeviceLedData?> getLedData() async {
    DatabaseReference dataRef =
        _db.ref('/devices/${_authenticationService.currentUser!.uid}/data');
    final value = await dataRef.once();
    if (value.snapshot.exists) {
      return DeviceLedData.fromMap(value.snapshot.value as Map);
    }
    return null;
  }

  void setDeviceData({required String led, required int value}) {
    log.i("Led path: ${led} is $value");
    DatabaseReference dataRef =
        _db.ref('/devices/${_authenticationService.currentUser!.uid}/data');
    dataRef.set({led: value});
  }
}
