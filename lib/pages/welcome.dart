import 'package:flutter/material.dart';

import 'home_screen.dart';


class WelcomePage extends StatelessWidget {
  const WelcomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.greenAccent.shade700,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 350,
              width: 350,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/images/recipe.png"),
                ),
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Yummmy\nRecipes",
                  style: TextStyle(
                      color: Colors.grey.shade300,
                      fontSize: 44,
                      fontFamily: 'Roboto',
                      fontWeight: FontWeight.bold),
                ),

                const SizedBox(
                  height: 10,
                ),
                const Text(
                  "Over 3000 Tasty recipes now at your\nfingertips an all-new Step-By-Step\ninstruction mode",
                  style: TextStyle(
                      color: Colors.black, fontWeight: FontWeight.w700,fontSize: 18),
                ),
                const SizedBox(
                  height: 20,
                ),

                Row(
                  children: [
                    GestureDetector(
                      onTap: (){
                        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>const HomePage()));
                      },
                      child: Text("Get Started",
                        style: TextStyle(
                            color: Colors.grey.shade300,
                            fontWeight: FontWeight.bold,
                            fontSize: 20
                        ),
                      ),
                    ),

                    const SizedBox(width: 5, ),
                    Icon(Icons.arrow_forward,color: Colors.grey.shade300,size: 20,)
                  ],
                )
              ],
            ),

          ],
        ),
      ),
    );
  }
}