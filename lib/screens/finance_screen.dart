import 'package:flutter/material.dart';

class FinanceScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueAccent,
        title: Text('Finance Tracker'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Card(
              elevation: 5,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
              child: ListTile(
                title: Text('Current Balance', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                subtitle: Text('\$2000', style: TextStyle(fontSize: 16, color: Colors.green)),
                leading: Icon(Icons.account_balance_wallet, color: Colors.blueAccent),
              ),
            ),
            SizedBox(height: 20),
            Card(
              elevation: 5,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
              child: ListTile(
                title: Text('Monthly Spending', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                subtitle: Text('\$1500', style: TextStyle(fontSize: 16, color: Colors.red)),
                leading: Icon(Icons.attach_money, color: Colors.red),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blueAccent, // Correct usage of backgroundColor
              ),
              child: Text('Add Transaction'),
            ),
          ],
        ),
      ),
    );
  }
}
