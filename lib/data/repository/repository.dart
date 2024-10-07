import 'package:fluter_1/data/model/song.dart';
import 'package:fluter_1/data/source/source.dart';

abstract interface class Repository {
  Future<List<Song>?> loadData();
}

class DefaultRepository implements Repository {
  final _localDataSource = LocalDataSource();
  final _remoteDataSource = RemoteDataSource();

  @override
  Future<List<Song>?> loadData() async {
    List<Song> songs = [];
    await _remoteDataSource.loadData().then((remoteSongs) {
      if (remoteSongs == null) {
        _localDataSource.loadData().then((localSongs) {
          if (localSongs != null) {
            songs.addAll(localSongs);
          }
        });
      } else {
        songs.addAll(remoteSongs);
      }
    });
    return songs;
  }
}
