import 'package:flutter/material.dart';
import 'package:story_view/story_view.dart';
import '../../../../../shared/widgets/loader.dart';
import 'package:chatty/models/status_model.dart';


class StatusSC extends StatefulWidget {
   StatusSC({required this.status});
  final Status status;

  @override
  State<StatusSC> createState() => _StatusSCState();
}

class _StatusSCState extends State<StatusSC> {
  StoryController controller = StoryController();

  List<StoryItem> storyItems = [];

  @override
  void initState() {
    super.initState();
    initStoryPageItems();
  }

  void initStoryPageItems() {
    for (int i = 0; i < widget.status.photoUrl.length; i++) {
      storyItems.add(StoryItem.pageImage(
        url: widget.status.photoUrl[i],
        controller: controller,
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: storyItems.isEmpty
          ? const Loader()
          : StoryView(
        storyItems: storyItems,
        controller: controller,
        onVerticalSwipeComplete: (direction) {
          if (direction == Direction.down) {
            Navigator.pop(context);
          }
        },
      ),
    );
  }
}
