import 'package:iot_workshop/app/app.router.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_firebase_auth/stacked_firebase_auth.dart';
import 'package:stacked_services/stacked_services.dart';
import '../../../app/app.locator.dart';
import '../../../app/app.logger.dart';
import '../../../services/db_service.dart';
import '../../setup_snackbar_ui.dart';

class LoginViewModel extends BaseViewModel {
  final log = getLogger('LoginViewModel');
  final _authenticationService = locator<FirebaseAuthenticationService>();
  final _navigationService = locator<NavigationService>();
  final _dbService = locator<DbService>();
  final _snackBarService = locator<SnackbarService>();

  int _value = 0;
  int get value => _value;

  void updateValue(int v) {
    _value = v;
    notifyListeners();
  }

  void login() async {
    final auth = await _authenticationService.loginWithEmail(
        email: "device$_value@autobonics.com", password: "12345678");
    log.i(auth.errorMessage);
    if (auth.user != null) {
      log.i("User got:");
      log.i(auth.user!.displayName);
      _dbService.setupNodeListening();
      _navigationService.replaceWith(Routes.homeView);
    } else {
      _snackBarService.showCustomSnackBar(
          message: "${auth.errorMessage}", variant: SnackbarType.error);
    }
  }
}
