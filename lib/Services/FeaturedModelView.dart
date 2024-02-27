import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:parityassessment/Model/FeaturedModel.dart';
import 'dart:convert';
import '../api_end_point.dart';


class FeaturedViewModel extends ChangeNotifier {
  late Featured _deals;
  Featured get deals => _deals;

  int _page = 1;
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

  Future<void> fetchDeals({bool refresh = false, int page = 1}) async {
    if (refresh) {
      _page = 1;
      _deals.toJson().clear();
    }

    String uriparts = apiEndPoint.getUriParts('home/discussed?per_page=10&page=$page&fie d.created at created_at in_millis,image_medium.comments_count.store(name)');
    Uri Url = apiEndPoint.getHTTPUri(uriparts);

    var headers = {
      'X-Desidime-Client': '08b4260e5585f282d1bd9d085e743fd9'
    };

    final response = await http.get(
        Url,
        headers: headers
    );

    if (response.statusCode == 200) {
      var responseData = handleResponse(response);
      Featured fetchedDeals = Featured.fromJson(responseData);
      _deals = fetchedDeals;
      print(_deals.toJson());
      // _deals.addAll(fetchedDeals);
      _page++;
      _isLoading = false;
      // notifyListeners();
    } else {
      _isLoading = false;
      throw Exception('Failed to load data');
    }
  }


}
