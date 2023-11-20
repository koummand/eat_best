import 'package:flutter/material.dart';
import 'package:eat_bestly/model/plat.dart';
import 'package:sqflite/sqflite.dart';


class SqlPlat {

  static Future<void> createTable(Database database) async {
     await database.execute(
        "CREATE TABLE plat(id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, title TEXT, image TEXT, ingredients TEXT, recette TEXT)");
  }

  static Future<Database> db() async {
    return openDatabase(
                 'dbplat', 
                  version: 1,
                  onCreate: (Database db, int version) async {
            await createTable(db);
    });
  }

  static Future<int> insertPlat(Plat plat) async {
    final db = await SqlPlat.db();
    final data = plat.toJson();
    final id = await db.insert(
                  'plat', 
                  data, 
                  conflictAlgorithm: ConflictAlgorithm.replace);
    return id;
  }

 static Future<List<Map<String,dynamic>>> getAllPlat()async {
    final db = await SqlPlat.db();
    return await db.query('plat',orderBy:"id");
  }

 static Future<List<Map<String,dynamic>>> getPlat(int id)async{
      final db= await SqlPlat.db();
      return await db.query('plat', where: "id=?", whereArgs:[id], limit:1);
  }

  static Future<int> updatePlat(Plat plat)async{
    final db = await SqlPlat.db();
    final data= plat.toJson();
    return await db.update('plat', data, where:'id=?', whereArgs:[plat.id]); 
  }

  static Future<void> deletePlat(int id)async {
    final db = await SqlPlat.db();
    try{
         await db.delete('plat', where:"id=?", whereArgs: [id]);
    }catch(err){
      debugPrint('something went wrong when deleting an item: $err');
    }
  }

 
   final List<dynamic> defaultPlat = [
    {
      'id': 1,
      'title': 'Boullettes de viande',
      'image':'assets/images/food-and-drink-images.jpg',
      'ingredients': '-800g Viande de boeuf hachée, 3Oeufs\n -2cuil à soupe Farine\n -1cuil à soupe bombée Feuilles de\n persil hachées\n -1cuil à soupe bombée Feuilles de\n coriandre hachées\n -4cuil à soupe Huile d olive 2Oignons\n -1Petit bocal de coulis de tomate nature(20 cl environ)\n -1Bouquet garni(laurier, thym, romarin..)\n -1poignée Feuilles de basilic, Sel Poivre ',
      'recette': 'Faites chauffer la moitié de l huile d olive dans une grande cocotte. Placez-y l oignon ciselé et les feuilles de basilic, mélangez jusqu à ce que l oignon soit bien doré. Versez alors le coulis de tomate, ajoutez le bouquet garni, salez, poivrez, et couvrez. Laissez mijoter à petits bouillons pendant 1 h. Pendant ce temps, réalisez les boulettes : dans un grand saladier, mélangez la viande de bœuf, les œufs légèrement battus, du sel et du poivre, le persil et la coriandre hachés. Pétrissez bien ce mélange entre vos mains puis formez des boulettes d environ 5 cm de diamètre. Roulez-les dans une assiette avec la farine, et réservez-les. Dans une deuxième cocotte, faites chauffer l huile d olive restante sur feu vif. Placez-y les boulettes et mélangez régulièrement, pour les faire dorer de toutes parts. Baissez le feu et laissez cuire 10 à 15 minutes, en mélangeant régulièrement. Retirez les boulettes quand elles sont vraiment bien colorées. Placez les boulettes dans la sauce tomate maison, et laissez-les mijoter pendant 10 minutes à feu moyen, sans couvercle. Servez bien chaud.'
    },
    {
      'id': 2,
      'title': 'Boullettes de viande',
      'image':'assets/images/food-and-drink-images.jpg',
      'ingredients': '-800g Viande de boeuf hachée, 3Oeufs\n -2cuil à soupe Farine\n -1cuil à soupe bombée Feuilles de\n persil hachées\n -1cuil à soupe bombée Feuilles de\n coriandre hachées\n -4cuil à soupe Huile d olive 2Oignons\n -1Petit bocal de coulis de tomate nature(20 cl environ)\n -1Bouquet garni(laurier, thym, romarin..)\n -1poignée Feuilles de basilic, Sel Poivre ',
      'recette': 'Faites chauffer la moitié de l huile d olive dans une grande cocotte. Placez-y l oignon ciselé et les feuilles de basilic, mélangez jusqu à ce que l oignon soit bien doré. Versez alors le coulis de tomate, ajoutez le bouquet garni, salez, poivrez, et couvrez. Laissez mijoter à petits bouillons pendant 1 h. Pendant ce temps, réalisez les boulettes : dans un grand saladier, mélangez la viande de bœuf, les œufs légèrement battus, du sel et du poivre, le persil et la coriandre hachés. Pétrissez bien ce mélange entre vos mains puis formez des boulettes d environ 5 cm de diamètre. Roulez-les dans une assiette avec la farine, et réservez-les. Dans une deuxième cocotte, faites chauffer l huile d olive restante sur feu vif. Placez-y les boulettes et mélangez régulièrement, pour les faire dorer de toutes parts. Baissez le feu et laissez cuire 10 à 15 minutes, en mélangeant régulièrement. Retirez les boulettes quand elles sont vraiment bien colorées. Placez les boulettes dans la sauce tomate maison, et laissez-les mijoter pendant 10 minutes à feu moyen, sans couvercle. Servez bien chaud.'
    }
  ];

}
