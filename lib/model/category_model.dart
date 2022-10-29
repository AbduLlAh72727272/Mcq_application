import 'package:flutter/material.dart';

import 'dart:convert';



class CategoryMcq {
  CategoryMcq({
    required this.id,
    required this.slug,
    required  this.title,
    //  required this.description,
    // required  this.parent,
    // required this.postCount,
  });

  int id;
  String slug;
  String title;
  // String description;
  // int parent;
  // int postCount;

  factory CategoryMcq.fromJson(Map<String, dynamic> json) => CategoryMcq(
    id: json["id"],
    slug: json["slug"],
    title: json["title"],
    // description: json["description"],
    // parent: json["parent"],
    // postCount: json["post_count"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "slug": slug,
    "title": title,
    // "description": description,
    // "parent": parent,
    // "post_count": postCount,
  };
}