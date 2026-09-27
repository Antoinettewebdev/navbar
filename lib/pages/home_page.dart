import 'dart:developer';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  final VoidCallback onThemeToggle;
  final bool isDarkMode;

  const HomePage({
    super.key,
    required this.onThemeToggle,
    required this.isDarkMode,
  });

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int selectedIndex = 0;

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();

  String selectedSex = "Male";
  String _selectedAgeRange = "10-20";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("My First App"),
        centerTitle: true,
        backgroundColor: Theme.of(context).colorScheme.primaryContainer,
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.search)),
          IconButton(onPressed: () {}, icon: const Icon(Icons.more_vert)),
          IconButton(
            onPressed: widget.onThemeToggle,
            icon: Icon(widget.isDarkMode ? Icons.light_mode : Icons.dark_mode),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "User Login",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
            ),
            const SizedBox(height: 20),

            TextField(
              controller: _nameController,
              decoration: const InputDecoration(
                labelText: "Name",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),

            TextField(
              controller: _emailController,
              keyboardType: TextInputType.emailAddress,
              decoration: const InputDecoration(
                labelText: "Email",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),

            const Text(
              "Sex",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),

            RadioGroup<String>(
              groupValue: selectedSex,
              onChanged: (value) {
                setState(() {
                  selectedSex = value!;
                  log(value);
                });
              },
              child: const Column(
                children: [
                  ListTile(
                    title: Text("Male"),
                    leading: Radio<String>(value: "Male"),
                  ),
                  ListTile(
                    title: Text("Female"),
                    leading: Radio<String>(value: "Female"),
                  ),
                ],
              ),
            ),

             SizedBox(height: 20),

            DropdownButtonFormField<String>(
              initialValue: _selectedAgeRange,
              decoration:  InputDecoration(
                labelText: "Age Range",
                border: OutlineInputBorder(),
              ),
              items:  [
                DropdownMenuItem(value: "10-20", child: Text("10-20")),
                DropdownMenuItem(value: "20-30", child: Text("20-30")),
                DropdownMenuItem(value: "30-40", child: Text("30-40")),
                DropdownMenuItem(value: "40-50", child: Text("40-50")),
                DropdownMenuItem(value: "50-100", child: Text("50-100")),
              ],
              onChanged: (value) {
                setState(() {
                  _selectedAgeRange = value!;
                  log(value);
                });
              },
            ),

            const SizedBox(height: 32),

            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.purple.shade400,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                onPressed: _submitForm,
                child: const Text(
                  "Register",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: selectedIndex,
        onDestinationSelected: (int value) {
          setState(() {
            selectedIndex = value;
          });
        },
        destinations: const [
          NavigationDestination(icon: Icon(Icons.home), label: "Home"),
          NavigationDestination(
            icon: Icon(Icons.contact_page),
            label: "Contact",
          ),
          NavigationDestination(icon: Icon(Icons.person), label: "Profile"),
        ],
      ),
    );
  }

  //  Submit Form
  void _submitForm() {
    final name = _nameController.text.trim();
    final email = _emailController.text.trim();

    log("Name is: $name and Email is: $email");

    if (name.isEmpty) {
      _showError("Name is required");
      return;
    }

    if (email.isEmpty) {
      _showError("Email is required");
      return;
    }

    if (!_isValidEmail(email)) {
      _showError("Enter a valid email");
      return;
    }

    _showSuccess("Registration successful!");
  }

  //  Email Validation
  bool _isValidEmail(String email) {
    return RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(email);
  }

  void _showError(String message) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Error"),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("OK"),
            ),
          ],
        );
      },
    );
  }

  // ✅ Success Dialog
  void _showSuccess(String message) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Success"),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("OK"),
            ),
          ],
        );
      },
    );
  }
}
