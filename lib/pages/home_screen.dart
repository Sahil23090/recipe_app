import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:recipe/pages/recipe_details.dart';
import 'package:recipe/pages/search_page.dart';

import '../model/data_model.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<DataModel> list = <DataModel>[];
  String? text;

  // Recipe Api URl
  final url =
      "https://api.edamam.com/search?q=all&app_id=998b43e1&app_key=3e8e383def12cb054edc166936602d69&from=1&to=100&calories=591-722&health=alcohol-free";

  getApiData() async {
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
    getApiData();
  }

  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.grey.shade300,
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

      // drawer
      drawer: Drawer(
        backgroundColor: Colors.greenAccent.shade700,
        child: Column(
          children: [
            DrawerHeader(
                child: Icon(
                  Icons.fastfood_outlined,
                  color: Colors.grey.shade300,
                  size: 45,
                )),

            const SizedBox(
              height: 20,
            ),

            ListTile(
              title: Text("H O M E",
                style: TextStyle(
                    color: Colors.grey.shade300
                ),
              ),
              leading: Icon(Icons.home,color: Colors.grey.shade300,),
            ),

            const SizedBox(
              height: 10,
            ),
            ListTile(
              title: Text("S E T T I N G",
                style: TextStyle(
                    color: Colors.grey.shade300
                ),
              ),
              leading: Icon(Icons.settings,color: Colors.grey.shade300,),
            )
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(
                height: 10,
              ),

              // SearchBar
              TextField(
                style: const TextStyle(color: Colors.black),
                onChanged: (value) {
                  text = value;
                },
                decoration: InputDecoration(
                  suffixIcon: IconButton(
                      onPressed: () {
                        //   search page
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => SearchPage(
                                  search: text,
                                )));
                      },
                      icon: const Icon(
                        Icons.search,
                        color: Colors.black,
                      )),
                  label: const Text("Search Recipes"),
                  labelStyle: const TextStyle(
                    color: Colors
                        .black, // Change the label text color here
                  ),
                  hintText: "eg - burger",
                  hintStyle:
                  const TextStyle(color: Colors.black54),
                  border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.greenAccent.shade700),
                      borderRadius: BorderRadius.circular(25.0)),
                  fillColor: Colors.grey.shade200,
                  filled: true,
                ),
              ),

              const SizedBox(
                height: 10,
              ),

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
                            scale: 1.0,
                            image: NetworkImage(x.image.toString()),
                            fit: BoxFit.cover,
                          ),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Container(
                              width: w,
                              height: 38,
                              decoration: const BoxDecoration(
                                // borderRadius: BorderRadius.only(bottomRight: Radius.circular(20.0),bottomLeft: Radius.circular(20.0)),
                                color: Colors.black54,
                              ),
                              child: Center(
                                child: Text(
                                  x.label.toString(),
                                  style: TextStyle(
                                      color: Colors.grey.shade300,
                                      fontWeight: FontWeight.bold
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
    );
  }
}