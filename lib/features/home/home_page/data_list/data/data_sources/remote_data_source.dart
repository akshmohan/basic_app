import 'dart:convert';
import 'package:machine_test_new/core/errors/exceptions.dart';
import 'package:http/http.dart' as http;
import '../models/data_model.dart';

abstract interface class RemoteDataSource {
  Future<List<DataModel>> loadRemoteData();
}

class RemoteDataSourceImpl implements RemoteDataSource {
  @override
  Future<List<DataModel>> loadRemoteData() async {
    try {
      final response = await http
          .get(Uri.parse('https://jsonplaceholder.typicode.com/comments'));

      if (response.statusCode == 200) {
        List<DataModel> data = [];

        List result = jsonDecode(response.body);

        result.map((e) => data.add(DataModel.fromJson(e))).toList();

        return data;
      } else {
        throw ServerException("Something went wrong");
      }
    } catch (e) {
      throw ServerException(e.toString());
    }
  }
}
