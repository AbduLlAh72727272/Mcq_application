import 'dart:collection';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:usefulmcqapp/model/category_model.dart';

import '../model/mcqs_model.dart';
import 'package:http/http.dart' as http;

import '../view/displaymcqs.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class FetchMcqs extends ChangeNotifier{
  List<McqsModel> _fetchMcqs=[];
  UnmodifiableListView<McqsModel> get mcqs=>UnmodifiableListView(_fetchMcqs);
  List<CategoryMcq> _category=[];
  UnmodifiableListView<CategoryMcq> get categories=>UnmodifiableListView(_category);
  List<McqsModel> _listById=[];
  UnmodifiableListView<McqsModel> get listById=>UnmodifiableListView(_listById);

  late Future<dynamic>  dataFuture;
  FetchMcqs(){
    dataFuture=getCategory();
    notifyListeners();
  }



  String getMcqsUrl='https://youedx.com/apiudex/api/mcqs';
  String getMcqsByIdUrl='https://youedx.com/apiudex/api/cmcq';

int _sum=0;

int get sum=>_sum;
  Future<dynamic> getCategory() async {
    _category.clear();
    final categories= await http.get(Uri.parse(getMcqsByIdUrl));
    final catBody=json.decode(categories.body);
   // _category.add(CategoryMcq(id: catBody['data'][0]['id'], slug:  catBody['data'][0]['slug'], title:  catBody['data'][0]['title'],description:  catBody['data'][0]['description']));
    // catBody['data'][0]['id'];
    catBody['data'].forEach((value){

      _category.add(CategoryMcq(id: value['id'], slug: value['slug'], title: value['title'],description: value['description']));
    });
    final result =
    await http.get(Uri.parse(getMcqsUrl));
    final body = json.decode(result.body);
    // print("getting body iss $body");
    body['data'].forEach((value) {
      ++_sum;

      _fetchMcqs.add(McqsModel(id: value['id'].toString(), question: value['question'], answer1: value['answer1'], answer2: value['answer2'], answer3: value['answer3'], answer4: value['answer4'], correctAnswer: value['correctAnswer'], parentCategory: value['parentCategory'],
          childCategory: value['childCategory'], updatedAt: value['updated_at'], createdAt: value['created_at']));



      // Categories order = new Categories.fromJson(value);
      // category.add(order);
    });
    notifyListeners();


     // var firstValue = (body as List).first;
    // //  body.forEach((value) {
    // // mcqs.add(value);
    // //  });
    //
    // // return Future.delayed(Duration(seconds: 2), () {
    // //   return "I am data";
    // //   // throw Exception("Custom Error");
    // // });
     return "Okay";
  }
  clearListById(){
    _listById.clear();
    notifyListeners();
  }
  getListById(String title,BuildContext context){
    _sum=0;
     print("title is $title");

    for(var id in mcqs){
      // print(id.childCategory);
      if(id.childCategory==title){
        _listById.add(McqsModel(id: id.childCategory, question: id.question,
            answer1: id.answer1, answer2: id.answer2, answer3: id.answer3,
            answer4: id.answer4, correctAnswer: id.correctAnswer, parentCategory: id.parentCategory,
            childCategory: id.childCategory, updatedAt: id.updatedAt, createdAt: id.createdAt));
        ++_sum;


      }
    }
    notifyListeners();
    // notifyListeners();
    if(_listById.isEmpty){
       getAlert(context);
    }
    else{
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) =>  DisplayMcqs()),
      );
      // Navigator.push(
      //   context,
      //   MaterialPageRoute(builder: (context) =>  const DisplayMcqs()),
      // );
      // Navigator.push(
      //   context,
      //   MaterialPageRoute(builder: (context) =>  const DisplayMcqs()),
      // );
    }


  }
  getAlert(BuildContext context){
    Alert(
      context: context,
      type: AlertType.error,
      title: "Alert",
      desc: "Currently no items in it.",
      buttons: [
        DialogButton(
          color: Color(0xFF7456F5),
          child: Text(
            "Okay",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          onPressed: () => Navigator.pop(context),
          width: 120,
        )
      ],
    ).show();
  }




 }