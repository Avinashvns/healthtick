import 'package:flutter/material.dart';
import 'package:healthtick/Sqflite/db_handler.dart';
import 'package:healthtick/model/user_model.dart';

import 'model/book_model.dart';
import 'package:healthtick/model/vendor_dj_model.dart' as vendor_dj_model;
import 'package:healthtick/model/book_model.dart' as book_model;

class UserScreen extends StatefulWidget {
  const UserScreen({super.key});

  @override
  State<UserScreen> createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {
  TextEditingController nameController= TextEditingController();
  TextEditingController ageController= TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("User Screen"),
        backgroundColor: Colors.yellow,
      ),
      body: SafeArea(
        child: FutureBuilder(
          // future: DbHandler().readBook(),
          future: DbHandler().readVendorDj(),
          builder: (context, AsyncSnapshot<List<vendor_dj_model.Result>> snapshot) {
          // future: DbHandler().readData(),
          // builder: (context, AsyncSnapshot<List<UserModel>> snapshot) {
            if(!snapshot.hasData) return CircularProgressIndicator();
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                // nameController.text=snapshot.data![index].book ;
                // ageController.text=snapshot.data![index].price.toString();
                nameController.text=snapshot.data![index].djName ;
                ageController.text=snapshot.data![index].package.toString();
                // nameController.text=snapshot.data![index].name ;
                // ageController.text=snapshot.data![index].age.toString();


                return ListTile(
                  // title: Text(snapshot.data![index].book),
                  // subtitle: Text(snapshot.data![index].price.toString()),
                  title: Text(snapshot.data![index].djName),
                  subtitle: Text(snapshot.data![index].package.toString()),
                  // title: Text(snapshot.data![index].name),
                  // subtitle: Text(snapshot.data![index].age.toString()),
                  trailing: SizedBox(
                    width: 300,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ElevatedButton(
                          child: Text("Update"),
                          onPressed: ()async{
                            int id=int.parse(snapshot.data![index].id.toString());
                            print(id);
                            showDialog(
                                context: context,
                                builder: (context) => AlertDialog(
                                  title: Text("Update Dialog"),
                                  content: Column(
                                    children: [
                                      TextField(
                                        controller: nameController,
                                        decoration: InputDecoration(
                                            filled: true,
                                            fillColor: Colors.white,
                                            hintText: "Enter your name",
                                            labelText: "Name"
                                        ),
                                      ),
                                      SizedBox(height: 5,),
                                      TextField(
                                        controller: ageController,
                                        keyboardType: TextInputType.number,
                                        decoration: InputDecoration(
                                            filled: true,
                                            fillColor: Colors.white,
                                            hintText: "Enter your age",
                                            labelText: "Age"
                                        ),
                                      ),
                                    ],
                                  ),
                                  actions: <Widget>[
                                    TextButton(
                                        onPressed: ()async{
                                          int id=int.parse(snapshot.data![index].id.toString());
                                          print(id);
                                          await DbHandler().updateData(UserModel(
                                            id: id,
                                            name: nameController.text,
                                            age: int.parse(ageController.text),
                                          ));
                                          // Navigator.pop(context);
                                          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>UserScreen()));
                                        },
                                        child: Text("Submit"))
                                  ],
                                ),
                            );
                            // await DbHandler().updateData(
                            //     UserModel(
                            //       name: nameController.text,
                            //       age: int.parse(ageController.text),
                            //     )
                            // );
                            print("Update");
                          },
                        ),
                        ElevatedButton(
                          child: Text("Delete"),
                          onPressed: ()async{
                            int id=int.parse(snapshot.data![index].id.toString());
                            print(id);
                            await DbHandler().deleteData(id);
                            print("Deleted");
                            await Navigator.push(context, MaterialPageRoute(builder: (context) => UserScreen()));
                          },
                        ),
                        CircleAvatar(
                          radius: 50,
                          backgroundImage: NetworkImage(snapshot.data![index].images),
                        )
                      ],
                    ),
                  ),
                );
              },
            );
          },

        ),
      ),
    );
  }
}
