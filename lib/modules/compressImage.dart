// ignore_for_file: file_names

import "dart:io";
import "dart:typed_data";

// import "package:flutter_image_compress/flutter_image_compress.dart";
import "package:path_provider/path_provider.dart";

import "log.dart";

const imageQUALITY = 80;

// Future<File?> compressImage({File? image, Uint8List? bytes}) async {
//   Uint8List compressedImage;

//   final directory = await getTemporaryDirectory();
//   final fileName =
//       "${DateTime.now().toString()}_.${image?.path.split(".").last ?? '.jpg'}";
//   File result = File('${directory.path}/$fileName');
//   if (image != null) {
//     compressedImage = await FlutterImageCompress.compressWithFile(
//         image.absolute.path,
//         quality: imageQUALITY) as dynamic;
//   } else if (bytes != null) {
//     compressedImage =
//         await FlutterImageCompress.compressWithList(bytes, quality: 80);
//   } else {
//     throw Log("error occurred compressing image");
//   }

//   result.writeAsBytesSync(compressedImage);

//   return (bytes == null && image == null) ? null : result;
// }
