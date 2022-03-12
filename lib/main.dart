import 'package:alphabet_list_scroll_view_fix/alphabet_list_scroll_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:velocity_x/velocity_x.dart';

void main() => runApp(MainApp());

String getRandomName() {
  final List<String> preFix = ['Aa', 'Bo', 'Ce', 'Do', 'Ha', 'Tu', 'Zu'];
  final List<String> surFix = ['sad', 'bad', 'lad', 'nad', 'kat', 'pat', 'my'];
  preFix.shuffle();
 // surFix.shuffle();
  return '${preFix.first}${surFix.first}';
}

class User {
  final String name;
 

  User(this.name, );
}

class MainApp extends StatefulWidget {
  @override
  _MainAppState createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  List<User> userList = [];
  List<String> strList = [];
  List<Widget> normalList = [];
  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    for (var i = 0; i < 26; i++) {
      userList.add(User(getRandomName()));
    }
    for (var i = 0; i < 4; i++) {
      userList.add(User(getRandomName()));
    }
    userList
        .sort((a, b) => a.name.toLowerCase().compareTo(b.name.toLowerCase()));
    filterList();
    searchController.addListener(() {
      filterList();
    });
    super.initState();
  }

  filterList() {
    List<User> users = [];
    users.addAll(userList);
    normalList = [];
    strList = [];
    if (searchController.text.isNotEmpty) {
      users.retainWhere((user) => user.name
          .toLowerCase()
          .contains(searchController.text.toLowerCase()));
    }
    users.forEach((user) {
     
        normalList.add(
          Slidable(
            child: ListTile(
              title: Text(user.name).pOnly(bottom: 7),
              subtitle: Divider(),
            ),
          ),
        );
        strList.add(user.name);
      
    });

    setState(() {});
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
      appBar: AppBar(
        title: const Text('A to Z List '),
      ),
      body: AlphabetListScrollView( 
        strList: strList,
        highlightTextStyle: TextStyle(
          color: Colors.blue,
        ),
        showPreview: true,
        itemBuilder: (context, index) {
          return normalList[index];
        },
        
        indexedHeight: (i) {
          return 50;
        },
      
        headerWidgetList: <AlphabetScrollListHeader>[
          AlphabetScrollListHeader(widgetList: [
            TextFormField(
              controller: searchController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                prefixIcon: Icon(
                  Icons.search,
                  color: Colors.grey,
                ),
                hintText: "Search",
              ),
            )
          ], 
          icon: Icon(Icons.search),
           indexedHeaderHeight: (index) => 80),
          
        ],
      ),
    ));
  }
}
