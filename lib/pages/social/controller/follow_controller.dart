import 'package:amity_sdk/amity_sdk.dart';
import 'package:get/get.dart';

class FollowController extends GetxController {
  final RxList<AmityFollowRelationship> followRelationships = RxList();

  late PagingController<AmityFollowRelationship> pagingController;
  FollowController() {
    queryFollowers();
  }

  void queryFollowers() {
    print("Qeurrt follower");
    // _followerController = PagingController(
    //   pageFuture: (token) => AmityCoreClient.newUserRepository()
    //       .relationship()
    //       .me()
    //       .getFollowers()
    //       .status(AmityFollowStatusFilter.ALL)
    //       .getPagingData(token: token, limit: 20),
    //   pageSize: 20,
    // )..addListener(
    //     () {
    //       if (_followerController.error == null) {
    //         //handle _followerController, we suggest to clear the previous items
    //         //and add with the latest _controller.loadedItems
    //         _followRelationships.clear();
    //         _followRelationships.addAll(_followerController.loadedItems);
    //         print(_followRelationships);
    //         if (_followRelationships.isNotEmpty) {
    //           print(_followRelationships[0].sourceUser);
    //           print(_followRelationships[0].targetUser);
    //           print(_followRelationships[0].status);
    //         }
    //         //update widgets
    //       } else {
    //         print("error in follow controller");
    //       }
    //     },
    //   );
    pagingController = PagingController(pageFuture: ((token) {
      print(token);
      return AmityCoreClient.getCurrentUser()
          .relationship()
          .getFollowers()
          .status(AmityFollowStatusFilter.ALL)
          .getPagingData(token: token, limit: 20);
    }));
    pagingController.addListener(() {
      print("Data fetching...");
      if (pagingController.error == null) {
        followRelationships.clear();
        followRelationships.addAll(pagingController.loadedItems);
      }
    });

    pagingController.fetchNextPage();
  }
}
