import 'package:fluter_1/layouts/discovery/discovery.dart';
import 'package:fluter_1/layouts/home/viewmodel.dart';
import 'package:fluter_1/layouts/now_playing/playing.dart';
import 'package:fluter_1/layouts/settings/settings.dart';
import 'package:fluter_1/layouts/users/user.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluter_1/data/model/song.dart';

// class MusicApp extends StatelessWidget {
//   const MusicApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'MusicApp',
//       theme: ThemeData(
//           colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
//           useMaterial3: true),
//       home: const MusicHomePage(),
//     );
//   }
//   // @override
//   // Widget build(BuildContext context) {
//   //   return const Placeholder();
//   // }
// }

class MusicHomePage extends StatefulWidget {
  const MusicHomePage({super.key});

  @override
  State<MusicHomePage> createState() => _MusicHomePageState();
}

class _MusicHomePageState extends State<MusicHomePage> {
  final List<Widget> _tabs = [
    const HomeTab(),
    const DiscoveryTab(),
    const AccountTab(),
    const SettingsTab()
  ];

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(
        middle: Text('Music App'),
        border: null,
      ),
      child: CupertinoTabScaffold(
          tabBar: CupertinoTabBar(
            // backgroundColor: Theme.of(context).colorScheme.onInverseSurface,
            backgroundColor: const Color.fromARGB(255, 212, 209, 209),
            activeColor: Colors.deepPurple,
            // inactiveColor: Colors.grey,
            items: const [
              BottomNavigationBarItem(
                  icon: Icon(CupertinoIcons.home), label: 'Home'),
              BottomNavigationBarItem(
                  icon: Icon(CupertinoIcons.archivebox_fill),
                  label: 'Discovery'),
              BottomNavigationBarItem(
                  icon: Icon(CupertinoIcons.person), label: 'Account'),
              BottomNavigationBarItem(
                  icon: Icon(CupertinoIcons.settings), label: 'Settings'),
            ],
          ),
          tabBuilder: (BuildContext context, int index) {
            return CupertinoTabView(
              builder: (context) {
                return CupertinoPageScaffold(
                  child: _tabs[index],
                );
              },
            );
          }),
    );
  }
}

class HomeTab extends StatelessWidget {
  const HomeTab({super.key});

  @override
  Widget build(BuildContext context) {
    return const HomeTabPage();
  }
}

class HomeTabPage extends StatefulWidget {
  const HomeTabPage({super.key});

  @override
  State<HomeTabPage> createState() => _HomeTabPageState();
}

class _HomeTabPageState extends State<HomeTabPage> {
  List<Song> songs = [];
  late MusicAppViewModel _viewModel;

  @override
  void initState() {
    super.initState();
    _viewModel = MusicAppViewModel();
    observeData();
    _viewModel.loadSong();
  }

  @override
  void dispose() {
    _viewModel.songStream.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: getBody(),
    );
  }

  Widget getBody() {
    bool showEmptyMessage = songs.isEmpty;
    // bool showLoading = songs.isEmpty;
    if (showEmptyMessage) {
      // return getProgressBar();
      return const Center(
        child: Text('No Data or No Internet'),
      );
    } else {
      return getListView();
    }
  }

  Widget getProgressBar() {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }

  Widget getListView() {
    return ListView.separated(
      itemBuilder: (context, position) {
        return getRow(position);
      },
      separatorBuilder: (context, index) {
        return const Divider(
          color: Colors.grey,
          thickness: 1,
          indent: 24,
          endIndent: 24,
        );
      },
      itemCount: songs.length,
      shrinkWrap: true,
    );
  }

  Widget getRow(int index) {
    // return Text(songs[index].title);
    return _SongItemSection(
      parent: this,
      song: songs[index],
    );
    // return ListTile(
    //   title:
    //       Text(songs[index].title.isNotEmpty ? songs[index].title : 'No Title'),
    // );
  }

  void observeData() {
    _viewModel.songStream.stream.listen((songList) {
      setState(() {
        // songs.addAll(songList);
        songs = songList;
      });
    });
  }

  void showBottomSheet() {}

  void navigate(Song song) {
    Navigator.push(context, CupertinoPageRoute(builder: (context) {
      return NowPlaying(
        songs: songs,
        playingSong: song,
      );
    }));
  }
}

class _SongItemSection extends StatelessWidget {
  _SongItemSection({
    required this.parent,
    required this.song,
  });

  final _HomeTabPageState parent;
  final Song song;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: const EdgeInsets.only(left: 24, right: 24),
      leading: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: FadeInImage.assetNetwork(
            placeholder: 'assets/icon/iconApp.png',
            image: song.image,
            width: 48,
            height: 48,
            imageErrorBuilder: (context, error, stackTrace) {
              return Image.asset('assets/icon/iconApp.png',
                  width: 48, height: 48);
            }),
      ),
      title: Text(song.title),
      subtitle: Text(song.artist),
      trailing: IconButton(
        icon: const Icon(CupertinoIcons.chevron_down),
        onPressed: () {
          parent.showBottomSheet();
        },
      ),
      onTap: () {
        parent.navigate(song);
      },
    );
  }
}
