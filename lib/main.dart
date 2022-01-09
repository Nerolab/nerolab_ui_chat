import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart';
import 'package:flutter_link_previewer/flutter_link_previewer.dart';

import 'package:nerolab_ui_chat/widgets/nero_avatar.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Nerolab UI Chat',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Nerolab UI Chat'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Map<String, PreviewData> datas = {};

  List<String> get urls => const [
        'https://flutter.dev/',
        'https://media.neliti.com/media/publications/249244-none-837c3dfb.pdf',
        'https://medium.com/',
        'github.com/flyerhq',
        'https://medium.com/',
      ];

  @override
  Widget build(BuildContext context) {
    const imageUrl = 'https://randomuser.me/api/portraits/women/60.jpg';

    return Scaffold(
      backgroundColor: const Color(0xFFF7F7FC),
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Text(
              'Avatar',
              style: Theme.of(context).textTheme.headline5,
            ),
          ),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            alignment: WrapAlignment.start,
            children: const [
              NeroAvatar(
                radius: 56,
                name: 'Yin Min',
                image: NetworkImage(imageUrl),
                userStatus: UserStatus.online,
                storyStatus: StoryStatus.on,
              ),
              NeroAvatar(
                radius: 56,
                name: 'Yin Min',
                image: NetworkImage(imageUrl),
                userStatus: UserStatus.online,
                storyStatus: StoryStatus.off,
              ),
              NeroAvatar(
                radius: 56,
                name: 'Yin Min',
                image: NetworkImage(imageUrl),
                userStatus: UserStatus.offline,
                storyStatus: StoryStatus.off,
              ),
            ],
          ),
          const SizedBox(height: 8),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            alignment: WrapAlignment.start,
            children: const [
              NeroAvatar(
                radius: 56,
                name: 'Yin Min',
                userStatus: UserStatus.online,
                storyStatus: StoryStatus.on,
              ),
              NeroAvatar(
                radius: 56,
                name: 'Yin Min',
                userStatus: UserStatus.online,
                storyStatus: StoryStatus.off,
              ),
              NeroAvatar(
                radius: 56,
                name: 'Yin Min',
                userStatus: UserStatus.offline,
                storyStatus: StoryStatus.off,
              ),
            ],
          ),
          const SizedBox(height: 8),
          const NeroChatBubble(
            name: 'Devo Mizuhara',
            message: 'But don’t worry cause we are all learning here',
            time: '16.46',
            userType: UserType.sender,
            isRead: true,
          ),
          const NeroChatBubble(
            name: 'Devo Mizuhara',
            message: 'But don’t worry cause we are all learning here',
            time: '16.46',
            userType: UserType.reciever,
            isRead: true,
          ),
          NeroChatBubble(
            name: 'Devo Mizuhara',
            message: 'But don’t worry cause we are all learning here',
            reply: ReplyMessage(
                author: 'Devo Mizuhara',
                message: 'But don’t worry cause we are all learning here'),
            time: '16.46',
            userType: UserType.reciever,
            isRead: true,
          ),
          NeroChatBubble(
            name: 'Devo Mizuhara',
            message: 'But don’t worry cause we are all learning here',
            reply: ReplyMessage(
                author: 'Devo Mizuhara',
                message: 'But don’t worry cause we are all learning here'),
            time: '16.46',
            userType: UserType.sender,
            isRead: true,
          ),
          const NeroChatBubble(
            name: 'Devo Mizuhara',
            time: '16.46',
            userType: UserType.sender,
            attachment: 'Brand Academy Slide Deck.pptx',
            isRead: true,
          ),
          const NeroChatBubble(
            name: 'Devo Mizuhara',
            time: '16.46',
            userType: UserType.reciever,
            attachment: 'Brand Academy Slide Deck.pptx',
            isRead: true,
          ),
          LinkPreview(
            enableAnimation: true,
            onPreviewDataFetched: (data) {
              setState(() {
                datas = {...datas, urls[0]: data};
              });
            },
            text: urls[0],
            width: MediaQuery.of(context).size.width,
            previewData: datas[urls[0]],
          )
        ],
      ),
    );
  }
}

enum UserType { sender, reciever }

class ReplyMessage {
  final String author;
  final String message;

  ReplyMessage({
    required this.author,
    required this.message,
  });
}

class NeroChatBubble extends StatelessWidget {
  const NeroChatBubble({
    Key? key,
    required this.name,
    this.message,
    required this.time,
    required this.userType,
    required this.isRead,
    this.reply,
    this.attachment,
  }) : super(key: key);

