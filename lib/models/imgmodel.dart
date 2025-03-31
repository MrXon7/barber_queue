class ImageModel {
  final String? imageUrl;
  final String? deleteUrl;

  ImageModel({this.imageUrl, this.deleteUrl});

  factory ImageModel.fromJson(Map<String, dynamic> json) {
    return ImageModel(
      imageUrl: json['data']['url']??'',
      deleteUrl: json['data']['delete_url']??'',
    );
  }

  
  Map<String, dynamic> toJson() {
    return {
      'url': imageUrl,
      'delete_url': deleteUrl,
    };
  }
}
