import 'package:flutter/material.dart';

import 'reccomend_page.dart';

class QuestionPage extends StatefulWidget {
  const QuestionPage({Key? key}) : super(key: key);

  @override
  State<QuestionPage> createState() => _QuestionPageState();
}

class _QuestionPageState extends State<QuestionPage> {
  //ToDo: ここに使用する変数を定義しよう！
  double selectNumber = 0;
  String isSelectedItem = '選択してください';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Re.Ra.Ku'),
        centerTitle: false,
      ),
      body: Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Spacer(flex: 2),
            Container(
              color: Colors.green,
              padding: const EdgeInsets.all(5.0),
              child: const Center(
                child: Text(
                  '以下の質問に回答で\nあなたにオススメのコースを算出します！',
                  style: TextStyle(fontSize: 16, color: Colors.white),
                ),
              ),
            ),
            const Spacer(),
            const Text('■ 本日のお疲れはどれくらいですか？', style: TextStyle(fontSize: 15)),
            const SizedBox(height: 20),
            Center(
              child: Text(
                selectNumber.toString(),
                style: const TextStyle(fontSize: 20, color: Colors.green),
              ),
            ),
            Slider(
              min: 0,
              max: 10,
              value: selectNumber,
              divisions: 10,
              label: '$selectNumber',
              onChanged: (newValue) {
                setState(() {
                  selectNumber = newValue;
                });
              },
              activeColor: Colors.green,
              inactiveColor: Colors.grey,
            ),
            const Spacer(),
            const Text('■ 一番辛い箇所はどちらですか？', style: TextStyle(fontSize: 15)),
            const SizedBox(height: 10),
            DropdownButton(
                items: const [
                  DropdownMenuItem(value: '選択してください', child: Text('選択してください')),
                  DropdownMenuItem(value: '肩', child: Text('肩')),
                  DropdownMenuItem(value: '首', child: Text('首')),
                  DropdownMenuItem(value: '肩甲骨', child: Text('肩甲骨')),
                  DropdownMenuItem(value: '腰', child: Text('腰')),
                  DropdownMenuItem(value: '足', child: Text('足'))
                ],
                value: isSelectedItem,
                underline: Container(
                  height: 1,
                  color: Colors.lightGreen,
                ),
                isExpanded: true,
                onChanged: (String? value) {
                  setState(() {
                    isSelectedItem = value!;
                  });
                }),
            const Spacer(),
            Center(
                child: ElevatedButton(
                    onPressed: () {
                      if (selectNumber == 0) {
                        ScaffoldMessenger.of(context)
                            .showSnackBar(const SnackBar(
                          content: Text('本日のお疲れを入力してください'),
                          backgroundColor: Colors.red,
                        ));
                      } else if (isSelectedItem == '選択してください') {
                        ScaffoldMessenger.of(context)
                            .showSnackBar(const SnackBar(
                          content: Text('一番辛い箇所を選択してください'),
                          backgroundColor: Colors.red,
                        ));
                      } else {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => RecommendPage(
                                  tiredPoint: selectNumber,
                                  painPart: isSelectedItem),
                            ));
                      }
                    },
                    child: const Text(
                      '決定',
                      style: TextStyle(fontSize: 15),
                    ))),
            const Spacer(flex: 2),
          ],
        ),
      ),
    );
  }
}
