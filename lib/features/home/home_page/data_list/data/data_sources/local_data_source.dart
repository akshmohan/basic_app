import 'package:hive/hive.dart';
import '../models/data_model.dart';

abstract interface class LocalDataSource {
  void uploadLocalData({required List<DataModel> data});

  List<DataModel> loadData();
}

class LocalDataSourceImpl implements LocalDataSource {
  final Box box;

  LocalDataSourceImpl(this.box);

  @override
  List<DataModel> loadData() {
    List<DataModel> data = [];
    box.read(() {
      for (int i = 0; i < box.length; i++) {
        data.add(DataModel.fromJson(box.get(i.toString())));
      }
    });

    return data;
  }

  @override
  void uploadLocalData({required List<DataModel> data}) {
    box.write(() {
      for (int i = 0; i < data.length; i++) {
        box.put(i.toString(), data[i].toJson());
      }
    });
  }
}
