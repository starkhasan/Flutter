import 'dart:collection';
import 'package:flutter/material.dart';
import 'package:test_app/utils/helper.dart';
import 'dart:math';

class TicTacToa extends StatefulWidget {
  const TicTacToa({ Key? key }) : super(key: key);

  @override
  State<TicTacToa> createState() => _TicTacToaState();
}

class _TicTacToaState extends State<TicTacToa> with Helper{

  int playTurn = 0;
  var map = HashMap<int,dynamic>.fromIterables([0,1,2,3,4,5,6,7,8],[null,null,null,null,null,null,null,null,null]);
  var crossTurn = false;
  var wonPoint = 0;
  var loosePoint = 0;
  var userFirstNumber = 0;
  int playerCross = 0;
  int playerCircle = 0;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(onPressed: () {
        var item = showGameDialog(0);
        print(item);
      },child: Icon(Icons.add)),
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Tic - Tac - Toe',style: TextStyle(fontSize: 14))
      ),
      body: Container(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(width: 0.8,color: const Color(0xFFD6D6D6)),
                      borderRadius: const BorderRadius.all(Radius.circular(5))
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Container(
                          color: Colors.grey[350],
                          padding: const EdgeInsets.only(left: 5,right: 5,top: 2,bottom: 2),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text('Player1'),
                              Transform.rotate(angle: pi/4,child: const Icon(Icons.add,size:24))
                            ]
                          )
                        ),
                        Container(
                          alignment: Alignment.centerRight,
                          padding: const EdgeInsets.only(left: 5,right: 5,top: 3,bottom: 3),
                          child: Text(
                            playerCross.toString().padLeft(4,'0'),
                            textAlign: TextAlign.end,
                            style: const TextStyle(color: Colors.amber,fontSize: 25,fontWeight: FontWeight.bold)
                          )
                        )
                      ]
                    )
                  )
                ),
                const SizedBox(width: 50),
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(width: 1,color: const Color(0xFFD6D6D6)),
                      borderRadius: const BorderRadius.all(Radius.circular(5))
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Container(
                          color: Colors.grey[350],
                          padding: const EdgeInsets.only(left: 5,right: 5,top: 2,bottom: 2),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text('Player2'),
                              Transform.rotate(angle: pi/4,child: const Icon(Icons.circle_outlined,size:24))
                            ]
                          )
                        ),
                        Container(
                          alignment: Alignment.centerRight,
                          padding: const EdgeInsets.only(left: 5,right: 5,top: 3,bottom: 3),
                          child: Text(
                            playerCircle.toString().padLeft(4,'0'),
                            textAlign: TextAlign.end,
                            style: const TextStyle(color: Colors.amber,fontSize: 25,fontWeight: FontWeight.bold)
                          )
                        )
                      ]
                    )
                  )
                )
              ]
            ),
            GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: MediaQuery.of(context).orientation == Orientation.landscape ? 3 : 3),
              itemCount: 9,
              shrinkWrap: true,
              padding: const EdgeInsets.only(top: 8),
              itemBuilder: (BuildContext context,int index){
                return GestureDetector(
                  onTap: () => onClickContainer(context, index),
                  child: Container(
                    margin: const EdgeInsets.all(1),
                    decoration: const BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.all(Radius.circular(2.0))
                    ),
                    child: map[index] == null ? null : Transform.rotate(angle: pi / 4,child: Icon(map[index],color: Colors.white,size: 90))
                  )
                );
              }
            )
          ]
        )
      )
    );
  }

  showGameDialog(int result) {
    showGeneralDialog<bool>(
      barrierLabel: 'GameDialog',
      barrierDismissible: true,
      context: context, 
      pageBuilder: (_, __,___){
        return Align(
          alignment: Alignment.center,
          child: Container(
            height: MediaQuery.of(context).size.height * 0.30,
            width: MediaQuery.of(context).size.width * 0.60,
            child: Column(
              children: [
                result == -1
                ? Row(mainAxisAlignment: MainAxisAlignment.center,children: [ Transform.rotate(angle: pi/4,child: const Icon(Icons.add,size: 100,color: Colors.white)),const Icon(Icons.circle_outlined,size: 70,color: Colors.white)])
                : Transform.rotate(
                  angle: pi/4,
                  child: Icon(result == 0 ? Icons.add : Icons.circle_outlined,size: result == 0 ? 100 : 70,color: Colors.white)
                ),
                Text(result == -1 ? 'DRAW!' : 'WINNER!',style: const TextStyle(color: Colors.white,fontSize: 30,fontWeight: FontWeight.bold,decoration: TextDecoration.none,fontFamily: ''))
              ]
            ),
            margin: const EdgeInsets.only(bottom: 50, left: 12, right: 12),
            decoration: BoxDecoration(
              color: Colors.green,
              borderRadius: BorderRadius.circular(10)
            )
          )
        ); 
      },
      transitionBuilder: (_, anim, __, child) {
        return SlideTransition(
          position: Tween(begin: const Offset(0, 1), end: const Offset(0, 0)).animate(anim),
          child: child,
        );
      }
    );
  }

  clearData(int result){
    if(result == 0){
      playerCross++;
    }else if(result == 1){
      playerCircle++;
    }
    playTurn = 0;
    map.clear();
    setState((){});
  }

  onClickContainer(BuildContext context,int index){
    if(playTurn < 9){
      setState((){
        playTurn++;
        if(crossTurn){
          map[index] = Icons.add;
          crossTurn = false;
        }else{
          map[index] = Icons.circle_outlined;
          crossTurn = true;
        }
      });
      var result = gameAlgorithm();
      if(result != -1){
        showSnackbar(context, 'Player${result+1} WON');
        clearData(result);
      }else if(playTurn == 9 && result == -1){
        showSnackbar(context, 'Draw');
        clearData(result);
      }
    }else{
      showSnackbar(context, 'Please Reset Game No Turn is available');
    }
  }

  int gameAlgorithm(){
    if(map[0] == map[1] && map[0] == map[2] && map[1] != null){
      if(map[0] == Icons.add){
        return 0;
      }
      return 1;
    }
    if(map[3] == map[4] && map[3] == map[5] && map[4] != null){
      if(map[3] == Icons.add){
        return 0;
      }
      return 1;
    }
    if(map[6] == map[7] && map[6] == map[8] && map[7] != null){
      if(map[6] == Icons.add){
        return 0;
      }
      return 1;
    }
    if(map[0] == map[3] && map[0] == map[6] && map[3] != null){
      if(map[0] == Icons.add){
        return 0;
      }
      return 1;
    }
    if(map[1] == map[4] && map[1] == map[7] && map[4] != null){
      if(map[1] == Icons.add){
        return 0;
      }
      return 1;
    }
    if(map[2] == map[5] && map[2] == map[8] && map[5] != null){
      if(map[2] == Icons.add){
        return 0;
      }
      return 1;
    }
    if(map[0] == map[4] && map[0] == map[8] && map[4] != null){
      if(map[0] == Icons.add){
        return 0;
      }
      return 1;
    }
    if(map[2] == map[4] && map[2] == map[6] && map[4] != null){
      if(map[2] == Icons.add){
        return 0;
      }
      return 1;
    }
    return -1;
  }

}