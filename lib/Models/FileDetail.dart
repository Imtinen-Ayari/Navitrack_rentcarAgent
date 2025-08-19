class FileDetail {
  String id;
  String fileName;
  String fileDownloadUri;
  String fileType;
  int size;

  FileDetail({
    required this.id,
    required this.fileName,
    required this.fileDownloadUri,
    required this.fileType,
    required this.size,
  });

  factory FileDetail.fromJson(Map<String, dynamic> json) {
    return FileDetail(
      id: json['id'],
      fileName: json['fileName'],
      fileDownloadUri: json['fileDownloadUri'],
      fileType: json['fileType'],
      size: json['size'],
    );
  }
}