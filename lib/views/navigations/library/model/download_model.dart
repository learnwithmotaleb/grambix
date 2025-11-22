import 'dart:io';

class DownloadedItem {
  String id;
  String title;
  String category;
  String? localAudioPath;
  String? localPdfPath;
  String? localImagePath;

  DownloadedItem({
    required this.id,
    required this.title,
    required this.category,
    this.localAudioPath,
    this.localPdfPath,
    this.localImagePath,
  });
}

