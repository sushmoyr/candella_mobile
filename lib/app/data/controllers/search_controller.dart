import 'package:candella/app/data/models/content.dart';
import 'package:candella/app/services/content_service.dart';
import 'package:get/get.dart';

class SearchController extends GetxController {
  final ContentService _service;

  SearchController(this._service);

  final title = 'Search';
  final RxString message = RxString('Search Content');
  Rx<List<Content>> searchResult = Rx(<Content>[]);

  void search(String query) async {
    if (query.isNotEmpty) {
      var response = await _service.searchPost(query);

      if (!response.hasError) {
        var data = response.body;
        if (data != null) {
          if (data.isEmpty) {
            message('No Result Found');
          }
          searchResult(data);
          data.printInfo();
          searchResult.refresh();
        }
      }
    }
  }
}