  final String name;
  final String? message;
  final String time;
  final UserType userType;
  final bool isRead;
  final ReplyMessage? reply;
  final String? attachment;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: userType == UserType.sender
          ? Alignment.centerLeft
          : Alignment.centerRight,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: const EdgeInsets.symmetric(vertical: 6),
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: userType == UserType.sender
                  ? Colors.white
                  : const Color(0xFF002DE3),
              borderRadius: BorderRadiusDirectional.only(
                topStart: const Radius.circular(16),
                topEnd: const Radius.circular(16),
                bottomStart: userType == UserType.sender
                    ? Radius.zero
                    : const Radius.circular(16),
                bottomEnd: userType == UserType.reciever
                    ? Radius.zero
                    : const Radius.circular(16),
              ),
            ),
            child: Column(
              crossAxisAlignment: userType == UserType.sender
                  ? CrossAxisAlignment.start
                  : CrossAxisAlignment.end,
              children: [
                if (userType == UserType.sender) _buildName(context),
                if (attachment != null)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 6),
                    child: Material(
                      color: userType == UserType.reciever
                          ? Colors.white.withOpacity(0.3)
                          : const Color(0xFFEDEDED),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: InkWell(
                        onTap: () => print('object'),
                        child: Padding(
                          padding: const EdgeInsets.all(16),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                CupertinoIcons.doc_text,
                                size: 16,
                                color: userType == UserType.reciever
                                    ? Colors.white
                                    : const Color(0xFF0F1828),
                              ),
                              const SizedBox(width: 4),
                              Flexible(
                                child: Text(
                                  attachment ?? '',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyText2!
                                      .copyWith(
                                        color: userType == UserType.reciever
                                            ? Colors.white
                                            : const Color(0xFF0F1828),
                                      ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                if (reply != null)
                  NeroChatReply(
                    author: 'Devo Mizuhara',
                    message: 'But don’t worry cause we are all learning here',
                    userType: userType,
                  ),
                if (message != null) _buildMessage(context),
                Row(
                  mainAxisAlignment: userType == UserType.sender
                      ? MainAxisAlignment.start
                      : MainAxisAlignment.end,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      time,
                      style: Theme.of(context).textTheme.caption!.copyWith(
                            color: userType == UserType.reciever
                                ? Colors.white
                                : const Color(0xFFADB5BD),
                          ),
                    ),
                    if (userType == UserType.reciever && !isRead)
                      Text(
                        ' · Read',
                        style: Theme.of(context).textTheme.caption!.copyWith(
                              color: userType == UserType.reciever
                                  ? Colors.white
                                  : const Color(0xFFADB5BD),
                            ),
                      ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMessage(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 6, bottom: 6),
      child: Text(
        message ?? '',
        style: Theme.of(context).textTheme.bodyText2!.copyWith(
              color: userType == UserType.reciever
                  ? Colors.white
                  : const Color(0xFF0F1828),
            ),
      ),
    );
  }

  Widget _buildName(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Text(
        name,
        style: Theme.of(context).textTheme.caption!.copyWith(
              color: userType == UserType.reciever
                  ? Colors.white
                  : const Color(0xFF001A83),
              fontWeight: FontWeight.w600,
            ),
      ),
    );
  }
}

class NeroChatReply extends StatelessWidget {
  const NeroChatReply({
    Key? key,
    required this.author,
    required this.message,
    required this.userType,
  }) : super(key: key);

  final String author;
  final String message;
  final UserType userType;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: userType == UserType.reciever
            ? Colors.white.withOpacity(0.3)
            : const Color(0xFFEDEDED),
        borderRadius: BorderRadius.circular(4),
      ),
      child: IntrinsicHeight(
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 4,
              decoration: BoxDecoration(
                color: userType == UserType.reciever
                    ? Colors.white
                    : const Color(0xFF002DE3),
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(4),
                  bottomLeft: Radius.circular(4),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildName(context),
                  const SizedBox(height: 4),
                  _buildMessage(context),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMessage(BuildContext context) {
    return Text(
      message,
      style: Theme.of(context).textTheme.bodyText2!.copyWith(
            color: userType == UserType.reciever
                ? Colors.white
                : const Color(0xFF0F1828),
          ),
    );
  }

  Widget _buildName(BuildContext context) {
    return Text(
      author,
      style: Theme.of(context).textTheme.caption!.copyWith(
            color: userType == UserType.reciever
                ? Colors.white
                : const Color(0xFF001A83),
            fontWeight: FontWeight.w600,
          ),
    );
  }
}
