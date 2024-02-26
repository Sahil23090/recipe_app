import 'package:flutter/cupertino.dart';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:recipe/pages/recipe_details.dart';

import '../model/data_model.dart';


class SearchPage extends StatefulWidget {
  String? search;
  SearchPage({this.search});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  List<DataModel> list = <DataModel>[];

  String? text;

  getApiData(search) async {
    // Recipe Api URl
    final url =
        "https://api.edamam.com/search?q=$search&app_id=998b43e1&app_key=3e8e383def12cb054edc166936602d69&from=0&to=50&calories=591-722&health=alcohol-free";

    var response = await http.get(Uri.parse(url));
    Map json = jsonDecode(response.body);
    json['hits'].forEach((e) {
      DataModel model = DataModel(
          url: e['recipe']['url'],
          image: e['recipe']['image'],
          source: e['recipe']['source'],
          label: e['recipe']['label']);

      setState(() {
        list.add(model);
      });
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getApiData(widget.search);
  }

  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.grey.shade300),
        elevation: 1,
        title: Text(
          "R E C I P E",
          style: TextStyle(color: Colors.grey.shade300),
        ),
        centerTitle: true,
        backgroundColor: Colors.greenAccent.shade700,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18.0),
        child: Container(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                GridView.builder(
                  shrinkWrap: true,
                  primary: true,
                  physics: const ScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 5,
                    mainAxisSpacing: 5,
                  ),
                  itemCount: list.length,
                  itemBuilder: (context, i) {
                    final x = list[i];
                    return GridTile(
                      child: InkWell(
                        onTap: () {
                          //   Navigate to next page
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => RecipeDetailes(
                                    url: x.url,
                                  )));
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20.0),
                            image: DecorationImage(
                              image: NetworkImage(x.image.toString()),
                              fit: BoxFit.cover,
                            ),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Container(
                                width: w,
                                decoration: const BoxDecoration(
                                  // borderRadius: BorderRadius.only(bottomRight: Radius.circular(20.0),bottomLeft: Radius.circular(20.0)),
                                  color: Colors.black54,
                                ),
                                child: Center(
                                  child: Text(
                                    x.label.toString(),
                                    style: TextStyle(
                                      color: Colors.grey.shade300,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}