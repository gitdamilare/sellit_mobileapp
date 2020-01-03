import 'dart:io';

import 'package:path_provider/path_provider.dart';

class Root{
  Root._();
  static final Root rootObject = Root._();
  String rootPath = "";
  File localPath;

   Future<String> getRootPath() async {
    final directory = await getApplicationDocumentsDirectory();
    String directoryName = '/sellitApp';
    if (!new Directory(directory.absolute.path + directoryName).existsSync()) {
      new Directory(directory.absolute.path + directoryName)
          .createSync(recursive: true);
    }
    String directorynew =
        new Directory(directory.absolute.path + directoryName).path;
    rootObject.rootPath = directorynew; //storing the path into the rootObject
    return directorynew;
  }

  Future<File> localFile() async {
    File file = new File(await getRootPath() + "/accountData.json");
    if (!file.existsSync()) {
      file.createSync();
      return file;
    } else {
      return file;
    }
  }


}