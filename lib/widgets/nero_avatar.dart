import 'package:flutter/material.dart';

enum UserStatus { offline, online }
enum StoryStatus { on, off }

class NeroAvatar extends StatelessWidget {
  final String name;
  final ImageProvider? image;
  final UserStatus? userStatus;
  final StoryStatus? storyStatus;
  final double? radius;

  const NeroAvatar({
    Key? key,
    required this.name,
    this.image,
    this.userStatus,
    this.storyStatus,
    this.radius = 56,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: AlignmentDirectional.center,
      children: [
        Container(
          height: radius,
          width: radius,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(18 * radius! / 56),
            border: storyStatus == StoryStatus.on
                ? Border.all(
                    width: 2 * radius! / 56,
                    color: const Color(0xFF879FFF),
                  )
                : null,
          ),
        ),
        Container(
          height: radius! * 48 / 56,
          width: radius! * 48 / 56,
          decoration: BoxDecoration(
            color: const Color(0xFF166FF6),
            borderRadius: BorderRadius.circular(16 * radius! / 56),
            image: image != null
                ? DecorationImage(
                    image: image!,
                  )
                : null,
          ),
          child: image == null
              ? Center(
                  child: Text(
                    name.initial,
                    style: Theme.of(context).textTheme.subtitle2!.copyWith(
                          fontWeight: FontWeight.w500,
                          color: Colors.white,
                        ),
                  ),
                )
              : null,
        ),
        if (userStatus == UserStatus.online)
          Positioned(
            top: 0,
            right: 0,
            child: Container(
              height: 14 * radius! / 56,
              width: 14 * radius! / 56,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(18),
                border: Border.all(
                  width: 2,
                  color: Colors.white,
                ),
                color: const Color(0xFF2CC069),
              ),
            ),
          ),
      ],
    );
  }
}

extension FormatText on String {
  String get initial {
    List<String> names = split(" ");
    String initials = "";
    int numWords = 2;

    if (numWords < names.length) {
      numWords = names.length;
    }
    for (var i = 0; i < numWords; i++) {
      initials += names[i][0];
    }
    return initials;
  }
}
