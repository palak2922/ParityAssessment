import 'package:flutter_test/flutter_test.dart';
import 'package:parityassessment/Services/FeaturedModelView.dart';
import 'package:parityassessment/Services/PopularModelView.dart';
import 'package:parityassessment/Services/TopModeView.dart';

// run in terminal - flutter test

void main(){
  late DealViewModel topservice;
  late PopularViewModel popularservice;
  late FeaturedViewModel featuredservice;

  setUp(() {
    topservice = DealViewModel();
    popularservice = PopularViewModel();
    featuredservice = FeaturedViewModel();
  });

  group('DealViewModel -', () {
    group('fetchDeals function', () {
      test('given DealViewModel class when fetchDeals function is called and status code is 200 then deals should be fetched',
              () async {
            // Act
            await topservice.fetchDeals(refresh: false, page: 1, istest: true);

            // Assert
            expect(topservice.deals.toJson().isNotEmpty, true); // Check if deals are fetched
          });

      test('given PopularViewModel class when fetchDeals function is called and status code is 200 then deals should be fetched',
              () async {
            // Act
            await popularservice.fetchDeals(refresh: false, page: 1, istest: true);

            // Assert
            expect(popularservice.deals.toJson().isNotEmpty, true); // Check if deals are fetched
          });

      test('given FeaturedViewModel class when fetchDeals function is called and status code is 200 then deals should be fetched',
              () async {
            // Act
            await featuredservice.fetchDeals(refresh: false, page: 1);

            // Assert
            expect(featuredservice.deals.toJson().isNotEmpty, true); // Check if deals are fetched
          });
      // Add more test cases as needed to cover other scenarios
    });
  });

}

