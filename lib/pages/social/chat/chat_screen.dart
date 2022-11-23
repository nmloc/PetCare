import 'package:amity_sdk/amity_sdk.dart';
import 'package:animation_wrappers/animation_wrappers.dart';
import 'package:dogs_park/pages/social/chat/chats_page.dart';
import 'package:dogs_park/pages/social/controller/message_controller.dart';
import 'package:dogs_park/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../components/custom_user_avatar.dart';
import '../utils/model/amity_channel_model.dart';
import '../utils/model/amity_message_model.dart';

class ChatSingleScreen extends StatelessWidget {
  final Channels channel;

  const ChatSingleScreen({Key? key, required this.channel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final mediaQuery = MediaQuery.of(context);

    final myAppBar = AppBar(
      elevation: 0,
      backgroundColor: AppColors.white,
      leadingWidth: 0,
      bottom:
          PreferredSize(preferredSize: Size.fromHeight(1), child: Divider()),
      title: Container(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            BackButton(
              color: Colors.black,
              onPressed: () {
                Get.back();
              },
            ),
            Container(
              height: 45,
              margin: const EdgeInsets.symmetric(vertical: 4),
              decoration: const BoxDecoration(shape: BoxShape.circle),
              child: FadedScaleAnimation(
                child: getAvatarImage(null, fileId: channel.avatarFileId),
              ),
            ),
            SizedBox(width: 10),
            Expanded(
              child: Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      channel.displayName ?? "N/A",
                      overflow: TextOverflow.ellipsis,
                      style: theme.textTheme.headline6!.copyWith(
                        fontSize: 16.7,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    (channel.memberCount! > 2)
                        ? Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              const Icon(
                                Icons.person_outline,
                                color: Color(0xFFC9C9C9),
                                size: 12,
                              ),
                              Text(
                                '${channel.memberCount} members',
                                style: const TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                  color: Color(0xFFC9C9C9),
                                ),
                              ),
                            ],
                          )
                        : const SizedBox(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
    final bHeight = mediaQuery.size.height -
        mediaQuery.padding.top -
        myAppBar.preferredSize.height;

    final textfielHeight = 60.0;
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: myAppBar,
      body: SafeArea(
        child: Stack(
          children: [
            FadedSlideAnimation(
              beginOffset: Offset(0, 0.3),
              endOffset: Offset(0, 0),
              slideCurve: Curves.linearToEaseOut,
              child: SingleChildScrollView(
                reverse: true,
                controller: MessageController.getController().scrollController,
                child: MessageComponent(
                  bheight: bHeight - textfielHeight,
                  theme: theme,
                  mediaQuery: mediaQuery,
                  channelId: channel.channelId!,
                  channel: channel,
                ),
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ChatTextFieldComponent(
                    theme: theme,
                    textfielHeight: textfielHeight,
                    mediaQuery: mediaQuery),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class ChatTextFieldComponent extends StatelessWidget {
  const ChatTextFieldComponent({
    Key? key,
    required this.theme,
    required this.textfielHeight,
    required this.mediaQuery,
  }) : super(key: key);

  final ThemeData theme;
  final double textfielHeight;
  final MediaQueryData mediaQuery;

  @override
  Widget build(BuildContext context) {
    var messageController = MessageController.getController();
    return Container(
      decoration: BoxDecoration(
          color: Color(0xFFEFEFEF),
          border: Border(top: BorderSide(color: theme.highlightColor))),
      height: textfielHeight,
      width: mediaQuery.size.width,
      padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
      child: Row(
        children: [
          // SizedBox(
          //   width: 5,
          // ),
          // Icon(
          //   Icons.emoji_emotions_outlined,
          //   color: theme.primaryIconTheme.color,
          //   size: 22,
          // ),
          SizedBox(width: 10),
          Container(
            width: mediaQuery.size.width * 0.7,
            child: TextField(
              controller:
                  MessageController.getController().textEditingController,
              decoration: const InputDecoration(
                hintText: 'Write your messsage',
                hintStyle: TextStyle(
                    fontSize: 14,
                    color: Color(0xFFBDBDBD),
                    fontWeight: FontWeight.w400),
                border: InputBorder.none,
              ),
              style: const TextStyle(
                  fontSize: 14,
                  color: Colors.black,
                  fontWeight: FontWeight.w400),
            ),
          ),
          Spacer(),
          GestureDetector(
            onTap: () {
              messageController.sendMessage();
            },
            child: Icon(
              Icons.send,
              color: theme.primaryColor,
              size: 22,
            ),
          ),
          SizedBox(
            width: 5,
          ),
        ],
      ),
    );
  }
}

String getTimeStamp(Messages msg) {
  String hour = "${DateTime.parse(msg.editedAt!).hour.toString()}";
  String minute = "";
  if (DateTime.parse(msg.editedAt!).minute > 9) {
    minute = DateTime.parse(msg.editedAt!).minute.toString();
  } else {
    minute = "0" + DateTime.parse(msg.editedAt!).minute.toString();
  }
  return hour + ":" + minute;
}

class MessageComponent extends StatefulWidget {
  const MessageComponent({
    Key? key,
    required this.theme,
    required this.mediaQuery,
    required this.channelId,
    required this.bheight,
    required this.channel,
  }) : super(key: key);
  final String channelId;
  final Channels channel;

  final ThemeData theme;

  final MediaQueryData mediaQuery;

  final double bheight;

  @override
  State<MessageComponent> createState() => _MessageComponentState();
}

class _MessageComponentState extends State<MessageComponent> {
  MessageController messageController = MessageController.getController();
  @override
  void initState() {
    messageController.intialize(widget.channelId, widget.channel);
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => messageController.amityMessageLength < 0
          ? Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircularProgressIndicator(
                        backgroundColor: widget.theme.highlightColor,
                        color: widget.theme.hintColor,
                      )
                    ],
                  ),
                )
              ],
            )
          : Container(
              padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
              child: ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: messageController.amityMessageLength.value,
                itemBuilder: (context, index) {
                  Messages message = messageController.amityMessageList![index];
                  AmityUser? messageUser =
                      messageController.getUserByID(message.userId!);

                  if (index == messageController.amityMessageLength.value - 1) {
                    print(message);
                  }
                  bool isSendbyCurrentUser =
                      message.userId != AmityCoreClient.getCurrentUser().userId;
                  return Column(
                    crossAxisAlignment: isSendbyCurrentUser
                        ? CrossAxisAlignment.start
                        : CrossAxisAlignment.end,
                    children: [
                      Row(
                        mainAxisAlignment: isSendbyCurrentUser
                            ? MainAxisAlignment.start
                            : MainAxisAlignment.end,
                        children: [
                          if (isSendbyCurrentUser)
                            getAvatarImage((messageUser != null)
                                ? messageUser.avatarUrl
                                : null),
                          messageController
                                      .amityMessageList![index].data!.text ==
                                  null
                              ? Container(
                                  margin: EdgeInsets.fromLTRB(10, 4, 10, 4),
                                  padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: Colors.red),
                                  child: Text("Unsupport type message😰",
                                      style: TextStyle(color: Colors.white)),
                                )
                              : Flexible(
                                  child: Container(
                                    constraints: BoxConstraints(
                                        maxWidth:
                                            widget.mediaQuery.size.width * 0.7),
                                    margin: EdgeInsets.fromLTRB(10, 4, 10, 4),
                                    padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: isSendbyCurrentUser
                                          ? AppColors.amity_lightGrey
                                          : widget.theme.primaryColor,
                                    ),
                                    child: Column(
                                      crossAxisAlignment: isSendbyCurrentUser
                                          ? CrossAxisAlignment.end
                                          : CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          messageController
                                                  .amityMessageList?[index]
                                                  .data!
                                                  .text ??
                                              "N/A",
                                          style: widget
                                              .theme.textTheme.bodyText1!
                                              .copyWith(
                                                  fontSize: 14.7,
                                                  color: isSendbyCurrentUser
                                                      ? AppColors.black
                                                      : AppColors.white),
                                        ),
                                        Container(
                                          child: Text(
                                            getTimeStamp(messageController
                                                .amityMessageList![index]),
                                            style: TextStyle(
                                                color: isSendbyCurrentUser
                                                    ? AppColors
                                                        .amity_lightGrey500
                                                    : Colors.grey.shade200,
                                                fontSize: 8),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                        ],
                      ),
                      if (index + 1 ==
                          messageController.amityMessageList?.length)
                        const SizedBox(
                          height: 90,
                        )
                    ],
                  );

                  // return MessageLine(
                  //   message: messageController.amityMessageList?[index],
                  //   isUserMessage: isSendbyCurrentUser,
                  // );
                },
              ),
            ),
    );
  }
}

class MessageLine extends StatelessWidget {
  Messages? message;
  bool isUserMessage;
  String avatarID;
  MessageLine(
      {Key? key, this.message, this.isUserMessage = true, this.avatarID = ""})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var maxWidthConstraint = MediaQuery.of(context).size.width * .65;
    return Row(
      mainAxisAlignment:
          isUserMessage ? MainAxisAlignment.end : MainAxisAlignment.start,
      children: [
        isUserMessage ? const SizedBox() : getAvatarImage(avatarID),
        Container(
          decoration: BoxDecoration(color: Color(0xFF04CEBC)),
          constraints: BoxConstraints(maxWidth: maxWidthConstraint),
          child: Column(
            crossAxisAlignment: isUserMessage
                ? CrossAxisAlignment.start
                : CrossAxisAlignment.end,
            children: [
              Text(
                message!.data!.text ?? "N/A",
              ),
              Text(
                getTimeStamp(message!),
              ),
            ],
          ),
        )
      ],
    );
  }
}
