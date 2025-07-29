import 'package:flutter/material.dart';
import 'input_page.dart';

class IntroPage extends StatelessWidget {
  const IntroPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.teal[50],
      appBar: AppBar(title: Text('Toxic Waste Predictor')),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Welcome!",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
            SizedBox(height: 12),
            Text(
              "This app helps you estimate how much toxic waste (in tons) "
              "might be present in an environmental incident, using real data and machine learning.",
              style: TextStyle(fontSize: 16, height: 1.5),
            ),
            SizedBox(height: 24),

            Text("How to Use This App",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            SizedBox(height: 10),
            Text(
              "1. Click the button at the bottom to get started.\n"
              "2. Fill in some basic information about the incident.\n"
              "3. Tap 'Predict' to get the estimated waste volume.",
              style: TextStyle(fontSize: 16, height: 1.6),
            ),
            SizedBox(height: 24),

            Text("What You'll Be Asked",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            SizedBox(height: 10),
            Text(
              "- **Country**: A number representing the country (e.g., 0, 1, 2...)\n"
              "- **Latitude & Longitude**: Coordinates where it happened\n"
              "- **Dumping Entity**: Who dumped the waste (use code number)\n"
              "- **Legal Actions**: Severity of legal action (coded as numbers)\n"
              "- **Year**: The year it happened (use the given number)\n"
              "- **Waste Type**: Type of waste (also a code number)",
              style: TextStyle(fontSize: 16, height: 1.5),
            ),
            Spacer(),

            Center(
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => InputPage()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(horizontal: 32, vertical: 14),
                  textStyle: TextStyle(fontSize: 16),
                  backgroundColor: const Color.fromARGB(255, 28, 221, 199),
                ),
                child: Text("Start Prediction"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
