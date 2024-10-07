import 'package:fluter_1/data/repository/repository.dart';
import 'package:fluter_1/layouts/home/home.dart';
import 'package:fluter_1/data/source/source.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MusicApp());
}

class MusicApp extends StatelessWidget {
  const MusicApp({super.key});

  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MusicApp',
      debugShowCheckedModeBanner: false, // Tắt debug banner
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MusicHomePage(),
    );
  }

  // @override
  // Widget build(BuildContext context) {
  //   return const MusicHomePage();
  // }

  // @override
  // Widget build(BuildContext context) {
  //   return const MaterialApp(
  //     home: Scaffold(
  //       body: Center(
  //         child: Text('nguyen ', style: TextStyle(fontSize: 24)),
  //       ),
  //     ),
  //   );
  // }
}


  // WidgetsFlutterBinding.ensureInitialized();
  //
  // var remoteDataSource = RemoteDataSource();
  // try {
  //   var songs = await remoteDataSource.loadData();
  //
  //   for (var song in songs!) {
  //     debugPrint(song.toString());
  //   }
  // } catch (e) {
  //   debugPrint('Lỗi khi tải dữ liệu: $e');
  // }

  // var repository = DefaultRepository();
  //
  // var songs = await repository.loadData();
  // if (songs != null) {
  //   for (var song in songs) {
  //     debugPrint(song.toString());
  //   }
  // }