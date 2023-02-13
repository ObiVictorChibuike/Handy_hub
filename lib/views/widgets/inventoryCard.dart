import 'package:flutter/material.dart';

class inventory_Card extends StatelessWidget {
  const inventory_Card({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top:20.0),
      child: Container(
        color: Colors.white,
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height * .23,
        child: Padding(
          padding: const EdgeInsets.all(2.0),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(left:15.0, right: 15.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('1234568291', style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),),
                        Text('Tissue Paper', style: TextStyle(fontSize: 10),),
                      ],
                    ),
                    Icon(Icons.save,color: Color(0XFF187226),)
                  ],
                ),
              ),
              Row(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(30)),
                    ),
                    width: MediaQuery.of(context).size.width * .4,
                    child: Image.asset('assets/images/inventory01.png'),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * .3,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Measurement Unit', style: TextStyle(color: Colors.blueGrey, fontSize: 12),),
                            Text('Supplier Name', style: TextStyle(color: Colors.blueGrey, fontSize: 12),),
                          ],
                        ),
                        Column(
                          children: [
                            Row(
                              children: [
                                Text('QualityIn', style: TextStyle(color: Colors.blueGrey, fontSize: 12),),
                                SizedBox(
                                  width: 10,
                                ),
                                Text('4',style: TextStyle(fontWeight: FontWeight.bold,  fontSize: 12),),
                              ],
                            ),
                            Row(
                              children: [
                                Text('QualityOut', style: TextStyle(color: Colors.blueGrey,  fontSize: 12),),
                                SizedBox(
                                  width: 10,
                                ),
                                Text('2',style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12),),
                              ],
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            Row(
                              children: [
                                Text('Stock', style: TextStyle(color: Colors.blueGrey, fontSize: 12),),
                                SizedBox(
                                  width: 10,
                                ),
                                Text('0', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12),),
                              ],
                            ),
                            Row(
                              children: [
                                Text('RestockLevel', style: TextStyle(color: Colors.blueGrey, fontSize: 12),),
                                SizedBox(
                                  width: 10,
                                ),
                                Text('4',style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12),),
                              ],
                            ),
                            Row(
                              children: [
                                Text('Balance', style: TextStyle(color: Colors.blueGrey, fontSize: 12),),
                                SizedBox(
                                  width: 10,
                                ),
                                Text('-80',style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12),),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * .28,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Cartons', style: TextStyle(color: Colors.blueGrey, fontSize: 12, fontWeight: FontWeight.bold),),
                            Text('Cartons', style: TextStyle(color: Colors.blueGrey, fontSize: 12, fontWeight: FontWeight.bold),),
                          ],
                        ),
                        Column(
                          children: [
                            Row(
                              children: [
                                Text('UnitCostIn', style: TextStyle(color: Colors.blueGrey, fontSize: 11),),
                                SizedBox(
                                  width: 10,
                                ),
                                Text('50',style: TextStyle(fontWeight: FontWeight.bold,  fontSize: 11),),
                              ],
                            ),
                            Row(
                              children: [
                                Text('UnitCostOut', style: TextStyle(color: Colors.blueGrey,  fontSize: 11),),
                                SizedBox(
                                  width: 10,
                                ),
                                Text('70',style: TextStyle(fontWeight: FontWeight.bold, fontSize: 11),),
                              ],
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            Row(
                              children: [
                                Text('TotalStockIn', style: TextStyle(color: Colors.blueGrey, fontSize: 11),),
                                SizedBox(
                                  width: 10,
                                ),
                                Text('200', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 11),),
                              ],
                            ),
                            Row(
                              children: [
                                Text('TOtalCostOut', style: TextStyle(color: Colors.blueGrey, fontSize: 11),),
                                SizedBox(
                                  width: 10,
                                ),
                                Text('280',style: TextStyle(fontWeight: FontWeight.bold, fontSize: 11),),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),

            ],
          ),
        ),
      ),
    );
  }
}
