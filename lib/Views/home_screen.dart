import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:texon_friends_app/Controllers/friends_controller.dart';

import '../Widgets/grid_item.dart';

class HomeScreen extends StatelessWidget {
   HomeScreen({Key? key}) : super(key: key);

  FriendsController controller = Get.put(FriendsController());


  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
     bool isIOS = Theme.of(context).platform == TargetPlatform.iOS;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Friends APP'),
      ),
      body: OrientationBuilder(
        builder: (context, orientation) {
          return Obx(() => controller.isLoading.value ? const Center(child: CircularProgressIndicator()) :
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    const SizedBox(height: 50,),
                    const Text('List of Friends', style: TextStyle(fontSize: 25, fontWeight: FontWeight.w600, color: Colors.black),),
                    const SizedBox(height: 20,),
                    GridView.count(
                      physics: const NeverScrollableScrollPhysics(),
                      childAspectRatio: orientation == Orientation.portrait ? size.width / (size.height  - 100) : size.height / (size.width - (isIOS ? 700 : 570)),
                      shrinkWrap: true,
                      crossAxisCount: orientation == Orientation.portrait ? 2 : 2,
                      mainAxisSpacing: 15,
                      crossAxisSpacing: 15,
                      children: List.generate(
                          controller.friends!.results.length,
                              (index) =>  GridItem(orientation: orientation ,person: controller.friends!.results[index],)
                      ),
                    )
                  ],
                ),
              ),
            ),
          ));
        },
      ),
    );
  }
}
