import 'package:flutter/material.dart';


class McqsModel{
  McqsModel({
    required this.id,
    required this.question,
    required this.answer1,
    required this.answer2,
    required this.answer3,
    required this.answer4,
    required this.correctAnswer,
    required this.parentCategory,
    required this.childCategory,
    required this.updatedAt,
    required this.createdAt,
  });

  String id;
  String question;
  String answer1;
  String answer2;
  String answer3;
  String answer4;
  String correctAnswer;
  String parentCategory;
  String childCategory;
  String updatedAt;
  String createdAt;
}