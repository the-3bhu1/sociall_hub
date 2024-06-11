// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$PostStore on _PostStore, Store {
  late final _$postsAtom = Atom(name: '_PostStore.posts', context: context);

  @override
  ObservableList<Map<String, dynamic>> get posts {
    _$postsAtom.reportRead();
    return super.posts;
  }

  @override
  set posts(ObservableList<Map<String, dynamic>> value) {
    _$postsAtom.reportWrite(value, super.posts, () {
      super.posts = value;
    });
  }

  late final _$selectedImageAtom =
      Atom(name: '_PostStore.selectedImage', context: context);

  @override
  File? get selectedImage {
    _$selectedImageAtom.reportRead();
    return super.selectedImage;
  }

  @override
  set selectedImage(File? value) {
    _$selectedImageAtom.reportWrite(value, super.selectedImage, () {
      super.selectedImage = value;
    });
  }

  late final _$messageAtom = Atom(name: '_PostStore.message', context: context);

  @override
  String get message {
    _$messageAtom.reportRead();
    return super.message;
  }

  @override
  set message(String value) {
    _$messageAtom.reportWrite(value, super.message, () {
      super.message = value;
    });
  }

  late final _$uploadingAtom =
      Atom(name: '_PostStore.uploading', context: context);

  @override
  bool get uploading {
    _$uploadingAtom.reportRead();
    return super.uploading;
  }

  @override
  set uploading(bool value) {
    _$uploadingAtom.reportWrite(value, super.uploading, () {
      super.uploading = value;
    });
  }

  late final _$errorMessageAtom =
      Atom(name: '_PostStore.errorMessage', context: context);

  @override
  String? get errorMessage {
    _$errorMessageAtom.reportRead();
    return super.errorMessage;
  }

  @override
  set errorMessage(String? value) {
    _$errorMessageAtom.reportWrite(value, super.errorMessage, () {
      super.errorMessage = value;
    });
  }

  late final _$postMessageAsyncAction =
      AsyncAction('_PostStore.postMessage', context: context);

  @override
  Future<void> postMessage() {
    return _$postMessageAsyncAction.run(() => super.postMessage());
  }

  late final _$_PostStoreActionController =
      ActionController(name: '_PostStore', context: context);

  @override
  void setSelectedImage(File? image) {
    final _$actionInfo = _$_PostStoreActionController.startAction(
        name: '_PostStore.setSelectedImage');
    try {
      return super.setSelectedImage(image);
    } finally {
      _$_PostStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setMessage(String msg) {
    final _$actionInfo =
        _$_PostStoreActionController.startAction(name: '_PostStore.setMessage');
    try {
      return super.setMessage(msg);
    } finally {
      _$_PostStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
posts: ${posts},
selectedImage: ${selectedImage},
message: ${message},
uploading: ${uploading},
errorMessage: ${errorMessage}
    ''';
  }
}
