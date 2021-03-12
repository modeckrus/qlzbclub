import 'dart:io';

import 'package:path_provider/path_provider.dart';

class PathService {
  static String? tempDirPath;
  static String? cacheDir;
  static String? hiveDir;
  static const defaultPath = '/qlzbclub/';
  static init() async {
    tempDirPath = (await getTemporaryDirectory()).absolute.path + '/qlzbclub';
    if (!(await Directory(tempDirPath?? defaultPath).exists())) {
      await Directory(tempDirPath??defaultPath).create();
    }
    cacheDir = tempDirPath;
    hiveDir =
        (await getApplicationDocumentsDirectory()).absolute.path + '/qlzbclub';
    if (!(await Directory(hiveDir??defaultPath).exists())) {
      await Directory(hiveDir??defaultPath).create();
    }
  }
}
