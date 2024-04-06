

class UserModel{
  // final int id;
  final int? id;
  final String name;
  final int age;

  // constructor
  UserModel({
    // required this.id,
    this.id,
    required this.name,
    required this.age
});

  factory UserModel.fromMap(Map<String,dynamic>map){
    return UserModel(
        id: map['id'],
        name: map['name'],
        age: map['age']
    );
  }

  Map<String, dynamic> toJson(){
    return {
      "id" : id,
      "name" : name,
      "age" : age
    };
  }

}