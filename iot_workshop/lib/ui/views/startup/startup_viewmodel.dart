import 'package:iot_workshop/services/db_service.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_firebase_auth/stacked_firebase_auth.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../../app/app.locator.dart';
import '../../../app/app.logger.dart';
import '../../../app/app.router.dart';

class StartupViewModel extends BaseViewModel {
  final log = getLogger('StartUpViewModel');
  final _authenticationService = locator<FirebaseAuthenticationService>();

  final _navigationService = locator<NavigationService>();
  final _dbService = locator<DbService>();

  void handleStartupLogic() async {
    log.i('Startup');
    await Future.delayed(const Duration(milliseconds: 800));
    bool isUserLoggedIn = _authenticationService.hasUser;
    if (isUserLoggedIn) {
      log.d('Logged in user available');
      _dbService.setupNodeListening();
     _navigationService.replaceWith(Routes.homeView);
    } else {
     _navigationService.replaceWith(Routes.loginView);
      log.d('No logged in user');
    }
  }

  // void doSomething() {
  //   _navigationService.replaceWith(
  //     Routes.hostel,
  //     arguments: DetailsArguments(name: 'FilledStacks'),
  //   );
  // }

  // void getStarted() {
  //   _navigationService.replaceWith(
  //     Routes.details,
  //     arguments: DetailsArguments(name: 'FilledStacks'),
  //   );
  // }
}
