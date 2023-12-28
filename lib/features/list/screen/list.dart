import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../repository/list_repository.dart';

class MyList extends StatefulWidget {
  const MyList({Key? key}) : super(key: key);

  @override
  State<MyList> createState() => _MyListState();
}

class _MyListState extends State<MyList> {

  @override
  void initState() {
    ListRepository().getAllLeads();
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(
            height: 30,
          ),
          Padding(
            padding: const EdgeInsets.all(9.0),
            child: Container(
              color: Colors.white38,
              height: 50,
              width: double.infinity,
              child: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.list, color: Colors.black),
                        SizedBox(width: 10),
                        Text('Lead List', style: TextStyle(color: Colors.black)),
                      ],
                    ),
                    Icon(CupertinoIcons.bell, color: Colors.black),
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: 5, // Adjust the itemCount as needed
              itemBuilder: (context, index) {
                // Build your list items here
                return Padding(
                  padding: EdgeInsets.only(left: 15, right: 15, top: 10),
                  child: Container(
                    height: 80,
                    child: Row(
                      children: [
                        Container(
                          height: 60,
                          width: 35,
                          decoration: BoxDecoration(
                              color: Colors.blueGrey,
                              borderRadius: BorderRadius.circular(5)),
                          child: Center(
                            child: Text(
                              '01',
                              style: TextStyle(color: Colors.black),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 15,
                        ),
                        Container(
                          child: Column(
                            children: [
                              SizedBox(
                                width: 25,
                              ),
                              Padding(
                                padding: EdgeInsets.only(top: 10),
                                child: Text(
                                  'David marugali',
                                  style: TextStyle(
                                      color: Colors.blue, fontSize: 17),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(right: 20),
                                child: Text(
                                  'example@gmail.com',
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 10),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(right: 20),
                                child: Text(
                                  'Created: 05/03/2023',
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 10),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(right: 25),
                                child: Text(
                                  'mob: 974543523',
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 10),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          width: 30,
                        ),
                        Container(
                          width: 60,
                          height: 25,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.blue),
                          child: Center(child: Text('flutter')),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Container(
                          child: Column(
                            children: [
                              Padding(
                                padding:  EdgeInsets.only(top: 13),
                                child: Row(
                                  children: [
                                    Icon(
                                      CupertinoIcons.location_solid,
                                      size: 10,
                                    ),
                                    Text(
                                      'calicut',
                                      style: TextStyle(fontSize: 10),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(height: 5,),
                              Icon(
                                CupertinoIcons.phone,
                                size: 30,color: Colors.black,
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
