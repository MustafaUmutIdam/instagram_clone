import 'package:flutter/material.dart';
import '../../data/models/story.dart';
import '../helpers/responsive_service.dart';

class StoryBar extends StatelessWidget {
  final List<Story> stories;

  const StoryBar({super.key, required this.stories});

  @override
  Widget build(BuildContext context) {
    final resp = ResponsiveService();

    return Container(
      color: Colors.black,
      child: SizedBox(
        height: resp.height(0.15),
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: stories.length,
          itemBuilder: (context, index) {
            final story = stories[index];
            return Padding(
              padding: EdgeInsets.all( resp.width(0.01)),
              child: Column(
                children: [
                  Stack(
                    children: [
                      Container(
                        padding: EdgeInsets.all(story.hasStory ? 3 : 0),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          gradient: story.hasStory
                              ? const LinearGradient(
                            colors: [
                              Color(0xFF9B2282),
                              Color(0xFFEEA863),
                              Color(0xFFFEDA77),
                              Color(0xFFD62976),
                              Color(0xFF962FBF),
                            ],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          )
                              : null,
                        ),
                        child: CircleAvatar(
                          radius: resp.width(0.1),
                          backgroundImage: NetworkImage(story.profileImageUrl),
                        ),
                      ),
                      if (story.isMine)
                        Positioned(
                          bottom: 0,
                          right: 0,
                          child: Container(
                            decoration: const BoxDecoration(
                              color: Colors.blue,
                              shape: BoxShape.circle,
                            ),
                            child: Icon(Icons.add, size: resp.width(0.05), color: Colors.white),
                          ),
                        ),
                    ],
                  ),
                  SizedBox(height: resp.height(0.01)),
                  SizedBox(
                    width: resp.width(0.2),
                    child: Text(
                      story.profileName,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: resp.fontSize(0.04),
                      ),
                    ),
                  )
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
