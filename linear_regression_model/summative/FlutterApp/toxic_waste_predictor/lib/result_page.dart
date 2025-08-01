import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ResultPage extends StatefulWidget {
  final Map<String, String> inputData;

  ResultPage({required this.inputData});

  @override
  _ResultPageState createState() => _ResultPageState();
}

class _ResultPageState extends State<ResultPage> {
  String result = "Predicting...";

  @override
  void initState() {
    super.initState();
    _makePrediction();
  }

  Future<void> _makePrediction() async {
    // Updated API URL with /predict endpoint
    const String apiUrl = 'https://new-lr.onrender.com/predict';

    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          "Country": int.parse(widget.inputData['Country']!),
          "Latitude": double.parse(widget.inputData['Latitude']!),
          "Longitude": double.parse(widget.inputData['Longitude']!),
          // Keep the widget.inputData keys as-is but map to underscore keys for API
          "Dumping_Entity": int.parse(widget.inputData['Dumping Entity']!),
          "Legal_Actions": int.parse(widget.inputData['Legal Actions']!),
          "Year": double.parse(widget.inputData['Year']!),
          "Waste_Type": int.parse(widget.inputData['Waste Type']!)
        }),
      );

      if (response.statusCode == 200) {
        final decoded = json.decode(response.body);
        setState(() {
          // Updated to match FastAPI response key
          result = "Estimated Toxic Waste: ${decoded['predicted_waste_volume_tons'].toString()} tons";
        });
      } else {
        setState(() {
          result = "⚠️ Error: ${response.statusCode} - ${response.body}";
        });
      }
    } catch (e) {
      setState(() {
        result = "❌ Network error: $e";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Prediction Result")),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(result, style: TextStyle(fontSize: 20)),
        ),
      ),
    );
  }
}
