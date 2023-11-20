class Plat{
  int? id;
  String? title;
  String? image;
  //list de string
  String? ingredients;
  //list de String
  String? recette;
  

 Plat({this.id, this.title, this.image, this.ingredients, this.recette});

 
      Map <String, dynamic> toJson(){
    Map<String, dynamic> data = Map<String, dynamic>();
    data['id']=id;
    data['title']=title;
    data['image']=image;
    data['ingredients']=ingredients;
    data['recette']=recette;
    return data;
      }
      fromJson(Map<String, dynamic> json){
        id=json['id'];
        title=json['title'];
        image=json['image'];
        ingredients=json['ingredients'];
        recette=json['recette'];

      }
      }