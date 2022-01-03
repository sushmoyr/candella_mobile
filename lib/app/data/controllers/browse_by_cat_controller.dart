import 'package:candella/app/data/models/content.dart';
import 'package:candella/app/resources/constants/typedefs.dart';
import 'package:candella/app/services/content_service.dart';
import 'package:get/get.dart';

class BrowseByCatController extends GetxController {
  final ContentService contentService;
  Category currentCategory = Get.arguments;

  BrowseByCatController({
    required this.contentService,
  });

  Rx<List<Content>> contentData = Rx(<Content>[]);
  int currentPage = 1;
  final hasData = true.obs;
  final RxString message = RxString('');

  @override
  void onInit() {
    initData();
    super.onInit();
  }

  void initData() {
    contentService.getPostByCategory(currentCategory.id).then((value) {
      if (!value.hasError) {
        contentData(value.body ?? <Content>[]);
        message(value.body!.length.toString());
      }

      printInfo(
        info: List.from(
          value.body!.map(
            (e) => e.toRawJson(),
          ),
        ).toString(),
      );
    });
  }

  void loadMore() async {
    var response = await contentService.getPostByCategory(currentCategory.id,
        page: currentPage + 1);

    if (!response.hasError) {
      var data = response.body;
      List.from(data!.map((e) => e.title)).printInfo();
      if (data.isNotEmpty) {
        var currentItems = contentData.value;
        currentItems.addAll(data);
        contentData(currentItems);
        contentData.refresh();
        message(contentData.value.length.toString());
        currentPage++;
      } else {
        hasData(false);
      }
    }
  }
}
