import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

import '../Model/TopModel.dart';
import '../api_end_point.dart';


class DealViewModel extends ChangeNotifier {
  late Top _deals;
  List<Top> _offlinedeals = List.empty(growable: true);

  Top get deals => _deals;

  bool _isLoading = false;

  bool get isLoading => _isLoading;
  ApiEndPoint apiEndPoint = ApiEndPoint();

  dynamic handleResponse(http.Response response) {
    switch (response.statusCode) {
      case 200:
        var responseJson = jsonDecode(response.body);
        return responseJson;
      case 401:
        print('unauthorized err ${jsonDecode(response.body)}');
        throw HttpException('Unauthorized');
      case 404:
        print('Not Found err ${jsonDecode(response.body)}');
        throw HttpException('Not Found');
      default:
        print('got err response from handler ${jsonDecode(response.body)}');
        throw HttpException('Failed to get user details');
    }
  }

  Future<void> fetchDeals({bool refresh = false, int page = 1, bool istest = false}) async {
    if (refresh) {
      page = 1;
      // _deals.clear();
    }

    String uriparts = apiEndPoint.getUriParts('home/new?per_page=10&page=$page&fields=id,created_at,created_at_in_millis,image_medium,comments_count,store{name}');
    Uri Url = apiEndPoint.getHTTPUri(uriparts);

    print(Url);
    var headers = {
      'X-Desidime-Client': '08b4260e5585f282d1bd9d085e743fd9'
    };

    final response = await http.get(
        Url,
        headers: headers
    );

    if (response.statusCode == 200) {
      var responseData = handleResponse(response);
      Top fetchedDeals = Top.fromJson(responseData);

      print(page);
      // _page > 1 ? _dealsmore.add(fetchedDeals) :
      _deals = fetchedDeals;
      // _deals.deals.map((e) => fetchedDeals);

      istest ? null : saveIntoSp();
      _isLoading = false;
      // notifyListeners();
    } else {
      _isLoading = false;
      throw Exception('Failed to load data');
    }
  }

  
  /// for saving data offline using sharedPreference
  late SharedPreferences sp;

  getSharedPrefrences() async {
    sp = await SharedPreferences.getInstance();
    readFromSp();
  }

  saveIntoSp() {
    List<String> TopListString =
    _offlinedeals.map((Top) => jsonEncode(Top.toJson())).toList();
    sp.setStringList('myData', TopListString);
  }

  readFromSp() {
    List<String>? TopListString = sp.getStringList('myData');
    if (TopListString != null) {
      _offlinedeals = TopListString
          .map((data) => Top.fromJson(json.decode(data)))
          .toList();
      _deals = _offlinedeals[0];
    }
  }

}