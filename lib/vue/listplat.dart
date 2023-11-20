import 'dart:io';

import 'package:eat_bestly/bd/bdfood.dart';
import 'package:eat_bestly/model/plat.dart';
import 'package:eat_bestly/vue/modalform.dart';
import 'package:flutter/material.dart';
import 'package:eat_bestly/camera/camera.dart';
import 'package:eat_bestly/main.dart';
import 'package:eat_bestly/vue/Parametre.dart';
import 'package:eat_bestly/vue/detailsmain.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';

void main() {
  runApp(const HomeApp());
}

class HomeApp extends StatelessWidget {
  const HomeApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Home(),
    );
  }
}

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _StateHome();
}

class _StateHome extends State<Home> {
  final titleController = TextEditingController();
  final imageController = TextEditingController();
  final ingredientController = TextEditingController();
  final recetteController = TextEditingController();

  List<Map<String, dynamic>> listPlat = [];

  bool isload = true;

  void getListplat() async {
    final data = await SqlPlat.getAllPlat();

    setState(() {
      listPlat = data;
      isload = false;
    });
  }

  void showForm(int? id) async {
    if (id != null) {
      final existingMenu =
          listPlat.firstWhere((element) => element['id'] == id);
      titleController.text = existingMenu['title'];
      imageController.text = existingMenu['image'];
      ingredientController.text = existingMenu['ingredients'];
      recetteController.text = existingMenu['recette'];
    }
    // showModalBottomSheet(
    //   context: context,
    //   elevation: 5,
    //   builder: (_) => Container(
    //     padding: EdgeInsets.only(
    //       left: 15,
    //       right: 15,
    //       top: 15,
    //       bottom: MediaQuery.of(context).viewInsets.bottom + 120,
    //     ),
    child:
    SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            TextField(
                controller: titleController,
                decoration: const InputDecoration(hintText: 'title')),
            const SizedBox(
              height: 10,
            ),
            TextField(
              controller: imageController,
              decoration: const InputDecoration(hintText: 'image'),
            ),
            const SizedBox(
              height: 10,
            ),
            TextField(
              controller: ingredientController,
              decoration: const InputDecoration(hintText: 'ingredients'),
            ),
            const SizedBox(
              height: 10,
            ),
            TextField(
              controller: recetteController,
              decoration: const InputDecoration(hintText: 'recette'),
            ),
            const SizedBox(
              height: 20,
            ),
            // ElevatedButton(
            //   onPressed: () async {
            //     if (id == null) {
            //       await addPlat();
            //     }
            //     if (id != null) {
            //       await updatePlat(id);
            //     }
            //     titleController.text = '';
            //     imageController.text = '';
            //     ingredientController.text = '';
            //     recetteController.text = '';

            //     Navigator.of(context).pop();
            //   },
            //   child: Text(id == null ? 'Create new' : 'Update'),
            // ),
          ]),
      // ),
      //),
    );
  }

  List<BottomNavigationBarItem> _items = [];

  int id = 0;
  String value = '';

  Future<void> addPlat() async {
    Plat platObj = Plat(
      id: null,
      title: titleController.text,
      image: imageController.text,
      ingredients: ingredientController.text.toString(),
      recette: recetteController.text.toString(),
    );
    await SqlPlat.insertPlat(platObj);
    getListplat();
    debugPrint('num of items ${listPlat.length}');
  }

  Future<void> updatePlat(int id) async {
    Plat platObj = Plat(
      id: null,
      title: titleController.text,
      image: imageController.text,
      ingredients: ingredientController.text.toString(),
      recette: recetteController.text.toString(),
    );
    await SqlPlat.updatePlat(platObj);
    getListplat();
  }

  // Future<void> deletePlat(int id) async {
  //   await SqlPlat.deletePlat(id);
  //   ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
  //     content: Text('successfully delete a food'),
  //   ));
  //   getListplat();
  // }

  @override
  void initState() {
    getListplat();
    debugPrint('num of items ${listPlat.length}');
    _items = [];
    _items.add(const BottomNavigationBarItem(
        icon: Icon(
          Icons.video_call,
          color: Color.fromARGB(142, 0, 0, 0),
        ),
        label: 'video',
        tooltip: 'prendre une video'));
    _items.add(const BottomNavigationBarItem(
        icon: Icon(
          Icons.attach_file,
          color: Color.fromARGB(142, 0, 0, 0),
        ),
        label: 'fichier',
        tooltip: 'imprimer un fichier'));
    _items.add(const BottomNavigationBarItem(
        icon: Icon(
          Icons.camera,
          color: Color.fromARGB(142, 0, 0, 0),
        ),
        label: 'photo',
        tooltip: 'prendre une photo'));
  }

  File? image;
  ImagePicker picker = ImagePicker();

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
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(142, 0, 0, 0),
        centerTitle: true,
        title: const Text(
          'list of food',
        ),
        actions: <Widget>[
          const Padding(padding: EdgeInsets.all(10)),
          image != null
              ? ModalWidget(
                  image: image!,
                  onclicked: (source) => pickImage(ImageSource.gallery))
              : const CircleAvatar(
                  backgroundImage:
                      AssetImage('assets/images/IMG_20221206_162734.jpg'),
                  radius: 20,
                  child: Text('',
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                      )),
                ),
          const SizedBox(
            width: 10,
          ),
        ],
      ),
      drawer: Container(
        width: 250,
        color: Colors.white,
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            Container(
              height: 150,
              child: const DrawerHeader(
                  child: Text('Menu & Options',
                      style: TextStyle(
                          fontSize: 30, fontWeight: FontWeight.bold))),
            ),
            ListTile(
                leading: const Icon(Icons.person),
                title: const Text('update profile',
                    style:
                        TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                onTap: () {
                  Navigator.pop(context);
                }),
            ListTile(
                leading: const Icon(Icons.home),
                title: const Text('home',
                    style:
                        TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                onTap: () {
                  var route = MaterialPageRoute(
                      builder: (BuildContext context) => const Home());
                  Navigator.of(context).push(route);
                }),
            ListTile(
                leading: const Icon(Icons.settings),
                title: const Text('parametre',
                    style:
                        TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                onTap: () {
                  var route = MaterialPageRoute(
                      builder: (BuildContext context) => const Parametre());
                  Navigator.of(context).push(route);
                }),
            ListTile(
              leading: const Icon(Icons.logout),
              title: const Text('Logout',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              onTap: () {
                var route = MaterialPageRoute(
                    builder: (BuildContext context) =>
                        const MyHomePage(title: 'FOOD APP'));
                Navigator.of(context).push(route);
              },
            ),
          ],
        ),
      ),
      body: ListView.builder(
          itemCount: listPlat.length,
          itemBuilder: (context, index) => Card(
                color: Colors.white,
                margin: const EdgeInsets.all(15),
                child: ListTile(
                    title: Text(listPlat[index]['title']),
                    subtitle: Text(listPlat[index]['ingredients']),
                    trailing: SizedBox(
                        width: 100,
                        child: Row(
                          children: [
                            IconButton(
                              onPressed: () => showForm(listPlat[index]['id']),
                              icon: const Icon(Icons.update),
                              color: Colors.green,
                            ),
                            // IconButton(
                            //     onPressed: () =>
                            //         deletePlat(listPlat[index]['id']),
                            //     icon: const Icon(Icons.delete),
                            //     color: Colors.red),
                          ],
                        )),
                    onTap: () {
                      var route = MaterialPageRoute(
                          builder: (BuildContext context) => MyHomeDetails(
                                title: listPlat[index]['title'],
                                image: listPlat[index]['image'],
                                ingredients: listPlat[index]['ingredients'],
                                recette: listPlat[index]['recette'],
                              ));
                      Navigator.of(context).push(route);
                    }),
              )),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () => showForm(null),
      //   backgroundColor: const Color.fromARGB(142, 0, 0, 0),
      //   tooltip: 'Ajouter un plat',
      //   child: Icon(Icons.add),
      // ),
      bottomNavigationBar: BottomNavigationBar(
          items: _items,
          fixedColor: const Color.fromARGB(142, 0, 0, 0),
          onTap: (int item) async {
            try {
              final profile = await pickImage(ImageSource.gallery);
              if(profile== null)return;
                  final profileTemporary = File(profile.path);
              setState(() {
                id = item;
                int a = id + 1;
                if (a == 3) {
                  this.image = profileTemporary;
                }
                value = a.toString();
              });
            } on PlatformException catch (e) {
              debugPrint("failed to pick image: $e");
            }
          }

          ),
    );
  }
}
