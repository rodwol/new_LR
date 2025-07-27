import 'package:flutter/material.dart';

class ResultPage extends StatelessWidget {
  final Map<String, String> inputData;

  ResultPage({required this.inputData});

  @override
  Widget build(BuildContext context) {
    // TODO: Replace this mock with actual API call
    double mockPrediction = 1250.65;

    return Scaffold(
      appBar: AppBar(title: Text("Prediction Result")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Card(
          elevation: 4,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Input Summary:",
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                SizedBox(height: 10),
                ...inputData.entries.map(
                  (entry) => Text("${entry.key}: ${entry.value}",
                      style: TextStyle(fontSize: 16)),
                ),
                Divider(height: 30),
                Center(
                  child: Text(
                    "Predicted Waste Volume:\n$mockPrediction tons",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 22,
                        color: Colors.teal[800],
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
