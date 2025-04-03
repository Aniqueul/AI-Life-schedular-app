import 'package:flutter/material.dart';
import '../services/api_service.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final ApiService apiService = ApiService();
  bool _isLoading = false;
  String _errorMessage = '';

  Future<void> _login() async {
    setState(() {
      _isLoading = true;
      _errorMessage = '';
    });

    try {
      final credentials = {
        'email': _emailController.text,
        'password': _passwordController.text,
      };

      var response = await apiService.loginUser(credentials);

      setState(() => _isLoading = false);

      print("Login Response: $response"); // Debugging

      if (response['status'] == 'success') {
        // Show success message
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              content: Text('Login successful!'),
              backgroundColor: Colors.green),
        );

        // Redirect to home screen
        Navigator.pushReplacementNamed(context, '/home');
      } else {
        setState(() => _errorMessage = response['message'] ?? 'Login failed');
      }
    } catch (e) {
      setState(() {
        _isLoading = false;
        _errorMessage = 'An error occurred. Try again.';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey[900],
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Card(
            color: Colors.white,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            child: Padding(
              padding: EdgeInsets.all(20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text("Login",
                      style:
                          TextStyle(fontSize: 35, fontWeight: FontWeight.bold)),
                  SizedBox(height: 15),
                  _buildTextField(_emailController, "Email", Icons.email),
                  _buildTextField(_passwordController, "Password", Icons.lock,
                      obscureText: true),
                  SizedBox(height: 15),
                  _isLoading
                      ? CircularProgressIndicator()
                      : _buildButton("Login", _login),
                  if (_errorMessage.isNotEmpty)
                    Text(_errorMessage, style: TextStyle(color: Colors.red)),
                  _buildSignupSwitch(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(
      TextEditingController controller, String label, IconData icon,
      {bool obscureText = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextField(
        controller: controller,
        obscureText: obscureText,
        decoration: InputDecoration(
          labelText: label,
          prefixIcon: Icon(icon),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        ),
      ),
    );
  }

  Widget _buildButton(String text, VoidCallback onPressed) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
            padding: EdgeInsets.all(15),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            backgroundColor: Colors.green),
        onPressed: onPressed,
        child: Text(text,
            style: TextStyle(
                fontSize: 20,
                color: Colors.black,
                fontWeight: FontWeight.bold)),
      ),
    );
  }

  Widget _buildSignupSwitch() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text("Don't have an account? ", style: TextStyle(fontSize: 21)),
        TextButton(
            onPressed: () => Navigator.pushReplacementNamed(context, '/signup'),
            child: Text("Sign up", style: TextStyle(fontSize: 21)))
      ],
    );
  }
}
