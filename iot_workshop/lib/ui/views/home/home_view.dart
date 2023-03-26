import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:iot_workshop/ui/smart_widgets/online_status.dart';
import 'package:stacked/stacked.dart';
import 'package:liquid_progress_indicator/liquid_progress_indicator.dart';
import 'package:lottie/lottie.dart';

import 'home_viewmodel.dart';

class HomeView extends StatelessWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<HomeViewModel>.reactive(
      onViewModelReady: (model) => model.onModelReady(),
      builder: (context, model, child) {
        // print(model.node?.lastSeen);
        return Scaffold(
            appBar: AppBar(
              title: const Text('IEDC IoT Workshop'),
              // centerTitle: true,
              actions: [
                IsOnlineWidget(),
                IconButton(onPressed: model.logout, icon: Icon(Icons.logout)),
              ],
            ),
            body: model.data != null
                ? const _HomeBody()
                : Center(child: Text("No data")));
      },
      viewModelBuilder: () => HomeViewModel(),
    );
  }
}

class _HomeBody extends ViewModelWidget<HomeViewModel> {
  const _HomeBody({Key? key}) : super(key: key, reactive: true);

  @override
  Widget build(BuildContext context, HomeViewModel model) {
    return Stack(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: GridView.count(
            crossAxisCount: 2,
            mainAxisSpacing: 10,
            crossAxisSpacing: 10,
            children: [
              LEDView(
                value: model.led,
                onTap: () {
                  model.ledOnOff();
                },
              ),
              IRView(
                value: model.data!.ir,
              ),
              LDRView(
                value: model.newValue(model.data!.ldr),
                text: "LDR",
              ),
            ],
          ),
        ),
        // else if (model.data!.s1 < 30)
        //   Positioned.fill(
        //       child: LottieShow(
        //     link: 'https://assets3.lottiefiles.com/packages/lf20_qf6zku4z.json',
        //     text: 'Connect GSR cables',
        //   ))
      ],
    );
  }
}

class LEDView extends StatelessWidget {
  final VoidCallback onTap;
  final int value;
  const LEDView({
    Key? key,
    required this.value,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.orange.withOpacity(0.2),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: InkWell(
          onTap: onTap,
          child: Center(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: value == 1 ? Colors.red : Colors.green,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey,
                    offset: Offset(0.0, 1.0), //(x,y)
                    blurRadius: 6.0,
                  ),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.all(30.0),
                child: Text(value == 0 ? "LED OFF" : "LED ON"),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class IRView extends StatelessWidget {
  final int value;
  const IRView({
    Key? key,
    required this.value,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: value == 0
            ? Colors.red.withOpacity(0.5)
            : Colors.green.withOpacity(0.2),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(30.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (value == 0)
                  Icon(Icons.back_hand_rounded)
                else
                  Icon(Icons.waving_hand_outlined),
                Text(value == 0 ? "IR DETECTED" : "IR NOT"),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class LDRView extends StatelessWidget {
  final double value;
  final String text;
  const LDRView({
    Key? key,
    required this.value,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.blue.withOpacity(0.2),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: LiquidCircularProgressIndicator(
            value: value,
            valueColor: AlwaysStoppedAnimation(Colors.yellow),
            backgroundColor: Colors
                .white, // Defaults to the current Theme's backgroundColor.
            // borderColor: Colors.black,
            // borderWidth: 1.0,

            center: value == -1
                ? Text("NO LDR")
                : Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("${(value * 100).round()}%"),
                      Text(text),
                    ],
                  ),
          ),
        ),
      ),
    );
  }
}

class LottieShow extends StatelessWidget {
  final String link;
  final String text;
  const LottieShow({super.key, required this.link, required this.text});

  @override
  Widget build(BuildContext context) {
    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
      child: Center(
        child: Card(
          elevation: 10,
          color: Colors.black.withOpacity(0.5),
          child: Container(
            // height: 250,
            // width: 200,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Lottie.network(link),
                  SizedBox(height: 20),
                  Text(
                    text,
                    style: TextStyle(fontSize: 15, color: Colors.white),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
