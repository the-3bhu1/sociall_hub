import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:mobx/mobx.dart';
import 'dart:io';

part 'post_store.g.dart';

class PostStore = _PostStore with _$PostStore;

abstract class _PostStore with Store {
  @observable
  ObservableList<Map<String, dynamic>> posts = ObservableList<Map<String, dynamic>>();

  @observable
  File? selectedImage;

  @observable
  String message = '';

  @observable
  bool uploading = false;

  @observable
  String? errorMessage;

  @action
  void setSelectedImage(File? image) {
    selectedImage = image;
  }

  @action
  void setMessage(String msg) {
    message = msg;
  }

  @action
  Future<void> postMessage() async {
    if (message.isNotEmpty && selectedImage != null) {
      try {
        uploading = true;
        errorMessage = null;

        // Upload the image to Firebase Storage and get the download URL
        String filePath = 'images/${DateTime.now().millisecondsSinceEpoch}.jpg';
        Reference reference = FirebaseStorage.instance.ref(filePath);
        TaskSnapshot snapshot = await reference.putFile(selectedImage!);
        String downloadUrl = await snapshot.ref.getDownloadURL();

        // Save the post data to Firestore
        await FirebaseFirestore.instance.collection("UserPosts").add({
          'UserEmail': FirebaseAuth.instance.currentUser!.email,
          'Message': message,
          'url': downloadUrl,
          'TimeStamp': Timestamp.now(),
        });

        // Update the store
        posts.add({
          'UserEmail': FirebaseAuth.instance.currentUser!.email,
          'Message': message,
          'url': downloadUrl,
          'TimeStamp': Timestamp.now(),
        });

        // Reset state
        uploading = false;
        message = '';
        selectedImage = null;
      } catch (e) {
        print('Error posting message: $e');
        uploading = false;
        errorMessage = 'Failed to post message. Please try again.';
      }
    } else {
      errorMessage = 'Please enter a message and select an image.';
    }
  }
}
