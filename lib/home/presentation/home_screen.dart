import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:music_app/home/domain/entry.dart' as entry_data;
import 'package:music_app/home/data/data_provider.dart';
import 'package:music_app/home/presentation/home_widgets.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Future<List<entry_data.Entry>> futureAlbumsList;
  late bool isSearchEnabled;
  List<entry_data.Entry> entriesList = [];
  List<entry_data.Entry> resultsEntriesList = [];

  // connectivity related variables
  ConnectivityResult connectionStatus = ConnectivityResult.none;
  final Connectivity connectivity = Connectivity();
  late StreamSubscription<ConnectivityResult> connectivitySubscription;

  @override
  void initState() {
    isSearchEnabled = false;
    futureAlbumsList = fetchAlbumEntries();

    initConnectivity();
    connectivitySubscription = connectivity.onConnectivityChanged.listen(updateConnectionStatus);
    super.initState();
  }

  @override
  void dispose() {
    connectivitySubscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: !isSearchEnabled
            ? const Text('Top 100 Albums')
            : searchTextField(onChanged: (String s) {
                setState(() {
                  resultsEntriesList = [];
                  for (var e in entriesList) {
                    if ((e.imArtist?.label?.toLowerCase().contains(s) ?? false) ||
                        (e.imName?.label?.toLowerCase().contains(s) ?? false)) {
                      resultsEntriesList.add(e);
                    }
                  }
                });
              }),
        actions: [
          !isSearchEnabled
              ? IconButton(icon: const Icon(Icons.search), onPressed: () => setState(() => isSearchEnabled = true))
              : IconButton(
                  icon: const Icon(Icons.clear),
                  onPressed: () => setState(() {
                    isSearchEnabled = false;
                    resultsEntriesList = [];
                  }),
                ),
        ],
      ),
      drawer: drawer(context: context),
      body: connectionStatus.name == 'none' && entriesList.isEmpty
          ? noConnectionView(onRefresh: onRefresh)
          : Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Expanded(
                  child: FutureBuilder<List<entry_data.Entry>>(
                    future: futureAlbumsList,
                    builder: (context, snapshot) {
                      entriesList = snapshot.data ?? [];
                      if (snapshot.hasData) {
                        return !isSearchEnabled
                            ? RefreshIndicator(
                                onRefresh: onRefresh,
                                child: ListView(
                                  physics: const BouncingScrollPhysics(),
                                  children: [
                                    CachedNetworkImage(
                                      height: 150,
                                      width: double.infinity,
                                      imageUrl: 'https://images.unsplash.com/photo-1453738773917-9c3eff1db985?ixlib=rb-'
                                          '4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1470&q=80',
                                      imageBuilder: (context, imageProvider) => Container(
                                        decoration: BoxDecoration(
                                          borderRadius: const BorderRadius.only(
                                              bottomLeft: Radius.circular(20), bottomRight: Radius.circular(20)),
                                          image: DecorationImage(image: imageProvider, fit: BoxFit.cover),
                                        ),
                                      ),
                                      placeholder: (context, url) => Container(),
                                      errorWidget: (context, url, error) => Container(
                                        decoration: BoxDecoration(
                                          borderRadius: const BorderRadius.only(
                                            bottomLeft: Radius.circular(20),
                                            bottomRight: Radius.circular(20),
                                          ),
                                          color: Colors.grey[400],
                                        ),
                                      ),
                                    ),
                                    ListView.builder(
                                      shrinkWrap: true,
                                      physics: const BouncingScrollPhysics(),
                                      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
                                      itemCount: entriesList.length,
                                      itemBuilder: (context, index) => albumCard(
                                          entry: entriesList[index],
                                          index: index,
                                          context: context,
                                          placeInTop: isSearchEnabled
                                              ? '${(entriesList.indexOf(resultsEntriesList[index]) + 1)}'
                                              : '${(index + 1)}'),
                                    ),
                                  ],
                                ),
                              )
                            : ListView.builder(
                                physics: const BouncingScrollPhysics(),
                                padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 5),
                                itemCount: resultsEntriesList.length,
                                itemBuilder: (context, index) => albumCard(
                                  entry: resultsEntriesList[index],
                                  index: index,
                                  context: context,
                                  placeInTop: isSearchEnabled
                                      ? '${(entriesList.indexOf(resultsEntriesList[index]) + 1)}'
                                      : '${(index + 1)}',
                                ),
                              );
                      } else if (snapshot.hasError) {
                        return noConnectionView(error: '${snapshot.error}', onRefresh: onRefresh);
                      }

                      return const Center(child: CircularProgressIndicator());
                    },
                  ),
                ),
              ],
            ),
    );
  }

  Future<void> onRefresh() async {
    try {
      final results = await fetchAlbumEntries();
      futureAlbumsList = Future.value(results);
      setState(() {});
    } catch (_) {}
  }

  Future<void> initConnectivity() async {
    late ConnectivityResult result;
    try {
      result = await connectivity.checkConnectivity();
    } on PlatformException catch (_) {
      return;
    }

    if (!mounted) return Future.value(null);
    return updateConnectionStatus(result);
  }

  Future<void> updateConnectionStatus(ConnectivityResult result) async => setState(() => connectionStatus = result);
}
