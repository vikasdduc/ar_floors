

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/material.dart';



class EmailLinkSignInSection extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _EmailLinkSignInSectionState();
}
final FirebaseAuth _auth = FirebaseAuth.instance;

class _EmailLinkSignInSectionState extends State<EmailLinkSignInSection>
    with WidgetsBindingObserver {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  bool _success = false;
  late String _userEmail;
  late String _userID;



  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    _emailController.dispose();
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) async {
    if (state == AppLifecycleState.resumed) {
      final PendingDynamicLinkData? data =
      await FirebaseDynamicLinks.instance.getInitialLink();
      if( data?.link != null ) {
        handleLink(data!.link);
      }
      FirebaseDynamicLinks.instance.onLink.listen((dynamicLink){
            final Uri deepLink = dynamicLink.link;
            handleLink(deepLink);
          },
          onError: (e) async {
        print('onLinkError');
        print(e.message);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  child: const Text('Test sign in with email and link'),
                  padding: const EdgeInsets.all(16),
                  alignment: Alignment.center,
                ),
                TextFormField(
                  controller: _emailController,
                  decoration: const InputDecoration(labelText: 'Email'),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter your email.';
                    }
                    return null;
                  },
                ),
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  alignment: Alignment.center,
                  child: ElevatedButton(
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        _signInWithEmailAndLink();
                      }
                    },
                    child: const Text('Submit'),
                  ),
                ),
                Container(
                  alignment: Alignment.center,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Text(
                    _success == null
                        ? ''
                        : (_success
                        ? 'Successfully signed in, uid: ' + _userID
                        : 'Sign in failed'),
                    style: TextStyle(color: Colors.red),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _signInWithEmailAndLink() async {
    _userEmail = _emailController.text;
    return await _auth.sendSignInLinkToEmail(
      email: _userEmail,
      actionCodeSettings: ActionCodeSettings(
        url:'https://instaclone555.page.link/6SuK',
         // url: 'https://instaclone555.page.link/6SuK',
        androidPackageName:'com.example.insta_clone',
        androidMinimumVersion:"11",
        dynamicLinkDomain: "instaclone555.page.link",
        handleCodeInApp : true,
      ),
    );
  }

  void handleLink(Uri link) async {
    if (link != null) {
      final User? user = (await _auth.signInWithEmailLink(
        email: _userEmail,
        emailLink: link.toString(),
      ))
          .user;
      if (user != null) {
        setState(() {
          _userID = user.uid;
          _success = true;
        });
      } else {
        setState(() {
          _success = false;
        });
      }
    } else {
      setState(() {
        _success = false;
      });
    }
    setState(() {});
  }

}





