import 'package:flutter/material.dart';

class ttc extends StatefulWidget {
  @override
  _ttcState createState() => _ttcState();
}

class _ttcState extends State<ttc> {
  bool isCross, gameDone;
  String message;
  List<String> gameState;

  // TODO: link up images
  AssetImage cross = AssetImage("images/cross.png");
  AssetImage circle = AssetImage("images/circle.png");
  AssetImage defaults = AssetImage("images/edit.png");

  // TODO: Initialize the state of box with empty
  @override
  void initState() {
    super.initState();
    this.resetGame();
  }

  // TODO: playGames Method
  playGames(int index) {
    if (this.gameDone == false) {
      if (this.gameState[index] == "Defaults") {
        setState(() {
          this.isCross
              ? this.gameState[index] = "Cross"
              : this.gameState[index] = "Circle";
          this.isCross = !this.isCross;
          this.checkWin();
        });
      }
    }
  }

  // TODO: ResetGame Method
  resetGame() {
    setState(() {
      this.gameState = List.generate(9, (int index) => "Defaults");
      this.isCross = true;
      this.gameDone = false;
      this.message = "";
    });
  }

  // TODO: getImage Method
  AssetImage getImage(String input) {
    switch (input) {
      case 'Defaults':
        return defaults;
        break;
      case 'Cross':
        return cross;
        break;
      case 'Circle':
        return circle;
        break;
    }
  }

  // Win Result
  winMes(String input, {bool draw = false}) {
    this.message = draw ? "This Game is Draw" : "${input} win the game";
    this.gameDone = true;
  }

  // TODO: Check Win logic
  checkWin() {
    // Check horizontally
    for (var i = 0; i < 3; i++) {
      if ((this.gameState[i] != "Defaults") &&
          (this.gameState[i] == this.gameState[i + 3]) &&
          (this.gameState[i + 3] == this.gameState[i + 6])) {
        setState(() {
          this.winMes(this.gameState[i]);
        });
      }
    }

    for (var i = 0; i < this.gameState.length; i += 3) {
      if ((this.gameState[i] != "Defaults") &&
          (this.gameState[i] == this.gameState[i + 1]) &&
          (this.gameState[i + 1] == this.gameState[i + 2])) {
        setState(() {
          this.winMes(this.gameState[i]);
        });
      }
    }

    if ((this.gameState[0] != "Defaults") &&
        (this.gameState[0] == this.gameState[4]) &&
        (this.gameState[4] == this.gameState[8])) {
      setState(() {
        this.winMes(this.gameState[0]);
      });
    }

    if ((this.gameState[2] != "Defaults") &&
        (this.gameState[2] == this.gameState[4]) &&
        (this.gameState[4] == this.gameState[6])) {
      setState(() {
        this.winMes(this.gameState[2]);
      });
    }
    if (!this.gameState.contains("Defaults")) {
      setState(() {
        this.winMes(this.gameState[0], draw: true);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Tic Tac Toe"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Expanded(
            child: GridView.builder(
              padding: EdgeInsets.all(20.0),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                childAspectRatio: 1.0,
                crossAxisSpacing: 1.0,
                mainAxisSpacing: 1.0,
              ),
              itemCount: this.gameState.length,
              itemBuilder: (context, i) => SizedBox(
                width: 100,
                height: 100,
                child: MaterialButton(
                  onPressed: () {
                    this.playGames(i);
                    print(this.gameState[i]);
                    print(this.isCross);
                  },
                  child: Image(
                    image: this.getImage(this.gameState[i]),
                  ),
                ),
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.all(30),
            child: Text(this.message),
          ),
          Container(
            padding: EdgeInsets.all(10.0),
            width: MediaQuery.of(context).size.width,
            child: RaisedButton(
              onPressed: resetGame,
              child: Text('Reset Game'),
            ),
          ),
        ],
      ),
    );
  }
}
