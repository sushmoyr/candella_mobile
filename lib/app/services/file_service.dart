import 'dart:io';

import 'package:candella/app/resources/constants/endpoints.dart';
import 'package:get/get.dart';

class FileService extends GetConnect {
  @override
  void onInit() {
    httpClient.baseUrl = EndPoints.baseUrl;
    httpClient.timeout = Duration(seconds: 20);
    super.onInit();
  }

  Future<String> uploadImage(String fileUrl) async {
    File file = File(fileUrl);
    var name = fileUrl.split('/').last;
    print(name);
    MultipartFile f = MultipartFile(file, filename: name);

    FormData formData = FormData({"file": f});

    var res = await post(
      EndPoints.singleImage,
      formData,
      contentType: "multipart/form-data",
      uploadProgress: (percentage) {},
    );
    if (res.hasError) {
      print(res.statusText.toString());
    } else {
      print(res.body);
    }
    return Future.error('error');
  }
}
