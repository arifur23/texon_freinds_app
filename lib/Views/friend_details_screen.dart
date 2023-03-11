import 'package:flutter/material.dart';
import 'package:open_mail_app/open_mail_app.dart';
import 'package:texon_friends_app/Models/result.dart';

class FriendDetailsScreen extends StatelessWidget {
  final Result person;

  const FriendDetailsScreen({super.key, required this.person});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    bool isIOS = Theme.of(context).platform == TargetPlatform.iOS;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Details'),
      ),
      body: SafeArea(
        child: OrientationBuilder(
          builder: (context, orientation){
            return SingleChildScrollView(
              child: Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(height: 50,),
                    Container(
                      height: orientation == Orientation.portrait ? size.height * .3 : size.width * .3,
                      width: orientation == Orientation.portrait ? size.width : size.height,
                      decoration: const BoxDecoration(
                          color: Colors.red
                      ),
                      child: Image.network(person.picture.large, fit: BoxFit.cover,),
                    ),
                    const SizedBox(height: 50,),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text('Address ', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.black),),
                          const SizedBox(height: 7,),
                          Text('City : ${person.location.city}', style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black),),
                          const SizedBox(height: 7,),
                          Text('State : ${person.location.state}', style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black),),
                          const SizedBox(height: 7,),
                          Text('Country : ${person.location.country}', style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black),),
                          const SizedBox(height: 20,),
                          const Text('Email ', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.black),),
                          const SizedBox(height: 7,),
                          Text(person.email, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black)),
                          const SizedBox(height: 10,),
                          Text('Cell : ${person.cell}', style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black),),
                          const SizedBox(height: 7,),
                          ElevatedButton(
                            child: const Text('Open mail and send a mail'),
                            onPressed: () async {
                              EmailContent email = EmailContent(
                                to: [
                                  person.email,
                                ],
                                subject: 'Hello!',
                                body: 'How are you doing?',
                                cc: ['user2@domain.com', 'user3@domain.com'],
                                bcc: ['boss@domain.com'],
                              );

                              OpenMailAppResult result =
                              await OpenMailApp.composeNewEmailInMailApp(
                                  nativePickerTitle: 'Select email app to compose',
                                  emailContent: email);
                              if (!result.didOpen && !result.canOpen) {
                                showNoMailAppsDialog(context);
                              } else if (!result.didOpen && result.canOpen) {
                                showDialog(
                                  context: context,
                                  builder: (_) => MailAppPickerDialog(
                                    mailApps: result.options,
                                    emailContent: email,
                                  ),
                                );
                              }
                            },
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            );
          },
        )
      ),
    );
  }
}
void showNoMailAppsDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: const Text("Open Mail App"),
        content: const Text("No mail apps installed"),
        actions: <Widget>[
          TextButton(
            child: const Text("OK"),
            onPressed: () {
              Navigator.pop(context);
            },
          )
        ],
      );
    },
  );
}
