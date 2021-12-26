import 'dart:collection';
import 'package:flutter/material.dart';
import 'package:test_app/utils/helper.dart';

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


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Tic - Tac - Toe',style: TextStyle(fontSize: 14))
      ),
      body: Container(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: MediaQuery.of(context).orientation == Orientation.landscape ? 3 : 3),
              itemCount: 9,
              shrinkWrap: true,
              itemBuilder: (BuildContext context,int index){
                return GestureDetector(
                  onTap: () => onClickContainer(context, index),
                  child: Container(
                    margin: const EdgeInsets.all(1),
                    decoration: const BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.all(Radius.circular(2.0))
                    ),
                    child: map[index] == null ? null : Icon(map[index],color: Colors.white,size: 90)
                  )
                );
              }
            ),
            const SizedBox(height: 20),
            Container(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Won : $wonPoint',style: const TextStyle(fontSize: 16,color: Colors.black,fontWeight: FontWeight.bold)),
                  Text('Draw : $loosePoint',style: const TextStyle(fontSize: 16,color: Colors.red,fontWeight: FontWeight.bold))
                ]
              )
            )
          ]
        )
      )
    );
  }

  clearData(bool result){
    if(result){
      wonPoint++;
    }else{
      loosePoint++;
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
          map[index] = Icons.cancel_outlined;
          crossTurn = false;
        }else{
          map[index] = Icons.circle_outlined;
          crossTurn = true;
        }
      });
      var result = gameAlgorithm();
      if(result){
        showSnackbar(context, 'Won');
        clearData(result);
      }else if(playTurn == 9 && !result){
        showSnackbar(context, 'Draw');
        clearData(result);
      }
    }else{
      showSnackbar(context, 'Please Reset Game No Turn is available');
    }
  }

  bool gameAlgorithm(){
    if(map[0] == map[1] && map[0] == map[2] && map[1] != null){
      return true;
    }
    if(map[3] == map[4] && map[3] == map[5] && map[4] != null){
      return true;
    }
    if(map[6] == map[7] && map[6] == map[8] && map[7] != null){
      return true;
    }
    if(map[0] == map[3] && map[0] == map[6] && map[3] != null){
      return true;
    }
    if(map[1] == map[4] && map[1] == map[7] && map[4] != null){
      return true;
    }
    if(map[2] == map[5] && map[2] == map[8] && map[5] != null){
      return true;
    }
    if(map[0] == map[4] && map[0] == map[8] && map[4] != null){
      return true;
    }
    if(map[2] == map[4] && map[2] == map[6] && map[4] != null){
      return true;
    }
    return false;
  }

}