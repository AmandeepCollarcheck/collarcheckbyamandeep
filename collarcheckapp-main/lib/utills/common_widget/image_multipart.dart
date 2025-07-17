import 'dart:io';
import 'package:path/path.dart';
import 'package:dio/dio.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:path_provider/path_provider.dart';

/// Check if the file is an image (JPG, PNG)
bool isImageFile(String filePath) {
  final ext = extension(filePath).toLowerCase();
  return ['.jpg', '.jpeg', '.png'].contains(ext);
}

/// Compress image to ensure it's <= 2MB
Future<File?> compressImage(File file, {int targetSizeInMB = 2}) async {
  int targetSizeInBytes = targetSizeInMB * 1024 * 1024; // Convert MB to Bytes
  int quality = 100; // Start with max quality

  // If file is already within the limit, return it
  if (file.lengthSync() <= targetSizeInBytes) {
    return file;
  }

  final tempDir = await getTemporaryDirectory();
  File? compressedFile = file;

  while (compressedFile!.lengthSync() > targetSizeInBytes && quality > 10) {
    final targetPath = '${tempDir.path}/compressed_${DateTime.now().millisecondsSinceEpoch}.jpg';

    final result = await FlutterImageCompress.compressWithFile(
      file.absolute.path,
      minWidth: 1080,
      minHeight: 1080,
      quality: quality,
    );

    if (result != null) {
      compressedFile = File(targetPath)..writeAsBytesSync(result);
    }

    quality -= 10; // Reduce quality step-by-step
  }

  return compressedFile;
}

/// Convert any file (PDF, Image, Doc, Excel) to MultipartFile
Future<MultipartFile?> convertFileToMultipart(String filePath) async {
  File file = File(filePath);

  if (!file.existsSync()) {
    print("❌ File not found: $filePath");
    return null;
  }

  File finalFile = file;

  // Compress only images before uploading
  if (isImageFile(filePath)) {
    finalFile = await compressImage(file) ?? file;
  }

  return await MultipartFile.fromFile(
    finalFile.path,
    filename: basename(finalFile.path),
  );
}
