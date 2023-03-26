import 'dart:async';

import 'package:iot_workshop/app/app.router.dart';
import 'package:iot_workshop/models/models.dart';
import 'package:iot_workshop/services/db_service.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_firebase_auth/stacked_firebase_auth.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../../app/app.locator.dart';
import '../../../app/app.logger.dart';
// import '../../setup_snackbar_ui.dart';

class HomeViewModel extends ReactiveViewModel {
  final log = getLogger('HomeViewModel');

  // final _snackBarService = locator<SnackbarService>();
  // final _navigationService = locator<NavigationService>();
  final _dbService = locator<DbService>();
  final _authenticationService = locator<FirebaseAuthenticationService>();
  final _navigationService = locator<NavigationService>();

  DeviceData? get data => _dbService.node;

  bool _isStress = false;
  bool get isStress => _isStress;

  @override
  List<DbService> get reactiveServices => [_dbService];

  double newValue(int value) {
    if (value == 0) return -1;
    return ((((value - 0) * (0 - 1)) / (4095 - 0)) + 0).toDouble().abs();
  }

  int _led = 0;
  int get led => _led;

  void onModelReady() async {
    setBusy(true);
    DeviceLedData? ledData = await _dbService.getLedData();
    if (ledData != null) {
      _led = ledData.led;
    }
    setBusy(false);
  }

  void ledOnOff() {
    _led = _led == 0 ? 1 : 0;
    notifyListeners();
    _dbService.setDeviceData(led: "led", value: _led);
  }

  void logout() {
    _authenticationService.logout();
    _navigationService.replaceWith(Routes.loginView);
  }
}
