import 'dart:io';

import 'package:eat_bestly/vue/Parametre.dart';
import 'package:eat_bestly/vue/detailsmain.dart';
// import 'package:eat_bestly/vue/listplat.dart';
import 'package:eat_bestly/vue/modalform.dart';
import 'package:flutter/services.dart';
import 'package:image_picker_platform_interface/image_picker_platform_interface.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:async';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      home: MyHomePage(title: 'Food recognition image'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final ImagePicker picker = ImagePicker();

  File? image;

  Future pickImage(ImageSource source) async {
    try {
      final image = await picker.pickImage(source: source);
      if (image == null) return;

      // final imageTemporary = File(image.path);

      // setState(() {
      //   this.image = imageTemporary;
      // });
      final imagePermanently = await saveImagePermanently(image.path);

      setState(() {
        this.image = imagePermanently;
      });
    } on PlatformException catch (e) {
      debugPrint("failed to pick image: $e");
    }
  }

  Future saveImagePermanently(String imagePath) async {
    final directory = await getApplicationDocumentsDirectory();
    final name = basename(imagePath);
    final image = File('${directory.path}/$name');
    return File(imagePath).copy(image.path);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage(
              "assets/images/Comment-reussir-ses-photos-de-nourriture-sur-Instagram.jpg"),
          fit: BoxFit.cover,
        ),
      ),
      child: Scaffold(
        backgroundColor: const Color.fromARGB(131, 255, 255, 255),
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: const Color.fromARGB(142, 0, 0, 0),
          title: Text(widget.title),
        ),
        drawer: Container(
          width: 250,
          color: Colors.white,
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              Container(
                height: 100,
                child: const DrawerHeader(
                    decoration: BoxDecoration(
                      color: Colors.black,
                    ),
                    child: Text("Options & setting",
                        style: TextStyle(
                            color: Color.fromARGB(182, 255, 255, 255),
                            fontSize: 20,
                            fontWeight: FontWeight.bold))),
              ),
              ListTile(
                  leading: const Icon(
                    Icons.food_bank,
                    color: Colors.black,
                  ),
                  title: const Text(
                    "detail of food",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 15,
                        fontWeight: FontWeight.bold),
                  ),
                  onTap: () {
                    var route = MaterialPageRoute(
                        builder: (context) => MyHomeDetails(
                              // defaultPlat.title;
                              // defaultPlat.image;
                              // defaultPlat.ingredients;
                              // defaultPlat.recette;
                              title: "Boullettes de viande",
                              image: "assets/images/food-and-drink-images.jpg",
                              ingredients:
                                  "-800g Viande de boeuf hachée ,3Oeufs\n"
                                  "-2cuil à soupe Farine\n"
                                  "-1cuil à soupe bombée Feuilles de\n persil hachées\n"
                                  "-1cuil à soupe bombée Feuilles de\n coriandre hachées\n"
                                  "-4cuil à soupe Huile d'olive\n"
                                  "-2Oignons\n"
                                  "-1Petit bocal de coulis de tomate\n nature(20 cl environ)\n"
                                  "-1Bouquet garni(laurier, thym, romarin..)\n"
                                  "-1poignée Feuilles de basilic, Sel Poivre \n",
                              recette:
                                  "Faites chauffer la moitié de l'huile d'olive dans une grande cocotte. Placez-y l'oignon ciselé et les feuilles de basilic, mélangez jusqu'à ce que l'oignon soit bien doré."
                                  " Versez alors le coulis de tomate, ajoutez le bouquet garni, salez, poivrez, et couvrez."
                                  " Laissez mijoter à petits bouillons pendant 1 h."
                                  " Pendant ce temps, réalisez les boulettes : dans un grand saladier, mélangez la viande de bœuf, les œufs légèrement battus, du sel et du poivre, le persil et la coriandre hachés."
                                  " Pétrissez bien ce mélange entre vos mains puis formez des boulettes d'environ 5 cm de diamètre. Roulez-les dans une assiette avec la farine, et réservez-les."
                                  " Dans une deuxième cocotte, faites chauffer l'huile d'olive restante sur feu vif. Placez-y les boulettes et mélangez régulièrement, pour les faire dorer de toutes parts. Baissez le feu et laissez cuire 10 à 15 minutes, en mélangeant régulièrement. Retirez les boulettes quand elles sont vraiment bien colorées."
                                  " Placez les boulettes dans la sauce tomate maison, et laissez-les mijoter pendant 10 minutes à feu moyen, sans couvercle. Servez bien chaud.",
                            ));
                    Navigator.of(context).push(route);
                  }),
              ListTile(
                  leading: const Icon(
                    Icons.settings,
                    color: Colors.black,
                  ),
                  title: const Text('settings',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 15,
                          fontWeight: FontWeight.bold)),
                  onTap: () {
                    var route = MaterialPageRoute(
                        builder: (BuildContext context) => const Parametre());
                    Navigator.of(context).push(route);
                  }),
              // ListTile(
              // leading: const Icon(Icons.home,
              //   color:Colors.black,
              //     ),
              // title: const Text('list of food',
              //     style: TextStyle(
              //   color:Colors.black,
              //         fontSize: 15,
              //         fontWeight: FontWeight.bold)),
              // onTap: () {
              //   var route = MaterialPageRoute(
              //       builder: (BuildContext context) => const Home ());
              //   Navigator.of(context).push(route);
              // }),
            ],
          ),
        ),
        // backgroundColor: Colors.amber.shade300,
        body: Container(
          padding: const EdgeInsets.all(32),
          child: Column(
            children: <Widget>[
              const Spacer(),
              image != null
                  ? ModalWidget(
                      image: image!, onclicked: (source) => pickImage(source))
                  // image != null
                  //     ? ClipOval(
                  //         child: Image.file(image!,
                  //             width: 160, height: 160, fit: BoxFit.cover))
                  : const CircleAvatar(
                      backgroundImage:
                          AssetImage("assets/images/food-and-drink-images.jpg"),
                      radius: 80,
                    ),
              const SizedBox(height: 24),
              const Text(
                "Recipe and ingredients",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 30,
                    fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 48,
              ),
              buildButton(
                  title: "Pick Gallery",
                  icone: Icons.image_outlined,
                  onclicked: () => pickImage(ImageSource.gallery)),
              const SizedBox(
                height: 48,
              ),
              buildButton(
                  title: "Pick Camera",
                  icone: Icons.camera_alt_outlined,
                  onclicked: () => pickImage(ImageSource.camera)),
              const Spacer()
            ],
          ),
        ),
      ),
    );
  }

  Widget buildButton(
          {required String title,
          required IconData icone,
          required VoidCallback onclicked}) =>
      ElevatedButton(
        style:ElevatedButton.styleFrom(
          padding: const EdgeInsets.all(0),
                   textStyle: const TextStyle(fontSize: 20),
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(30)),
                  ),
        ),
        // style: ElevatedButton.styleFrom(
        //   minimumSize: const Size.fromHeight(56),
        //   backgroundColor: Colors.white,
        //   foregroundColor: Colors.white,
        //   textStyle: const TextStyle(fontSize: 20),
        //   shape: const StadiumBorder(),
        // ),
        onPressed: onclicked,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            gradient: const LinearGradient(
              colors: <Color>[
                Colors.red,
                Colors.deepOrange,
                Colors.orange,
              ],
            ),
          ),
          padding: const EdgeInsets.fromLTRB(60, 15, 60, 15),
          child: Row(
            children: [
              Icon(
                icone,
                size: 28,
              ),
              const SizedBox(
                width: 16,
              ),
              Text(
                title,
              )
            ],
          ),
        ),
      );
}
