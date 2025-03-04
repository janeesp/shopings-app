import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mime_type/mime_type.dart';

const allowedFormats = {'image/png', 'image/jpeg', 'video/mp4', 'image/gif'};
bool validateFileFormat(String filePath, BuildContext context) {
  if (allowedFormats.contains(mime(filePath))) {
    return true;
  }
  ScaffoldMessenger.of(context)
    ..hideCurrentSnackBar()
    ..showSnackBar(SnackBar(
      content: Text('Invalid file format: ${mime(filePath)}'),
    ));
  return false;
}
String storagePath( String filePath, bool isVideo) {
  final timestamp = DateTime.now().microsecondsSinceEpoch;
  // Workaround fixed by https://github.com/flutter/plugins/pull/3685
  // (not yet in stable).
  final ext = isVideo ? 'mp4' : filePath.split('.').last;
  return 'users/uploads/$timestamp.$ext';
}
fileSizeExceeded(BuildContext context) {
  print('saaaaaa');
  ScaffoldMessenger.of(context)
    ..hideCurrentSnackBar()
    ..showSnackBar(SnackBar(
      content: Text('media file size exceeded...'),
    ));
  print('saaaaaa2');
  // return false;
}
class SelectedMedia {
  const SelectedMedia(this.storagePath, this.bytes);
  final String storagePath;
  final Uint8List bytes;
}

enum MediaSource {
  photoGallery,
  videoGallery,
  camera,
}
Future<SelectedMedia?> selectMedia({
  double? maxWidth,
  double? maxHeight,
  bool isVideo = false,
  BuildContext? context,
  MediaSource mediaSource = MediaSource.camera,
}) async {
  final picker = ImagePicker();
  final source = mediaSource == MediaSource.camera
      ? ImageSource.camera
      : ImageSource.gallery;
  final pickedMediaFuture = isVideo
      ? picker.pickVideo(source: source)
      : picker.pickImage( source: source,
    // imageQuality: 30,maxWidth: maxWidth, maxHeight: maxHeight
  );

  final pickedMedia = await pickedMediaFuture;
  final mediaBytes = await pickedMedia?.readAsBytes();

  int bytesLength = mediaBytes!.lengthInBytes;
  double megabytes = bytesLength / 1024.0 / 1024.0;

  print(megabytes.toString());
  print('bbvbvbvbvbvbvbvbvb');

  if (mediaBytes == null) {
    return null;
  }
  if(megabytes> 2){
    print('EXCEEEDED');
    return fileSizeExceeded(context!);
  }

  final path = storagePath( pickedMedia!.name, isVideo);
  return SelectedMedia(path, mediaBytes);
}
