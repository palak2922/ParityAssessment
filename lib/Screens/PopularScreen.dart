import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../CustomWidgets/Custom_Rich_Text.dart';
import '../Model/PopularModel.dart';
import '../Services/PopularModelView.dart';



class popularPage extends StatefulWidget {
  const popularPage({Key? key}) : super(key: key);

  @override
  State<popularPage> createState() => _popularPageState();
}

class _popularPageState extends State<popularPage> {

  late ScrollController _scrollController = ScrollController();
  late ScrollController refreshController = ScrollController();

  bool _isLoading = false;
  int page = 1;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController()..addListener(_onScroll);
    getData();
  }

  getData() async{
    setState(() {
      _isLoading = true;
    });

    await Provider.of<PopularViewModel>(context, listen: false).fetchDeals();

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
      Provider.of<PopularViewModel>(context, listen: false).fetchDeals();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _isLoading ? const Center(child: CircularProgressIndicator()) :
      Consumer<PopularViewModel>(
        builder: (context, model, child) {
          // print(model.deals.deals[0].toJson().isEmpty);
          return FutureBuilder(
            future: model.fetchDeals(refresh: false, page: page),
            builder: (context, snapshot) {
              if (model.deals.deals[0].toJson().isEmpty) {
                return const Center(child: Text('No Data Avaliable'));
              } else if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              } else {
                return
                  RefreshIndicator(
                      onRefresh: () async {
                        Provider.of<PopularViewModel>(context, listen: false).fetchDeals();
                        return Future.delayed(const Duration(seconds: 2));
                      },
                      child:
                      ListView.builder(
                        controller: _scrollController,
                        itemCount: model.deals.deals.length,
                        itemBuilder: (context, index) {
                          final Popular data = model.deals;
                          return Container(
                            height: 140,
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
                                  height: 70,
                                  child: Row(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      // Container(
                                      //   height: 70,
                                      //   width: 50,
                                      //   margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
                                      //   decoration: BoxDecoration(
                                      //     color: Colors.white,
                                      //     borderRadius: const BorderRadius.all(Radius.circular(5)),
                                      //     image: DecorationImage(
                                      //       image: NetworkImage(data.deals[index].imageMedium),
                                      //     ),
                                      //     boxShadow: const [
                                      //       BoxShadow(
                                      //           color: Colors.black12,
                                      //           blurRadius: 2,
                                      //           spreadRadius: 1
                                      //       )
                                      //     ],
                                      //   ),
                                      // ),
                                      const SizedBox(width: 10,),
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          const SizedBox(height: 10,),
                                          Text("Store Name"),
                                          const SizedBox(height: 5,),
                                          index == 2 || index == 5 || index == 7 ? const RichTxt(
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
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(
                                    height: 70,
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
                                        SizedBox(width: 20,),
                                        Icon(Icons.access_time, color: Colors.grey, size: 22,),
                                        Text( 'dd/MM/yyyy',
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



