import 'package:flutter/material.dart';

import 'FeaturedScreen.dart';
import 'PopularScreen.dart';
import 'TopScreen.dart';

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with TickerProviderStateMixin {

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(color: Colors.white),
          title: const Text(
            'Deals',
            style: TextStyle(
              color: Colors.white,
            ),
          ),
          // leading: IconButton(
          //   icon: const Icon(
          //     Icons.menu,
          //     color: Colors.white,
          //   ),
          //   onPressed: () {},
          // ),
          actions: [
            IconButton(
              icon: const Icon(
                Icons.search,
                color: Colors.white,
              ),
              onPressed: () {},
            )
          ],
          backgroundColor: Colors.blue,
          bottom: const TabBar(
            labelColor: Colors.white,
            unselectedLabelColor: Colors.white,
            indicatorColor: Colors.deepOrange,
            indicatorWeight: 3,
            indicatorSize: TabBarIndicatorSize.tab,
            tabs: [
              Tab(text: 'TOP'),
              Tab(text: 'POPULAR'),
              Tab(text: 'FEATURED'),
              // Tab(icon: Icon(Icons.settings), text: 'Settings'),
            ],
          ),
          elevation: 20,
          titleSpacing: 20,
        ),
        body: const TabBarView(
          children: [
            topPage(),
            popularPage(),
            featuredPage(),
          ],
        ),
        drawer: Drawer(
          // backgroundColor: Colors.white,
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              const DrawerHeader(
                decoration: BoxDecoration(
                  color: Colors.blue,
                ),
                child: Text(
                  'Navigation Drawer',
                  style: TextStyle(fontSize: 20, color: Colors.white),
                ),
              ),
              ListTile(
                leading: Icon(Icons.person),
                title: const Text(' My Profile '),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: Icon(Icons.book),
                title: const Text(' History '),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: Icon(Icons.workspace_premium),
                title: const Text(' Premium '),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: Icon(Icons.video_label),
                title: const Text(' Saved '),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: Icon(Icons.logout),
                title: const Text('LogOut'),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
            backgroundColor: Colors.deepOrange,
            onPressed: () {},
            child: const Text(
              '\u{20B9}',
              style: TextStyle(
                color: Colors.white,
                fontSize: 22
              ),
            ),
          ),
      ),
    );
  }
}
