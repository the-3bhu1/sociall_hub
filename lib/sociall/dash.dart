import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:social_hub/sociall/login.dart';
import 'package:social_hub/post_store.dart';

class DashScreen extends StatefulWidget {
  const DashScreen({super.key});

  @override
  State<DashScreen> createState() => _DashScreen();
}

class _DashScreen extends State<DashScreen> {
  final PostStore postStore = PostStore();

  Future _pickImageFromGallery() async {
    final returnedImage = await ImagePicker().pickImage(source: ImageSource.gallery);

    if (returnedImage == null) return;
    postStore.setSelectedImage(File(returnedImage.path));
  }

  void signOut() {
    FirebaseAuth.instance.signOut();
    Get.to(() => const LoginPage());
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text('Social Hub', style: TextStyle(fontSize: width * 0.05, fontWeight: FontWeight.bold),),
        actions: [
          IconButton(
            onPressed: signOut,
            icon: const Icon(Icons.logout),
          )
        ],
      ),
      body: Column(
        children: [
          Expanded(
              child: StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection("UserPosts")
                    .orderBy(
                  'TimeStamp',
                  descending: false,
                ).snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return ListView.builder(
                      itemCount: snapshot.data!.docs.length,
                      itemBuilder: (context, index) {
                        final post = snapshot.data!.docs[index];
                        return PostWidget(
                          message: post['Message'],
                          user: post['UserEmail'],
                          imageUrl: post['url'],
                        );
                      },
                    );
                  } else if (snapshot.hasError) {
                    return Center(
                      child: Text('Error${snapshot.error}'),
                    );
                  }
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                },
              )
          ),
        ],
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        child: BottomAppBar(
          child: Row(
            children: [
              Expanded(
                child: Observer(
                  builder: (_) => TextFormField(
                    onChanged: postStore.setMessage,
                    decoration: InputDecoration(
                        hintText: 'Say Something...',
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(7))
                    ),
                  ),
                ),
              ),
              Observer(
                builder: (_) => postStore.selectedImage != null
                    ? Row(
                  children: [
                    SizedBox(width: width * 0.02,),
                    Image.file(postStore.selectedImage!),
                    SizedBox(width: width * 0.01,),
                    GestureDetector(
                        onTap: () => postStore.setSelectedImage(null),
                        child: Icon(Icons.close, size: width * 0.1,)
                    ),
                  ],
                )
                    : Row(
                  children: [
                    SizedBox(width: width * 0.01,),
                    GestureDetector(
                        onTap: _pickImageFromGallery,
                        child: Icon(Icons.image_outlined, size: width * 0.1,)
                    ),
                  ],
                ),
              ),
              SizedBox(width: width * 0.01,),
              GestureDetector(
                onTap: postStore.postMessage,
                child: Icon(Icons.send, size: width * 0.1,),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class PostWidget extends StatefulWidget {
  final String message;
  final String user;
  final String imageUrl;

  const PostWidget({super.key, required this.message, required this.user, required this.imageUrl,});

  @override
  State<PostWidget> createState() => _PostWidgetState();
}

class _PostWidgetState extends State<PostWidget> {
  bool _isFavorited = false;
  bool _isFollowing = false;

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Column(
      children: [
        Card(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(widget.user, style: TextStyle(fontWeight: FontWeight.bold, fontSize: width * 0.04),),
                    SizedBox(width: width * 0.01,),
                    Icon(Icons.check_circle_outline, color: Colors.blue, size: width * 0.05,),
                    SizedBox(width: width * 0.01,),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          _isFollowing =!_isFollowing; // toggle the state
                        });
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.black),
                          borderRadius: BorderRadius.circular(7),
                        ),
                        padding: EdgeInsets.symmetric(horizontal: width * 0.01),
                        child: Text(_isFollowing? 'unfollow' : 'follow'), // change the text based on the state
                      ),
                    ),
                  ],
                ),
                SizedBox(height: height * 0.01,),
                Center(child: Image.network(widget.imageUrl)),
                SizedBox(height: height * 0.01,),
                Text(widget.message),
                SizedBox(height: height * 0.02,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          _isFavorited =!_isFavorited;
                        });
                      },
                      child: _isFavorited
                          ? Icon(Icons.favorite, size: width * 0.05, color: Colors.red)
                          : Icon(Icons.favorite_border, size: width * 0.05),
                    ),
                    Icon(Icons.comment, size: width * 0.05,),
                    Icon(Icons.share, size: width * 0.05,),
                  ],
                ),
              ],
            ),
          ),
        ),
        SizedBox(height: height * 0.01,)
      ],
    );
  }
}