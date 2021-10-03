import 'package:covid_info/model/response/VaccineResponse.dart';
import 'package:flutter/material.dart';

class VaccinationDialog extends StatelessWidget {
  final VaccinationResponse response;
  const VaccinationDialog({Key? key, required this.response}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(topLeft: Radius.circular(10),topRight: Radius.circular(10),bottomLeft: Radius.circular(10),bottomRight: Radius.circular(10))
        ),
        margin: EdgeInsets.only(
          top: MediaQuery.of(context).size.height * 0.10,
          bottom: MediaQuery.of(context).size.height * 0.02,
          left: MediaQuery.of(context).size.width * 0.04,
          right: MediaQuery.of(context).size.width * 0.04
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: double.infinity,
              padding: EdgeInsets.only(top: 14,bottom: 14),
              decoration: BoxDecoration(
                color: Colors.blue[400],
                borderRadius: BorderRadius.only(topLeft: Radius.circular(10),topRight: Radius.circular(10))
              ),
              child: Text(
                response.country,
                style: TextStyle(color: Colors.black,fontSize: 15,decoration: TextDecoration.none,fontWeight: FontWeight.bold,fontFamily: ''),
                textAlign: TextAlign.center,
              ),
            ),
            Container(
              color: Color(0xFFE3F2FD),
              padding: EdgeInsets.only(left: 5,right: 5,top: 8,bottom: 8),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      'Date',
                      style: TextStyle(fontFamily: '',color:Colors.black,decoration: TextDecoration.none,fontSize: 12,fontWeight: FontWeight.bold),
                    )
                  ),
                  Expanded(
                    child: Text(
                      'Total',
                      style: TextStyle(fontFamily: '',color:Colors.black,decoration: TextDecoration.none,fontSize: 12,fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center
                    )
                  ),
                  Expanded(
                    child: Text(
                      'Dose1',
                      style: TextStyle(fontFamily: '',color:Colors.black,decoration: TextDecoration.none,fontSize: 12,fontWeight: FontWeight.bold),
                      textAlign: TextAlign.right
                    )
                  ),
                  Expanded(
                    child: Text(
                      'Dose2',
                      style: TextStyle(fontFamily: '',color:Colors.black,decoration: TextDecoration.none,fontSize: 12,fontWeight: FontWeight.bold),
                      textAlign: TextAlign.right
                    )
                  )
                ]
              )
            ),
            Flexible(
              child: ListView.separated(
              physics: ScrollPhysics(),
              itemCount: response.data.length,
              shrinkWrap: true,
              padding: EdgeInsets.zero,
              itemBuilder: (context,index){
                return Container(
                  color: index%2 == 0 ? Colors.white : Colors.grey[100],
                  padding: EdgeInsets.only(left: 5,right: 5,top: 10,bottom: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Expanded(
                        child: Text(
                          response.data[index].date.split('-').reversed.join('-'),
                          textAlign: TextAlign.left,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(fontFamily: '',color: Colors.black,fontSize: 12,decoration: TextDecoration.none,fontWeight: FontWeight.normal)
                        )
                      ),
                      Expanded(
                        child: Text(
                          response.data[index].totalVaccinations != null
                          ? response.data[index].totalVaccinations.toString()
                          : 'N/A',
                          textAlign: TextAlign.center,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(fontFamily: '',color: Colors.black,fontSize: 12,decoration: TextDecoration.none,fontWeight: FontWeight.normal)
                        )
                      ),
                      Expanded(
                        child: Text(
                          response.data[index].peopleVaccinated != null
                          ? response.data[index].peopleVaccinated.toString()
                          : 'N/A',
                          textAlign: TextAlign.right,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(fontFamily: '',color: Colors.black,fontSize: 12,decoration: TextDecoration.none,fontWeight: FontWeight.normal)
                        )
                      ),
                      Expanded(
                        child: Text(
                          response.data[index].peopleFullyVaccinated != null
                          ? response.data[index].peopleFullyVaccinated.toString()
                          : 'N/A',
                          textAlign: TextAlign.right,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(fontFamily: '',color: Colors.black,fontSize: 12,decoration: TextDecoration.none,fontWeight: FontWeight.normal)
                        )
                      )
                    ],
                  )
                );
              }, separatorBuilder: (BuildContext context, int index) {
                return Divider(height: 1,thickness: 1);
              },
            )
            )
          ]
        )
      ),
    );
  }
}
