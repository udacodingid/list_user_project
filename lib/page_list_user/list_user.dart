import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:listuser/model/model_user.dart';

class PageListUsers extends StatefulWidget {
  const PageListUsers({Key? key}) : super(key: key);

  @override
  _PageListUsersState createState() => _PageListUsersState();
}

class _PageListUsersState extends State<PageListUsers> {
  List<ModelUsers> listUsers = [];

  var loading = false;

  Future<Null> getData() async {
    setState(() {
      loading = true;
    });

    final responseData =
    await http.get(Uri.parse('https://jsonplaceholder.typicode.com/users'));
    if (responseData.statusCode == 200) {
      //ketika berhasil get data
      final data = jsonDecode(responseData.body);
      setState(() {
        for (Map i in data) {
          listUsers.add(ModelUsers.fromJson(i));
        }
        loading = false;
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('List Users'),
      ),
      body: Container(
        child: loading
            ? Center(
          child: CircularProgressIndicator(),
        )
            : ListView.builder(
          itemCount: listUsers.length,
          itemBuilder: (context, i) {
            final nDataList = listUsers[i];
            return InkWell(
              onTap: () {},
              child: Container(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Card(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            nDataList.name,
                            style: TextStyle(
                                color: Colors.deepOrange,
                                fontSize: 15,
                                fontWeight: FontWeight.bold),
                          ),
                          Divider(),
                          Text(
                            nDataList.phone,
                            style: TextStyle(
                              fontSize: 12,
                            ),
                          ),
                          Text(
                            nDataList.website,
                            style: TextStyle(
                              fontSize: 12,
                            ),
                          ),
                          Divider(),
                          Text(
                            nDataList.address.street,
                            style: TextStyle(
                              fontSize: 12,
                            ),
                          ),
                          Text(
                            nDataList.address.city,
                            style: TextStyle(
                              fontSize: 12,
                            ),
                          )
                        ],
                      ),
                    ),
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