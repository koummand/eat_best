import 'package:flutter/material.dart';

class MyHomeDetails extends StatelessWidget {
  String title;
  String image;
  String ingredients;
  String recette;

  MyHomeDetails(
      {super.key,
      required this.title,
      required this.image,
      required this.ingredients,
      required this.recette});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage(
                  "assets/images/Comment-reussir-ses-photos-de-nourriture-sur-Instagram.jpg"),
              fit: BoxFit.cover,
            ),
          ),
          child: Scaffold(
            backgroundColor: const Color.fromARGB(229, 255, 255, 255),
            appBar: AppBar(
               backgroundColor: const Color.fromARGB(142, 0, 0, 0),
              centerTitle: true,
              title: const Text('Details Recipe',style: TextStyle(color:Colors.white ),),
            ),
            body: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              padding: const EdgeInsets.only(left: 5, right: 5),
              child: Center(
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        '$title',
                        style: const TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 30),
                      ),
                      ClipOval(
                        child: Image.asset(
                          image,
                          width: 300,
                          height: 300,
                        ),
                      ),
                      const Text('Ingredients',
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 25)),
                      const SizedBox(
                        height: 15,
                      ),
                      Text('$ingredients',
                          style: const TextStyle(
                              color: Colors.black, fontSize: 20)),
                      const SizedBox(
                        height: 30,
                      ),
                      const Text('Recipe:',
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 25)),
                      const SizedBox(
                        height: 15,
                      ),
                      Text('$recette',
                          style: const TextStyle(
                              color: Colors.black, fontSize: 20)),
                      const SizedBox(
                        height: 40,
                      ),
                    ]),
              ),
            ),
          ),
        ));
  }
}
