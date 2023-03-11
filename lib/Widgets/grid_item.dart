
import 'package:flutter/material.dart';
import 'package:texon_friends_app/Views/friend_details_screen.dart';

import '../Models/result.dart';

class GridItem extends StatelessWidget {
  final Result person;
  final Orientation orientation;

  const GridItem({super.key, required this.person, required this.orientation});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(builder: (_) => FriendDetailsScreen(person: person,)));
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: size.height * .3,
            width: size.width * .4,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20)
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Image.network(person.picture.large, fit: BoxFit.cover,),
            ),
          ),
          const SizedBox(height: 10,),
          Text('${person.name.title} ${person.name.first} ${person.name.last}', style: const TextStyle(overflow: TextOverflow.ellipsis ,fontWeight: FontWeight.bold, fontSize: 15, color: Colors.black),),
          const SizedBox(height: 5,),
          Text('From : ${person.location.country}', style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 12, color: Colors.black),),
        ],
      ),
    );
  }
}
