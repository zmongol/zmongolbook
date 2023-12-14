import 'package:excel/excel.dart';
import 'package:flutter/services.dart' show ByteData, rootBundle;

class DataReader {
  DataReader._privateConstructor();
  static final DataReader _dataReader = DataReader._privateConstructor();
  static DataReader get instance {
    return _dataReader;
  }

  //NOTE: keep the original data load from the file
  List<Map<String, String>> originalData = [];

  //NOTE: keep the data on searching
  List<Map<String, String>> data = [];

  readData() async {
    this.data.clear();
    ByteData data = await rootBundle.load("assets/data.xlsx");
    var bytes = data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
    var excel = Excel.decodeBytes(bytes);

    for (var table in excel.tables.keys) {
      for (var row in excel.tables[table]!.rows) {
        if (row.isNotEmpty && row.length > 1) {
          if (row[0] == null || row[1] == null) {
            continue;
          }

          if (row.first!.rowIndex == 0) {
            continue;
          }

          Map<String, String> rowContent = {
            'title': row[0]!.value?.toString() ?? '',
            'article': row[1]!.value?.toString() ?? '',
          };

          this.originalData.add(rowContent);
        }
      }
    }
    this.data = this.originalData;
    print('Data content length: ${this.originalData.length}');
  }

  getTitleByIndex(int index) {
    return data[index]['title'] ?? '';
  }

  getContentByIndex(int index) {
    return data[index]['article'] ?? '';
  }
}
