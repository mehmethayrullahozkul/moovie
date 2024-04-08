import 'package:flutter/material.dart';
import 'package:workarea_v1/workareas/wa_goal_template.dart';

class WA2Goal extends StatelessWidget {
  static const index = 2;
  const WA2Goal({super.key});
  @override
  Widget build(BuildContext context) {
    return const WAGoalTemplate(
      pageIndex: index,
      child: _Goal(),
    );
  }
}

class _Goal extends StatefulWidget {
  const _Goal({super.key});

  @override
  State<_Goal> createState() => _GoalState();
}

class _GoalState extends State<_Goal> {
  late TextEditingController _controller1;
  late TextEditingController _controller2;
  late int toplam;

  @override
  void initState() {
    toplam = 30;
    _controller1 = TextEditingController();
    _controller2 = TextEditingController();
  }

  @override
  void dispose() {
    _controller1.dispose();
    _controller2.dispose();
    super.dispose();
  }

  void _toplamaYap() {
    toplam = int.parse(_controller1.text) + int.parse(_controller2.text);
    /*  FocusManager.instance.primaryFocus?.unfocus(); */
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        width: MediaQuery.of(context).size.width * 1,
        height: MediaQuery.of(context).size.height * 0.6,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.max,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              mainAxisSize: MainAxisSize.max,
              children: [
                SizedBox(
                  width: 150,
                  child: TextField(
                    controller: _controller1,
                  ),
                ),
                SizedBox(
                  width: 150,
                  child: TextField(
                    controller: _controller2,
                  ),
                ),
              ],
            ),
            Text("Toplama işlemi yapar mük hesap makinesi"),
            TextButton(
                onPressed: () {
                  _toplamaYap();
                  setState(() {});
                },
                child: Text("Toplama İşlemini Gerçekleştir")),
            Text(
              "İşlem Sonucu: $toplam",
              style: TextStyle(fontSize: 32),
            )
          ],
        ),
      ),
    );
  }
}
