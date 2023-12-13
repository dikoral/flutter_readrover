import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_readrover/Presentation/Constanta/Colors/Colors.dart';
import 'package:flutter_readrover/Presentation/Constanta/Colors/button.dart';
import 'package:flutter_readrover/generated/locale_keys.g.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class Stories extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => StoriesProvider(),
      child: MaterialApp(
        theme: ThemeData(
          primarySwatch: Colors.purple,
        ),
        home: StoriesPage(),
      ),
    );
  }
}

class StoriesProvider extends ChangeNotifier {
  List<String> _stories = [];

  List<String> get stories => _stories;

  void addStory(String story) {
    _stories.add(story);
    notifyListeners();
  }
}

class StoriesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final storiesProvider = Provider.of<StoriesProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(LocaleKeys.Stories.tr()),
        actions: [
            LanguageSwitchButton(),
          ],
      ),
      body: ListView.builder(
        itemCount: storiesProvider.stories.length,
        itemBuilder: (context, index) {
          return StoryItem(index: index, imageUrl: storiesProvider.stories[index]);
        },
      ),
      floatingActionButton: FloatingActionButton(
       onPressed: () async {
       final ImagePicker _picker = ImagePicker();
       final XFile? pickedFile = await _picker.pickImage(source: ImageSource.gallery);
       if (pickedFile != null) {
        storiesProvider.addStory(pickedFile.path);
       }
      },
       child: Icon(Icons.add),
      ),
    backgroundColor: MyColors.Consttwo,   
    );
  }
}

class StoryItem extends StatelessWidget {
  final int index;
  final String imageUrl;

  StoryItem({required this.index, required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: CircleAvatar(
          backgroundImage: NetworkImage(imageUrl), 
        ),
        title: Text('История $index'),
        subtitle: Text(LocaleKeys.short_description.tr()),
        onTap: () => _showStory(context, index, imageUrl),
      ),
    );
  }

  void _showStory(BuildContext context, int index, String imageUrl) {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => StoryViewer(index: index, imageUrl: imageUrl),
    ));
  }
}

class StoryViewer extends StatefulWidget {
  final int index;
  final String imageUrl;

  StoryViewer({required this.index, required this.imageUrl});

  @override
  _StoryViewerState createState() => _StoryViewerState();
}

class _StoryViewerState extends State<StoryViewer> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 5), () {
      if (mounted) {
        Navigator.of(context).pop();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('История ${widget.index}'),
      ),
      body: Center(
        child: Image.network(widget.imageUrl), 
      ),
    );
  }
}