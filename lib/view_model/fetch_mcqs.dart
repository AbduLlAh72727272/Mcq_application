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



  String getMcqsUrl='http://youedx.com/apiudex/apifetchalldata/';
  String getMcqsByIdUrl='https://youedx.com/apiudex/api/get_category_index/';

int _sum=0;

int get sum=>_sum;
  Future<dynamic> getCategory() async {
    final categories= await http.get(Uri.parse(getMcqsByIdUrl));
    final catBody=json.decode(categories.body);
    catBody['categories'].forEach((value){

      _category.add(CategoryMcq(id: value['id'], slug: value['slug'], title: value['title'],description: value['description']));
    });
    // final result =
    // await http.get(Uri.parse(getMcqsUrl));
    // final body = json.decode(result.body);
    // // print("getting body iss $body");
    // body.forEach((value) {
    //   ++_sum;
    //
    //   _fetchMcqs.add(McqsModel(id: value['ID'], question: value['Question'], answer1: value['Answer1'], answer2: value['Answer2'], answer3: value['Answer3'], answer4: value['Answer4'], correctAnswer: value['CorrectAnswer'], parentCategory: value['ParentCategory'],
    //       childCategory: value['ChildCategory'], updatedAt: value['updated_at'], createdAt: value['updated_at']));
    //
    //
    //
    //   // Categories order = new Categories.fromJson(value);
    //   // category.add(order);
    // });
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
    // return firstValue;
  }
  getListById(String childId,BuildContext context){
    for(var id in mcqs){
      if(id.childCategory==childId){
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