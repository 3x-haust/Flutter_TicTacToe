import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(home: TicTacToe()));
}

class TicTacToe extends StatefulWidget {
  @override
  _TicTacToeState createState() => _TicTacToeState();
}

class _TicTacToeState extends State<TicTacToe> {
  List<String> board = List.filled(9, '');
  bool xTurn = true; // X가 먼저 시작
  String winner = '';

  void _click(int index) {
    if (board[index] != '' || winner != '') {
      return;
    }

    setState(() {
      board[index] = xTurn ? 'X' : 'O';
      xTurn = !xTurn;
    });

    checkWinner();
  }

  void checkWinner() {
    // 승리 조건
    const winConditions = [
      [0, 1, 2],
      [3, 4, 5],
      [6, 7, 8],
      [0, 3, 6],
      [1, 4, 7],
      [2, 5, 8],
      [0, 4, 8],
      [2, 4, 6],
    ];

    for (var condition in winConditions) {
      if (board[condition[0]] != '' &&
          board[condition[0]] == board[condition[1]] &&
          board[condition[1]] == board[condition[2]]) {
        // 승리 다이얼로그 표시
        showEndDialog(board[condition[0]] + '가 승리했습니다!');
        return;
      }
    }

    // 무승부 조건
    if (!board.contains('')) {
      showEndDialog('무승부입니다!');
      return;
    }
  }

  void showEndDialog(String message) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('게임 종료'),
          content: Text(message),
          actions: <Widget>[
            ElevatedButton(
              child: Text('다시 하기'),
              onPressed: () {
                resetGame();
                Navigator.of(context).pop(); // 다이얼로그 닫기
              },
            ),
          ],
        );
      },
    );
  }


  void resetGame() {
    setState(() {
      board = List.filled(9, '');
      winner = '';
      xTurn = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text(winner == '' ? (xTurn ? 'X 차례' : 'O 차례') : winner),
        ),
        body: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
          ),
          itemCount: 9,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () => _click(index),
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black),
                ),
                child: Center(
                  child: Text(
                    board[index],
                    style: TextStyle(fontSize: 40),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
