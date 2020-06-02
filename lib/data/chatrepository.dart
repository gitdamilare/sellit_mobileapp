import 'dart:io';

import 'package:flutter/material.dart';
import 'package:sellit_mobileapp/models/chat.dart';
import 'package:sellit_mobileapp/models/outputDtos/chatoutputDto.dart';
import 'package:sellit_mobileapp/models/user.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;
import 'package:sellit_mobileapp/services/coredata.dart';
import 'package:sellit_mobileapp/utilis/urlLinks.dart';

abstract class ChatRepository {
  Future<List<User>> getAllChatContact();
  Future<List<Chat>> getAllChatMessages(ChatOutputDto input);
  Future<String> sendMessage(ChatOutputDto input);
}

class ChatService extends ChatRepository {
  @override
  Future<List<User>> getAllChatContact() async {
    List<User> result = List<User>();
    int userId = CoreData.coreDataObject.userInfo.matrikelnumber;
    try {
      var response = await http.get(GetChatContactAPI + "$userId");
      if (response.statusCode == 200) {
        var jsonBody = convert.jsonDecode(response.body);
        var jsonMap = jsonBody["rows"];
        if (jsonMap != null) {
          jsonMap.forEach((e) {
            result.add(User.fromJson(e));
          });
        }
      }
    } catch (e) {
      debugPrint(e.toString());
    }

    return result;
  }

  @override
  Future<List<Chat>> getAllChatMessages(ChatOutputDto input) async {
    List<Chat> messages = List<Chat>();
    try {
      var encodedBody = convert.jsonEncode(input);
      print(encodedBody);
      var response = await http.post(GetMessagesAPI,
          body: encodedBody,
          headers: {HttpHeaders.contentTypeHeader: "application/json"}
          );
      if(response.statusCode == 200){
        var jsonBody = convert.jsonDecode(response.body);
        var jsonMap = jsonBody["rows"];
                if (jsonMap != null) {
          jsonMap.forEach((e) {
            messages.add(Chat.fromJson(e));
          });
        }
        return messages;
      }
    } catch (e) {
        print(e);
    }
    return null;
  }

  @override
  Future<String> sendMessage(ChatOutputDto input) async{
    try {
      var encodedBody = convert.jsonEncode(input);
      print(encodedBody);
      var response = await http.post(PostMessageAPI,
          body: encodedBody,
          headers: {HttpHeaders.contentTypeHeader: "application/json"});
      if(response.statusCode == 200){
        var jsonBody = response.body;
        var mappedJson = convert.jsonDecode(jsonBody);
        var result = mappedJson["status"];
        return result;
      }
    } catch (e) {
        print(e);
    }
    return null;
  }
}
