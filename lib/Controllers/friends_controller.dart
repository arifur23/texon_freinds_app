import 'dart:convert';

import 'package:get/get.dart';
import 'package:texon_friends_app/Models/result.dart';
import 'package:http/http.dart' as http;

class FriendsController extends GetxController{

  late Friends? friends;
   var isLoading = false.obs;
  var url = 'https://randomuser.me/api/?results=10';

   @override
  void onInit() {
    fetchFriends();
    super.onInit();
  }

  // Fetching friends data from api server

  void fetchFriends() async {
     try{
       isLoading(true);
       http.Response response = await http.get(Uri.tryParse(url)!);
       if(response.statusCode == 200){
         var json = jsonDecode(response.body);

         friends = Friends.fromJson(json);
         print(friends!.results[0].name.first);

       }
     }catch(e){
       print(e.toString());
       isLoading(true);
     }
     isLoading(false);
  }

}