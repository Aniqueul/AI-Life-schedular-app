import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal,
        title: Text('LifeSync - AI Scheduler', style: TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              // AI Suggested Plan
              SizedBox(height: 100),
              Card(
                elevation: 5,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      Text(
                        'Your AI-Suggested Plan for Today:',
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 10),
                      Text('Task 1: Plan your day', style: TextStyle(fontSize: 16)),
                      SizedBox(height: 10),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.pushNamed(context, '/task');
                        },
                        style: ElevatedButton.styleFrom(backgroundColor: Colors.teal),
                        child: Text('Go',style: TextStyle(fontWeight: FontWeight.bold,color: Colors.black87),),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 30),

              // Mood Tracker Button
              Card(
                elevation: 5,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      Text(
                        'Your Mood Tracker of Today:',
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 10),
                      Text('Task 2: Whats your mood today', style: TextStyle(fontSize: 16)),
                      SizedBox(height: 10),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.pushNamed(context, '/task');
                        },
                        style: ElevatedButton.styleFrom(backgroundColor: Colors.teal),
                        child: Text('Go',style: TextStyle(fontWeight: FontWeight.bold,color: Colors.black87),),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}