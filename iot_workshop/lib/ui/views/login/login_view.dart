import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'login_viewmodel.dart';
import 'package:numberpicker/numberpicker.dart';

class LoginView extends StatelessWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<LoginViewModel>.reactive(
      builder: (context, model, child) {
        // print(model.node?.lastSeen);
        return Scaffold(
          // backgroundColor: Theme.of(context).colorScheme.background,
          body: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Image.asset(
                    'assets/splash.png',
                    height: 200,
                  ),
                ),
                const Text(
                  "Select your group id",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: NumberPicker(
                    value: model.value,
                    minValue: 0,
                    maxValue: 12,
                    onChanged: (value) {
                      model.updateValue(value);
                    },
                  ),
                ),
                TextButton(
                  onPressed: model.login,
                  child: Container(
                      decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Text("Connect to device"),
                      )),
                ),
              ],
            ),
          ),
        );
        ;
      },
      viewModelBuilder: () => LoginViewModel(),
    );
  }
}
