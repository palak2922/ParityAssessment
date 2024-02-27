import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:parityassessment/Model/PopularModel.dart';
import 'dart:convert';
import '../api_end_point.dart';


class PopularViewModel extends ChangeNotifier {
  late Popular _deals;
  Popular get deals => _deals;

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
        throw HttpException('Failed to get details');
    }
  }

  Future<void> fetchDeals({bool refresh = false, int page = 1, bool istest = false}) async {
    if (refresh) {
      _page = 1;
      _deals.toJson().clear();
    }

    String uriparts = apiEndPoint.getUriParts('home/discussed?per_page=10&page=$page&fields=i d created at created at inmillis,image_medium.comments_count.store(name)');
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
      Popular fetchedDeals = Popular.fromJson(responseData);
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

// Future getRefreshdata() async {
//     _page == 1 ? _page++ : null;
//     _deals.deals = [];
//     _isLoading = true;
//
//   String token = Provider.of<AuthProvider>(context, listen: false).token ?? '';
//   List<Destination> destination = await propertyService.GetDestination(token, widget.currency, '&page=$page');
//
//   await Future.delayed(const Duration(seconds: 2), () {
//     setState(() {
//       _desti = destination;
//       _hasMore = true;
//       _destination.addAll(_desti);
//     });
//   });
//     _page++;
//     _isLoading = false;
// }

}
