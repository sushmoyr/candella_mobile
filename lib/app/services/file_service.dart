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

  Future<String> uploadImage(
      String fileUrl, Function(double)? uploadProgress) async {
    try {
      File file = File(fileUrl);
      var name = fileUrl.split('/').last;

      MultipartFile f = MultipartFile(file, filename: name);

      FormData formData = FormData({"file": f});

      var res = await post(
        EndPoints.singleImage,
        formData,
        uploadProgress: uploadProgress,
      );

      if (res.hasError) {
        return Future.error('Something Went Wrong');
      } else {
        return res.body['link'];
      }
    } catch (e) {
      return Future.error(e);
    }
  }
}
