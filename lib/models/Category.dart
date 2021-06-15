import 'package:ecom/models/Model.dart';

class Category extends Model {
  static const String BANNER_URL_KEY = "bannerUrl";

  static const String CAT_NAME_KEY = "catName";
  static const String STATUS_KEY = "status";

  String bannerUrl;

  String catName;
  String status;

  Category(String id, {this.catName, this.bannerUrl, this.status}) : super(id);

  factory Category.fromMap(Map<String, dynamic> map, {String id}) {
    return Category(id,
        bannerUrl: map[BANNER_URL_KEY],
        catName: map[CAT_NAME_KEY],
        status: map[STATUS_KEY]);
  }

  @override
  Map<String, dynamic> toMap() {
    final map = <String, dynamic>{
      BANNER_URL_KEY: bannerUrl,
      CAT_NAME_KEY: catName,
      STATUS_KEY: status
    };

    return map;
  }

  @override
  Map<String, dynamic> toUpdateMap() {
    final map = <String, dynamic>{};

    if (bannerUrl != null) map[BANNER_URL_KEY] = bannerUrl;
    if (catName != null) map[CAT_NAME_KEY] = catName;
    if (status != null) map[STATUS_KEY] = status;

    return map;
  }
}
