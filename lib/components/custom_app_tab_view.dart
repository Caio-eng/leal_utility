import 'package:flutter/material.dart';

class CustomAppTabView extends StatefulWidget {
  final String title;
  final List<Tab> tabs;
  final List<Widget> tabViews;
  final Color appBarColor;

  const CustomAppTabView({
    Key? key,
    required this.title,
    required this.tabs,
    required this.tabViews,
    this.appBarColor = Colors.blueGrey,
  }) : super(key: key);

  @override
  _CustomAppTabViewState createState() => _CustomAppTabViewState();
}

class _CustomAppTabViewState extends State<CustomAppTabView> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: widget.tabs.length, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(widget.title),
        backgroundColor: widget.appBarColor,
      ),
      body: TabBarView(
        controller: _tabController,
        children: widget.tabViews,
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _tabController.index,
        onTap: (index) {
          setState(() {
            _tabController.index = index;
          });
        },
        items: widget.tabs.map((tab) {
          return BottomNavigationBarItem(
            icon: tab.icon!,
            label: tab.text,
          );
        }).toList(),
      ),
    );
  }
}
