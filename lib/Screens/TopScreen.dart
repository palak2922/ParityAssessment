import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../CustomWidgets/Custom_Rich_Text.dart';
import '../Model/TopModel.dart';
import '../Services/TopModeView.dart';



class topPage extends StatefulWidget {
  const topPage({Key? key}) : super(key: key);

  @override
  State<topPage> createState() => _topPageState();
}

class _topPageState extends State<topPage> {

  late ScrollController _scrollController = ScrollController();
  late ScrollController refreshController = ScrollController();

  bool _isLoading = false;
  bool _hasMore = false;
  int page = 1;

  late ConnectivityResult _connectionStatus;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController()..addListener(_onScroll);
    Provider.of<DealViewModel>(context, listen: false).getSharedPrefrences();
    Connectivity().onConnectivityChanged.listen((ConnectivityResult result) {
      setState(() {
        _connectionStatus = result;
        print('_connectionStatus ::::::::::::::::::::::::::::::::::::::::: $_connectionStatus');
      });
    });

    // Initial check for connectivity status
    _checkConnectivity();
  }

  Future<void> _checkConnectivity() async {
    var connectivityResult = await Connectivity().checkConnectivity();
    setState(() {
      _connectionStatus = connectivityResult;
      if (_connectionStatus == ConnectivityResult.none) {
        Provider.of<DealViewModel>(context, listen: false).getSharedPrefrences();
        return;
        // statusText = 'No internet connection';
      } else {
        getData();
        _scrollController = ScrollController()
          ..addListener(_onScroll);
      }
    });
  }

  getData() async{
    setState(() {
      _isLoading = true;
    });

    await Provider.of<DealViewModel>(context, listen: false).fetchDeals();

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
    final double maxScroll = _scrollController.position.maxScrollExtent;
    final double currentScroll = _scrollController.position.pixels;
    final double delta = MediaQuery.of(context).size.height * 0.20;

    if (maxScroll - currentScroll <= delta) {
    // if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent) {
      setState(() {
        _hasMore = true;
        page++;
        Provider.of<DealViewModel>(context, listen: false).fetchDeals(page: page);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _isLoading ? const Center(child: CircularProgressIndicator()) :
      Consumer<DealViewModel>(
        builder: (context, model, child) {
          return FutureBuilder(
            future: model.fetchDeals(refresh: false,page: page),
            builder: (context, snapshot) {
              if (snapshot.hasData == true ) {
                return const Center(child: Text('No Data Avaliable'));
              } else if (snapshot.connectionState == ConnectionState.waiting && !_hasMore) {
                return const Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError && _connectionStatus != ConnectivityResult.none) {
                return Center(child: Text('Error: ${snapshot.error}'));
              } else {
                return
                  RefreshIndicator(
                  onRefresh: () async {
                    if (_connectionStatus == ConnectivityResult.none) {
                      _checkConnectivity();
                      return;
                      // statusText = 'No internet connection';
                    } else {
                      Provider.of<DealViewModel>(context, listen: false)
                          .fetchDeals(refresh: true, page: 1);
                      return Future.delayed(const Duration(seconds: 2));
                    }
                  },
                  child:
                  ListView.builder(
                    controller: _scrollController,
                    itemCount: model.deals.deals.length,
                        // <= 10 ? model.deals.deals.length : _hasMore ? model.deals.deals.length + 1 : model.deals.deals.length,
                    itemBuilder: (context, index) {
                      if (index == model.deals.deals.length && _connectionStatus != ConnectivityResult.none) {
                        if (!_isLoading) {
                          WidgetsBinding.instance.addPostFrameCallback((_){
                            _onScroll();
                          });
                        }
                        return CircularProgressIndicator(color: Colors.blue,);
                      }
                      final Top data = model.deals;
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
                                  Container(
                                    height: 70,
                                    width: 50,
                                    margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: const BorderRadius.all(Radius.circular(5)),
                                      image: _connectionStatus == ConnectivityResult.none ? null : DecorationImage(
                                        image: NetworkImage(data.deals[index].imageMedium),
                                      ),
                                      boxShadow: const [
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
                                      Text(data.deals[index].store?.name ?? "Store Name"),
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
                            SizedBox(
                              height: 70,
                              child: Row(
                                children: [
                                  const Icon(Icons.thumb_up, color: Colors.grey, size: 22,),
                                  const Text(
                                    '5',
                                    style: TextStyle(
                                      color: Colors.grey,
                                    ),
                                  ),
                                  const SizedBox(width: 20,),
                                  const Icon(Icons.chat, color: Colors.grey, size: 22,),
                                  const Text(
                                    '24',
                                    style: TextStyle(
                                      color: Colors.grey
                                    ),
                                  ),
                                  const SizedBox(width: 20,),
                                  const Icon(Icons.access_time, color: Colors.grey, size: 22,),
                                  Text(
                                    DateFormat('dd MMM yyyy').format(DateTime.parse('${data.deals[index].createdAt}')),
                                    style: const TextStyle(
                                      color: Colors.grey
                                    ),
                                  ),
                                  const Spacer(),
                                  const Text(
                                    'At Other',
                                    style: TextStyle(
                                        color: Colors.blue
                                    ),
                                  ),
                                  const SizedBox(width: 5,),

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



