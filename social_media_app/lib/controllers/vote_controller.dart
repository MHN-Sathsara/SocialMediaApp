import 'package:get/get.dart';

class VoteController extends GetxController {
  var upvoteCount = 0.obs;
  var downvoteCount = 0.obs;

  void upvote() {
    upvoteCount++;
  }

  void downvote() {
    downvoteCount++;
  }
}
