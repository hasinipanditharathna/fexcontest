import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:practicaltest/CatFolder/model/gifmodel.dart';

Future<List<CatGiftsResponseModel>> fetchGifs(
    pageNumber, String mimeTypes) async {
  String apiUrl =
      "https://api.thecatapi.com/v1/images/search?limit=10&format=json";
  String apiKey =
      "live_aDVEqQPaD9n0z6P98mTpoM9TipXdEiQMpA4c1n1o9efjurINi5j7r6OlQvZDOGqf";
  String mimeType = mimeTypes;
  String order = "random";

  var headers = {'x-api-key': apiKey, 'Content-Type': 'application/json'};
  final response = await http.get(
      Uri.parse('$apiUrl&mime_types=$mimeType&order=$order&page=$pageNumber'),
      headers: headers);

  print('========== response');
  print(response.body);

  if (response.statusCode == 200) {
    return compute(parseGifs, response.body);
  } else {
    throw Exception('Failed to load gif');
  }
}

Future<List<CatGiftsResponseModel>> fetchAll(pageNumber) async {
  String apiUrl =
      "https://api.thecatapi.com/v1/images/search?limit=10&format=json";
  String apiKey =
      "live_aDVEqQPaD9n0z6P98mTpoM9TipXdEiQMpA4c1n1o9efjurINi5j7r6OlQvZDOGqf";

  String order = "random";

  var headers = {'x-api-key': apiKey, 'Content-Type': 'application/json'};
  final response = await http.get(
      Uri.parse('$apiUrl&order=$order&page=$pageNumber'),
      headers: headers);

  if (response.statusCode == 200) {
    return compute(parseAll, response.body);
  } else {
    throw Exception('Failed to load gif');
  }
}

List<CatGiftsResponseModel> parseGifs(String responseBody) {
  final parsed = jsonDecode(responseBody).cast<Map<String, dynamic>>();

  return parsed
      .map<CatGiftsResponseModel>(
          (json) => CatGiftsResponseModel.fromJson(json))
      .toList();
}

List<CatGiftsResponseModel> parseAll(String responseBody) {
  final parsed = jsonDecode(responseBody).cast<Map<String, dynamic>>();

  return parsed
      .map<CatGiftsResponseModel>(
          (json) => CatGiftsResponseModel.fromJson(json))
      .toList();
}
