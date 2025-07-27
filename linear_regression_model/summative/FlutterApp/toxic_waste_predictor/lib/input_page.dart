import 'package:flutter/material.dart';
import 'result_page.dart';

class InputPage extends StatefulWidget {
  @override
  _InputPageState createState() => _InputPageState();
}

class _InputPageState extends State<InputPage> {
  final _formKey = GlobalKey<FormState>();

  final latitudeController = TextEditingController();
  final longitudeController = TextEditingController();
  final yearController = TextEditingController();

  String? selectedCountry;
  String? selectedDumpingEntity;
  String? selectedLegalAction;
  String? selectedWasteType;

  static const List<String> africanCountries = [
    'Algeria', 'Angola', 'Benin', 'Botswana', 'Burkina Faso', 'Burundi',
    'Cabo Verde', 'Cameroon', 'Central African Republic', 'Chad', 'Comoros',
    'Congo (Brazzaville)', 'Congo (Kinshasa)', 'Djibouti', 'Egypt',
    'Equatorial Guinea', 'Eritrea', 'Eswatini', 'Ethiopia', 'Gabon', 'Gambia',
    'Ghana', 'Guinea', 'Guinea-Bissau', 'Ivory Coast', 'Kenya', 'Lesotho',
    'Liberia', 'Libya', 'Madagascar', 'Malawi', 'Mali', 'Mauritania',
    'Mauritius', 'Morocco', 'Mozambique', 'Namibia', 'Niger', 'Nigeria',
    'Rwanda', 'São Tomé and Príncipe', 'Senegal', 'Seychelles', 'Sierra Leone',
    'Somalia', 'South Africa', 'South Sudan', 'Sudan', 'Tanzania', 'Togo',
    'Tunisia', 'Uganda', 'Zambia', 'Zimbabwe'
  ];

  final Map<String, int> countryMap = {
    for (int i = 0; i < africanCountries.length; i++) africanCountries[i]: i
  };

  final List<String> dumpingEntities = ['Company', 'Government', 'Individual'];
  final Map<String, int> dumpingEntityMap = {
    'Company': 0,
    'Government': 1,
    'Individual': 2,
  };

  final List<String> legalActions = ['None', 'Investigation', 'Prosecuted'];
  final Map<String, int> legalActionMap = {
    'None': 0,
    'Investigation': 1,
    'Prosecuted': 2,
  };

  final List<String> wasteTypes = ['Chemical', 'Radioactive', 'Industrial'];
  final Map<String, int> wasteTypeMap = {
    'Chemical': 0,
    'Radioactive': 1,
    'Industrial': 2,
  };

  void _onPredictPressed() {
    if (_formKey.currentState!.validate() &&
        selectedCountry != null &&
        selectedDumpingEntity != null &&
        selectedLegalAction != null &&
        selectedWasteType != null) {
      final inputData = {
        'Country': countryMap[selectedCountry]!.toString(),
        'Latitude': latitudeController.text,
        'Longitude': longitudeController.text,
        'Dumping Entity': dumpingEntityMap[selectedDumpingEntity]!.toString(),
        'Legal Actions': legalActionMap[selectedLegalAction]!.toString(),
        'Year': yearController.text,
        'Waste Type': wasteTypeMap[selectedWasteType]!.toString(),
      };

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => ResultPage(inputData: inputData),
        ),
      );
    }
  }

  Widget _buildDropdown<T>({
    required String label,
    required List<T> items,
    required T? value,
    required void Function(T?) onChanged,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: DropdownButtonFormField<T>(
        value: value,
        items: items
            .map((e) => DropdownMenuItem(value: e, child: Text(e.toString())))
            .toList(),
        onChanged: onChanged,
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
          filled: true,
          fillColor: Colors.white,
        ),
        validator: (val) => val == null ? 'Please select $label' : null,
      ),
    );
  }

  Widget _buildTextField(String label, TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: TextFormField(
        controller: controller,
        keyboardType: TextInputType.numberWithOptions(decimal: true),
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
          filled: true,
          fillColor: Colors.white,
        ),
        validator: (value) =>
            value == null || value.isEmpty ? 'Enter $label' : null,
      ),
    );
  }

  @override
  void dispose() {
    latitudeController.dispose();
    longitudeController.dispose();
    yearController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Input Incident Details")),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              _buildDropdown(
                label: "Country",
                items: africanCountries,
                value: selectedCountry,
                onChanged: (val) => setState(() => selectedCountry = val),
              ),
              _buildTextField("Latitude", latitudeController),
              _buildTextField("Longitude", longitudeController),
              _buildDropdown(
                label: "Dumping Entity",
                items: dumpingEntities,
                value: selectedDumpingEntity,
                onChanged: (val) => setState(() => selectedDumpingEntity = val),
              ),
              _buildDropdown(
                label: "Legal Actions",
                items: legalActions,
                value: selectedLegalAction,
                onChanged: (val) => setState(() => selectedLegalAction = val),
              ),
              _buildTextField("Year", yearController),
              _buildDropdown(
                label: "Waste Type",
                items: wasteTypes,
                value: selectedWasteType,
                onChanged: (val) => setState(() => selectedWasteType = val),
              ),
              SizedBox(height: 24),
              ElevatedButton(
                onPressed: _onPredictPressed,
                child: Text("Predict"),
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(horizontal: 40, vertical: 16),
                  textStyle: TextStyle(fontSize: 16),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
