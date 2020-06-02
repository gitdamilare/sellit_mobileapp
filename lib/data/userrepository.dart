import 'dart:convert' as convert;
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:sellit_mobileapp/models/inputDtos/auth.dart';
import 'package:sellit_mobileapp/models/outputDtos/authoutputDto.dart';
import 'package:sellit_mobileapp/services/coredata.dart';
import 'package:sellit_mobileapp/services/jsonrepo.dart';
import 'package:sellit_mobileapp/services/root.dart';
import 'package:sellit_mobileapp/utilis/urlLinks.dart';
import "package:http/http.dart" as http;

abstract class UserRepository {
  Future<AuthOutputDto> authenticate(Auth input);
  Future<void> deleteToken();
  Future<void> persistToken(AuthOutputDto token);
  Future<bool> hasToken();
}

class UserServices extends UserRepository {
final storage = new FlutterSecureStorage();

  @override
  Future<AuthOutputDto> authenticate(Auth input) async {
    AuthOutputDto result = AuthOutputDto();
    String url = AuthenicationApi;
    var jsoninput = convert.jsonEncode(input);
    debugPrint(jsoninput);
    try {
      var response = await http.post(url,
          body: jsoninput,
          headers: {HttpHeaders.contentTypeHeader: "application/json"});
     if(response.statusCode == 200){
        var jsonBody = response.body;
        var output = convert.jsonDecode(jsonBody);
        result = AuthOutputDto.fromJson(output);

        //Save the Logged User Info
       // await JsonRepo.jsonRepoObject.writeAccountDataToJson(result);
     }
    } catch (e) {
      debugPrint(e);
    }
    return result;
  }

  @override
  Future<void> deleteToken() async {
    await storage.delete(key: "token");
    return null;
  }

  @override
  Future<bool> hasToken() async {
   // AuthOutputDto authCheck =
      //  await JsonRepo.jsonRepoObject.getDatafromJsonFile();
    String value = await storage.read(key: "token");
    if (value != null) {
      return true;
    }
    return false;
  }

  @override
  Future<void> persistToken(AuthOutputDto input) async {
    await storage.write(key: "token", value: input.token);
    Root.rootObject.rootPath = await Root.rootObject.getRootPath();
    Root.rootObject.localPath = await Root.rootObject.localFile();
    Root.rootObject.localPath = await JsonRepo.jsonRepoObject.writeAccountDataToJson(input);
    
    //Save Data For First Login
    CoreData.coreDataObject.userInfo = input.userinfo;
  }
}
