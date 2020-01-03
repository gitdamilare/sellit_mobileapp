import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:sellit_mobileapp/models/outputDtos/authoutputDto.dart';
import 'package:sellit_mobileapp/services/root.dart';

class JsonRepo {
  JsonRepo._();
  static final JsonRepo jsonRepoObject = JsonRepo._();

  Future<File> writeAccountDataToJson(AuthOutputDto input) async {
    try {
      if (input != null) {
        var data = input.toJson();
        var jsonData = json.encode(data);
        File jsonFile = await Root.rootObject.localFile();
        return jsonFile.writeAsString(jsonData);
      } else {
        return null;
      }
    } catch (e) {
      debugPrint(e);
      return null;
    }
  }

  Future<AuthOutputDto> getDatafromJsonFile() async {
    try {
      final file = Root.rootObject.localPath;
      dynamic reading = await file.readAsString();
      dynamic decoding = json.decode(reading);
      AuthOutputDto application = AuthOutputDto.fromJson(decoding);
      return application;
    } catch (e) {
      return null;
    }
  }
}
