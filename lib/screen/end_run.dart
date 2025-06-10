import 'package:flutter/material.dart';

class EndRun extends StatefulWidget {
  const EndRun({super.key});

  @override
  State<EndRun> createState() => _EndRunState();
}

class _EndRunState extends State<EndRun> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('New Post'),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(children: [Text("end run")]),
        ),
      ),
    );
  }
}
