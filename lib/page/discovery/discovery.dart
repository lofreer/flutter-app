import 'package:flutter/material.dart';

class DiscoveryPage extends StatefulWidget {
  @override
  _DiscoveryPageState createState() => _DiscoveryPageState();
}

class _DiscoveryPageState extends State<DiscoveryPage> {
  @override
  void initState() {
    super.initState();
    print('发现初始化方法...');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('发现'),
      ),
      body: Center(
        child: Text('discoveryPage-->发现'),
      ),
    );
  }
}
