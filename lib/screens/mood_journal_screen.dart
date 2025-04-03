import 'package:flutter/material.dart';

class MoodJournalScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange,
        title: Text('Mood Journal'),
        centerTitle: true,
      ),
      body: Center(
        child: Text('Mood Journal Screen'),
      ),
    );
  }
}
