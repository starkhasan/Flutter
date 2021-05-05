import 'package:flutter/material.dart';

class DraggableScrollSheet extends StatefulWidget {
  @override
  _DraggableScrollSheetState createState() => _DraggableScrollSheetState();
}

class _DraggableScrollSheetState extends State<DraggableScrollSheet> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('DraggableScroll'),
      ),
      body: Stack(
        fit: StackFit.expand,
        children: [
          Container(
            color: Colors.red
          ),
          SizedBox.expand(
            child: DraggableScrollableSheet(
              minChildSize: 0.15,
              initialChildSize: 0.15,
              builder: (context, scrollController) {
                return Container(
                  padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
                  decoration: BoxDecoration(
                    color: Colors.blue[100],
                    borderRadius: BorderRadius.only(topLeft: Radius.circular(15),topRight: Radius.circular(15))
                  ),
                  child: ListView.builder(
                    controller: scrollController,
                    physics: BouncingScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: 25,
                    itemBuilder: (context, index) {
                      return index == 0
                      ? Container(
                          width: MediaQuery.of(context).size.width,
                          margin: EdgeInsets.fromLTRB(MediaQuery.of(context).size.width * 0.45, 5, MediaQuery.of(context).size.width * 0.45, 5),
                          height: 5,
                          decoration: BoxDecoration(
                            color: Colors.grey,
                            borderRadius: BorderRadius.all(Radius.circular(15))
                          ),
                        )
                      : Card(child: ListTile(title: Text('Item $index')));
                    }
                  )
                );
              }
            )
          )
          // SizedBox.expand(
          //   child: DraggableScrollableSheet(
          //     minChildSize: 0.15,
          //     initialChildSize: 0.15,
          //     builder: (context, scrollController) {
          //       return SingleChildScrollView(
          //       controller: scrollController,
          //         child: Container(
          //           color: Colors.blue,
          //           height: MediaQuery.of(context).size.height,
          //           width: 200,
          //           child: Column(
          //             mainAxisSize: MainAxisSize.min,
          //             children: [
          //               getTile(),
          //               getTile(),
          //               getTile(),
          //               getTile(),
          //               getTile(),
          //               getTile(),
          //               getTile(),
          //               getTile()
          //             ],
          //           ),
          //         ),
          //       );
          //     }
          //   )
          // )
        ]
      )
    );
  }

  Widget getTile(){
    return Card(
      child: ListTile(
        title: Text('India'),
      )
    );
  }
}