import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';
import 'package:flutter/rendering.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    return MaterialApp(
        title: 'StartUp Name Generator',
        home: RandomWords(),
    );
  }
}
class RandomWordsState extends State<RandomWords>{
  final _suggestions = <WordPair>[];
  final _biggerFont = const TextStyle(fontSize: 18.0);
  //dart 언어에서는 식별자 앞에 _(언더바)를 붙이면 private 으로 적용된다.
  Widget _buildSuggestions(){
    return ListView.builder(
      padding: const EdgeInsets.all(16.0),
      /*
      * itemBuilder 로 단어 쌍이 제안될 때마다 호출되고 각각을 ListTile 행에 배치한다.
      * 짝수 행인 경우 ListTile 행에 단어 쌍을 추가한다.
      * 홀수 행인 경우 시각적으로 각 항목을 구분하는 Divider 위젯을 추가한다.
      * 작은 기기에서는 구분선을 보기 어려울 수 있음
      * dart 문법에서는 ~/는 2로 나눈뒤 정수결과를 반환하는 연산자
      *
      * */
      itemBuilder: (context,i){
        if(i.isOdd) return Divider();
        final index = i ~/ 2;
        if(index >= _suggestions.length){
          _suggestions.addAll(generateWordPairs().take(10));
        }
        return _buildRow(_suggestions[index]);
      },
    );
  }
  Widget _buildRow(WordPair pair){
    return ListTile(
      title: Text(
        pair.asPascalCase,
        style: _biggerFont,
      ),
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
    appBar: AppBar(
      title: Text('Startup Name Generator'),
    ),
    body: _buildSuggestions(),
  );
  }
}

class RandomWords extends StatefulWidget{
  @override
  RandomWordsState createState() => RandomWordsState();
}