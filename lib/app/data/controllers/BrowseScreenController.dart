import 'package:candella/app/data/models/content.dart';
import 'package:candella/app/resources/constants/typedefs.dart';
import 'package:candella/app/services/content_service.dart';
import 'package:get/get.dart';

class BrowseScreenController extends GetxController {
  final ContentService _contentService;
  final String name = 'Browse';

  BrowseScreenController(this._contentService);

  final Rx<List<Content>> storyData = Rx(<Content>[]);
  final Rx<List<Content>> novelData = Rx(<Content>[]);
  final Rx<List<Content>> poemData = Rx(<Content>[]);
  final Rx<List<Content>> comicData = Rx(<Content>[]);
  final Rx<List<Content>> journalData = Rx(<Content>[]);
  final Rx<List<Content>> photographData = Rx(<Content>[]);

  @override
  void onInit() {
    _loadStoryData();
    _loadNovelData();
    _loadPoemData();
    _loadComicData();
    _loadJournalData();
    _loadPhotographData();
    super.onInit();
  }

  void _loadStoryData() {
    _contentService.getPostByCategory(Category.story.id).then((value) {
      if (!value.hasError) {
        storyData(value.body ?? <Content>[]);
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

  void _loadNovelData() {
    _contentService.getPostByCategory(Category.novel.id).then((value) {
      if (!value.hasError) {
        novelData(value.body ?? <Content>[]);
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

  void _loadPoemData() {
    _contentService.getPostByCategory(Category.poem.id).then((value) {
      if (!value.hasError) {
        poemData(value.body ?? <Content>[]);
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

  void _loadComicData() {
    _contentService.getPostByCategory(Category.comic.id).then((value) {
      if (!value.hasError) {
        comicData(value.body ?? <Content>[]);
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

  void _loadJournalData() {
    _contentService.getPostByCategory(Category.journal.id).then((value) {
      if (!value.hasError) {
        journalData(value.body ?? <Content>[]);
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

  void _loadPhotographData() {
    _contentService.getPostByCategory(Category.photography.id).then((value) {
      if (!value.hasError) {
        photographData(value.body ?? <Content>[]);
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
}
