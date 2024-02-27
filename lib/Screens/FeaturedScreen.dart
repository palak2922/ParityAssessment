import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:parityassessment/Model/FeaturedModel.dart';
import 'package:provider/provider.dart';
import '../CustomWidgets/Custom_Rich_Text.dart';
import '../Services/FeaturedModelView.dart';


class featuredPage extends StatefulWidget {
  const featuredPage({Key? key}) : super(key: key);

  @override
  State<featuredPage> createState() => _featuredPageState();
}

class _featuredPageState extends State<featuredPage> {

  late ScrollController _scrollController = ScrollController();
  late ScrollController refreshController = ScrollController();

  bool _isLoading = false;
  // RefreshController refreshController = RefreshController(initialRefresh: false);
  // final ScrollController _scrollController = ScrollController();
  int page = 1;

  // @override
  // void initState() {
  //   super.initState();
  //   // _scrollController.addListener(_scrollController);
  //   getPosts(page);
  // }
  //
  // final FeaturedViewModel apiService = FeaturedViewModel();
  // late Top posts;
  //
  // Future getPosts(int page) async {
  //   setState(() {
  //     _isLoading=true;
  //   });
  //   Top fetchedPosts = await apiService.fetchDeals(page);
  //   setState(() {
  //     posts = fetchedPosts;
  //   });
  //   setState(() {
  //     _isLoading=false;
  //   });
  //   // return fetchedPosts;
  // }

  @override
  void initState() {
    super.initState();
    getData();
    _scrollController = ScrollController()..addListener(_onScroll);
  }

  getData() async{
    setState(() {
      _isLoading = true;
    });

    await Provider.of<FeaturedViewModel>(context, listen: false).fetchDeals();

    setState(() {
      _isLoading = false;
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent) {
      Provider.of<FeaturedViewModel>(context, listen: false).fetchDeals();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _isLoading ? const Center(child: CircularProgressIndicator()) :
      Consumer<FeaturedViewModel>(
        builder: (context, model, child) {
          return FutureBuilder(
            future: model.fetchDeals(refresh: false, page: page),
            builder: (context, snapshot) {
              if (snapshot.hasData == true) {
                return const Center(child: Text('No Data Avaliable'));
              } else if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              } else {
                return
                  RefreshIndicator(
                      onRefresh: () async {
                        Provider.of<FeaturedViewModel>(context, listen: false).fetchDeals();
                        return Future.delayed(const Duration(seconds: 2));
                      },
                      child:
                      ListView.builder(
                        controller: _scrollController,
                        itemCount: model.deals.deals.length,
                        itemBuilder: (context, index) {
                          final Featured data = model.deals;
                          return Container(
                            height: 160,
                            padding: EdgeInsets.zero,
                            decoration: const BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.all(Radius.circular(5)),
                                boxShadow: [
                                  BoxShadow(
                                      color: Colors.black12,
                                      blurRadius: 5,
                                      spreadRadius: 3
                                  )
                                ]
                            ),
                            margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                SizedBox(
                                  height: 90,
                                  child: Row(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        height: 70,
                                        width: 70,
                                        margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
                                        decoration: const BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.all(Radius.circular(5)),
                                          // image: DecorationImage(
                                          //   image: NetworkImage(data.deals[index].permalink),
                                          // ),
                                          boxShadow: [
                                            BoxShadow(
                                                color: Colors.black12,
                                                blurRadius: 2,
                                                spreadRadius: 1
                                            )
                                          ],
                                        ),
                                      ),
                                      const SizedBox(width: 10,),
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          const SizedBox(height: 10,),
                                          SizedBox(
                                            width: MediaQuery.of(context).size.width/1.7,
                                            child: ListTile(
                                              title: Text(
                                                data.deals[index].title ?? "Title",
                                                overflow: TextOverflow.visible,
                                                maxLines: 2,
                                                softWrap: true,
                                              ),
                                              subtitle: index == 1 || index == 3 || index == 5 ? const RichTxt(
                                                text: 'Rs 500\t\t',
                                                text1: '\tRs 600\t',
                                                text2: '\t\t17% Off',
                                                text3: '',
                                                color: Colors.green,
                                                color1: Colors.grey,
                                                color2: Colors.red,
                                                lineThrough: true,
                                                fontStyle: FontStyle.normal,
                                              ):Container(),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(
                                    height: 50,
                                    child: Row(
                                      children: [
                                        Icon(Icons.thumb_up, color: Colors.grey, size: 22,),
                                        Text(
                                          '5',
                                          style: TextStyle(
                                            color: Colors.grey,
                                          ),
                                        ),
                                        SizedBox(width: 20,),
                                        Icon(Icons.chat, color: Colors.grey, size: 22,),
                                        Text(
                                          '24',
                                          style: TextStyle(
                                              color: Colors.grey
                                          ),
                                        ),
                                        Spacer(),
                                        Text(
                                          'At Other',
                                          style: TextStyle(
                                              color: Colors.blue
                                          ),
                                        ),
                                        SizedBox(width: 5,),

                                      ],
                                    )
                                ),
                              ],
                            ),
                          );
                        },
                      )
                  );
              }
            },
          );
        },
      ),
    );
  }
}



