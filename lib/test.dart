import 'package:Effexxion/theme/them_util.dart';
import 'package:flutter/material.dart';

import 'pages/main_page/sound_panel.dart';

class TestPage extends StatefulWidget {
  const TestPage({super.key});

  @override
  State<TestPage> createState() => _TestPageState();
}

class _TestPageState extends State<TestPage> {
  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        constraints: const BoxConstraints.expand(),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {},
              child: const Text("Start"),
            ),
            20.width,
            const Expanded(
              flex: 1,
              child: SoundPanel(
                label: "A",
                image: "assets/images/A.png",
                sound: "audios/Button_A.mp3",
                disabled: false,
                duration: Duration(milliseconds: 60004),
              ),
            ),
            5.width,
            /*const Expanded(
              flex: 1,
              child: SoundPanel(
                label: "B",
                image: "assets/images/B.png",
                sound: "audios/Button_B.mp3",
                disabled: false,
              ),
            ),
            5.width,
            const Expanded(
              flex: 1,
              child: SoundPanel(
                label: "C",
                image: "assets/images/C.png",
                sound: "audios/Button_C.mp3",
                disabled: false,
              ),
            ),
            5.width,
            const Expanded(
              flex: 1,
              child: SoundPanel(
                label: "D",
                image: "assets/images/D.png",
                sound: "audios/Button_D.mp3",
                disabled: false,
              ),
            ),
            5.width,
            const Expanded(
              flex: 1,
              child: SoundPanel(
                label: "E",
                image: "assets/images/E.png",
                sound: "audios/Button_E.mp3",
                disabled: false,
              ),
            ),
            5.width,
            const Expanded(
              flex: 1,
              child: SoundPanel(
                label: "F",
                image: "assets/images/F.png",
                sound: "audios/Button_F.mp3",
                disabled: false,
              ),
            ),
            20.width,*/
          ],
        ),
      ),
    );
  }
}
