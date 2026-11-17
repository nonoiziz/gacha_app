import 'package:flutter/material.dart';
import 'dart:math';

void main() => runApp(const MaterialApp(home: CounterPage()));

class CounterPage extends StatefulWidget {
  const CounterPage({super.key});

  @override
  State<CounterPage> createState() => _CounterPageState();
}

class Child {
  String name;
  int drawTimes;
  String lastItem = '';
  List<String> collection = [];
  Child(this.name, this.drawTimes);
}

class _CounterPageState extends State<CounterPage> {
  int selected = 0;
  List<String> prizes = ['小巴', '吉依卡哇', '烏薩奇'];
  List<Child> children = [Child('維翔', 0), Child('羽澄', 0)];

  int maxDraw = 5;

  void addOne() {
    setState(() {
      Random random = Random();
      int randomResult = random.nextInt(prizes.length);
      children[selected].lastItem = prizes[randomResult];
      children[selected].collection.add(prizes[randomResult]);
      children[selected].drawTimes = children[selected].drawTimes + 1;
    });
  }

  @override
  Widget build(BuildContext context) {
    Child kid = children[selected];

    Map<String, int> counts = {};
    for (String name in kid.collection) {
      if (counts.containsKey(name)) {
        counts[name] = counts[name]! + 1;
      } else {
        counts[name] = 1;
      }
    }

    String summary = '';
    for (String name in counts.keys) {
      summary = summary + '$name ${counts[name]} 個\n';
    }

    String isPress = '';
    if (kid.drawTimes == 0) {
      isPress = '今天還沒抽喔！';
    } else {
      isPress = '抽了 ${kid.drawTimes} 次，抽到了${kid.lastItem}';
    }

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(children[selected].name),
            Text('已蒐集 ${kid.collection.length} 個\n$summary'),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      selected = 1;
                    });
                  },
                  child: Text('羽澄'),
                ),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      selected = 0;
                    });
                  },
                  child: Text('維翔'),
                ),
              ],
            ),
            kid.drawTimes == maxDraw
                ? Text('$isPress，\n今天已達上限囉')
                : Text(isPress),
            ElevatedButton(
              onPressed: kid.drawTimes < maxDraw ? addOne : null,
              child: Text('按我'),
            ),
          ],
        ),
      ),
    );
  }
}
