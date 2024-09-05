import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class ApiCallScreen extends StatefulWidget {
  @override
  _ApiCallScreenState createState() => _ApiCallScreenState();
}

class _ApiCallScreenState extends State<ApiCallScreen> {
  Dio _dio = Dio();
  String _apiResult = "Loading...";

  @override
  void initState() {
    super.initState();
    _fetchData();
  }

  Future<void> _fetchData() async {
    try {
      final String url =
          'https://96a1baf7-79a6-4f96-9fe3-86a9058ae230.mock.pstmn.io/api/status-order/list/';
      final Map<String, String> headers = {'Content-Type': 'application/json'};

      final Map<String, dynamic> body = {
        "from_date": "2023-04-01",
        "location_id": 273,
        "status": ["rejected"],
        "to_date": "2023-04-03",
        "vendor_id": 1,
      };

      final response =
          await _dio.post(url, data: body, options: Options(headers: headers));

      if (response.statusCode == 200) {
        setState(() {
          _apiResult = response.data.toString();
        });
      } else {
        setState(() {
          _apiResult = 'Failed to load data: ${response.statusCode}';
        });
      }
    } catch (e) {
      setState(() {
        _apiResult = 'Error: $e';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('API Call Screen'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Text(_apiResult),
        ),
      ),
    );
  }
}
