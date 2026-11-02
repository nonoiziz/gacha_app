import 'dart:math';

//每日抽獎次數上限
int maxDraw = 5;

//每個小孩自己的蒐集冊
class Child {
  String name;
  int drawTimes;
  List<Prize> collectionBook;

  Child(this.name, this.drawTimes, this.collectionBook);
}

//獎品模板：每個獎品有名字和圖片路徑
class Prize {
  String name;
  String imagePath;
  Prize(this.name, this.imagePath);
}

void main() {

  String machineName = '陪睡娃扭蛋機';

  print('$machineName 開張了!');

  childrenDraw(children[0]);
  childrenDraw(children[1]);
}



//獎品箱：機器裡所有可以抽的獎品
List<Prize> prizes = [
  Prize('小巴', 'xiaoba.jpg'),
  Prize('吉依卡哇', 'jiikawa.jpg'),
  Prize('烏薩奇', 'wusagi.jpg'),
];

List<Child> children = [Child('維翔', 0, []), Child('羽澄', 0, [])];



//隨機抽取獎項的程式
Prize drawGame() {
  Random random = Random();

  int randomResult = random.nextInt(prizes.length);
  return prizes[randomResult];
}

//計算集卡冊裡放入了幾個一樣的品項
Map<String, int> countPrizes(List<Prize> list) {
  Map<String, int> counts = {};
  for (Prize p in list) {
    if (counts.containsKey(p.name)) {
      counts[p.name] = counts[p.name]! + 1;
    } else {
      counts[p.name] = 1;
    }
  }
  return counts;
}

//判定今天還能不能抽的布林值
bool canDraw(int todayDrawCount) {
  return (todayDrawCount < maxDraw ? true : false);
}

//判斷今天還能不能抽，每個孩子分開的集卡冊
void childrenDraw(Child kid) {
  for (int i = 0; i < maxDraw; i++) {
    if (canDraw(kid.drawTimes)) {
      Prize result = drawGame();
      kid.drawTimes = kid.drawTimes + 1;
      print("今天已經抽了${kid.drawTimes}次，還可以抽${maxDraw - kid.drawTimes}次");
      print('抽到了${result.name},${result.imagePath}');
      kid.collectionBook.add(result);
      print(kid.collectionBook.length);
    } else {
      print('今天已經不能抽了喔');
    }
  }
  print('-----${kid.name}的蒐集冊-----');

  Map<String, int> counts = countPrizes(kid.collectionBook);

  for (String name in counts.keys) {
    print('$name 有 ${counts[name]}個');
  }
}
