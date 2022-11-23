import 'package:amity_sdk/amity_sdk.dart';
import 'package:dogs_park/pages/login_page/controller/user_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../utils/model/amity_channel_model.dart';
import '../utils/model/amity_message_model.dart';
import '../utils/repository/chat_repo_imp.dart';

class MessageController extends GetxController {
  //asd
  bool _initialized = false;
  RxInt amityMessageLength = (-1).obs;
  TextEditingController textEditingController = TextEditingController();
  List<AmityUser> channelUsers = [];
  ScrollController? scrollController =
      ScrollController(keepScrollOffset: false);
  AmityChatRepoImp channelRepoImp = AmityChatRepoImp();

  List<Messages>? amityMessageList;
  bool isChatLoading = true;
  late String channelId;
  bool ispaginationLoading = false;

  static MessageController? _instance;

  static MessageController getController() {
    _instance ??= MessageController();

    return _instance!;
  }

  AmityUser? getUserByID(String userId) {
    for (int i = 0; i < channelUsers.length; i++) {
      if (channelUsers[i].userId == userId) {
        return channelUsers[i];
      }
    }
  }

  ///init
  Future<void> intialize(String channelId, Channels channel) async {
    print("Initial Message controller");
    this.channelId = channelId;
    isChatLoading = true;
    amityMessageList = [];
    amityMessageLength.value = -1;

    var accessToken = UserController.getInstance().accessToken;

    await channelRepoImp.initRepo(accessToken);
    await channelRepoImp.fetchUsersByChannelId(
        channelId: channelId,
        setDataFn: (userList) {
          print("User list get: " + userList.length.toString());
          channelUsers.clear();
          channelUsers.addAll(userList);
          print("New channel users length: " + channelUsers.length.toString());
        });

    await channelRepoImp.listenToChannel((messages) async {
      // log(messages.messages![0].channelId.toString());
      // log(channelId);
      if (messages.messages?[0].channelId == channelId) {
        print("get new messgae...: ${messages.messages?[0].data?.text}");
        print("New message come");
        amityMessageList?.add(messages.messages!.first);
        amityMessageLength.value = amityMessageList!.length;
        channel.messageCount = channel.messageCount! + 1;
        channel.setUnreadCount(channel.unreadCount - 1);
        if (messages.messages?[0].userId ==
            AmityCoreClient.getCurrentUser().userId) {
          scrollToBottom();
        }
      }

      // notifyListeners();
    });

    // channelRepoImp.fetchUsersByChannelId(
    //     channelId: channelId, callback: (data, error) {});

    _initialized = true;
    channelRepoImp.fetchChannelById(
        channelId: channelId,
        callback: (data, error) async {
          if (error == null) {
            // notifyListeners();

            scrollController?.addListener(() async {
              if (!ispaginationLoading) {
                var currentMessageCount = amityMessageList!.length;
                var totalMessageCount = channel.messageCount!;

                if ((scrollController!.position.pixels ==
                        (scrollController!.position.maxScrollExtent)) &&
                    (currentMessageCount < totalMessageCount)) {
                  ispaginationLoading = true;

                  // log("ispaginationLoading = false");
                  var token = data!.paging!.previous;

                  // log("minScrollExtent");
                  await channelRepoImp.fetchChannelById(
                    channelId: channelId,
                    paginationToken: token,
                    callback: (pagingData, error) async {
                      if (error == null) {
                        // log("paging data: $pagingData");

                        if (pagingData!.paging!.previous == null) {
                          scrollController!.removeListener(() {
                            removeListener(() {
                              // log("remove listener");
                            });
                          });
                        } else {
                          data.paging!.previous = pagingData.paging!.previous;
                        }

                        var reversedMessage = pagingData.messages!.reversed;
                        for (var message in reversedMessage) {
                          // log(message.data!.text.toString());
                          amityMessageList?.insert(0, message);
                        }
                        // notifyListeners();
                        ispaginationLoading = false;
                      } else {
                        ispaginationLoading = false;
                        // log(error);
                        // await AmityDialog().showAlertErrorDialog(
                        // title: "Error!", message: error);
                      }
                    },
                  );
                } else {
                  // log("pagination is not ready: $currentMessageCount/$totalMessageCount");
                }
              }
            });

            // log("success");
            amityMessageList?.clear();
            for (var message in data!.messages!) {
              amityMessageList?.add(message);
            }
            amityMessageLength.value = amityMessageList!.length;
            print("Message receive: " + amityMessageLength.value.toString());
            scrollToBottom();

            channelRepoImp.startReading(
              channelId,
              callback: (data, error) {
                if (error == null) {
                  // log("set unread count = 0");
                  // Provider.of<ChannelVM>(
                  // NavigationService.navigatorKey.currentContext!,
                  // listen: false)
                  // .removeUnreadCount(channelId);
                }
              },
            );

            // notifyListeners();
          } else {
            print("Error get messages");
            // log(error);
            // await AmityDialog()
            // .showAlertErrorDialog(title: "Error!", message: error);
          }
        });
  }

  Future<void> sendMessage() async {
    String text = textEditingController.text;
    textEditingController.clear();
    print("Message send: " + text);
    channelRepoImp.sendTextMessage(channelId, text, (data, error) async {
      if (data != null) {
        // log("sendMessage: success");
      } else {
        // log(error.toString());
        // await AmityDialog()
        //     .showAlertErrorDialog(title: "Error!", message: error!);
      }
    });
  }

  void scrollToBottom() {
    // log("scrollToBottom ");
    // scrollController!.animateTo(
    //   1000000,
    //   curve: Curves.easeOut,
    //   duration: const Duration(milliseconds: 500),
    // );
    scrollController?.jumpTo(0);
  }

  @override
  Future<void> dispose() async {
    await channelRepoImp.stopReading(channelId);

    channelRepoImp.disposeRepo();
    scrollController = null;
    amityMessageList?.clear();
    super.dispose();
  }
}
