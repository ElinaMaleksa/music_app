import 'package:flutter/material.dart';
import 'package:music_app/details/presentation/album_details_screen.dart';
import 'package:music_app/home/domain/entry.dart' as entry_data;

Widget drawer({required BuildContext context}) {
  return Drawer(
    child: ListView(
      padding: EdgeInsets.zero,
      children: [
        DrawerHeader(
          decoration: BoxDecoration(color: Theme.of(context).colorScheme.secondary),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Developer info'.toUpperCase(),
                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
              const SizedBox(height: 10),
              const Text('Elina Smolaka, LV', style: TextStyle(fontSize: 18)),
              const Text('elina.smolaka@gmail.com', style: TextStyle(fontStyle: FontStyle.italic, fontSize: 16)),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget albumCard({
  required BuildContext context,
  required entry_data.Entry entry,
  required int index,
  required String placeInTop,
}) {
  return Card(
    elevation: 0,
    color: Colors.grey[200],
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
    child: InkWell(
      borderRadius: BorderRadius.circular(8),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => AlbumDetailsScreen(albumUrl: entry.id?.label)),
        );
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
        child: Row(
          children: [
            SizedBox(
              width: 35,
              child: FittedBox(
                fit: BoxFit.scaleDown,
                child: Container(
                  margin: const EdgeInsets.only(right: 5),
                  child: Text(
                    placeInTop,
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 15),
                  ),
                ),
              ),
            ),
            Expanded(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Flexible(
                    flex: 3,
                    child: ClipRRect(
                      borderRadius: const BorderRadius.all(Radius.circular(8)),
                      child: Image.network(entry.imImage![2]?.label ?? ''),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    flex: 7,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          entry.imName?.label ?? '',
                          style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 5),
                          child: Text(entry.imArtist?.label ?? '', maxLines: 2, overflow: TextOverflow.ellipsis),
                        ),
                        Text(
                          entry.category?.attributes?.label ?? '',
                          style: const TextStyle(color: Colors.black45),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const Icon(Icons.more_vert, size: 20, color: Colors.black26),
          ],
        ),
      ),
    ),
  );
}

Widget searchTextField({required Function onChanged}) {
  return TextField(
    onChanged: (String s) => onChanged(s),
    autofocus: true,
    cursorColor: Colors.white,
    style: const TextStyle(color: Colors.white, fontSize: 20),
    textInputAction: TextInputAction.search,
    decoration: const InputDecoration(
      border: InputBorder.none,
      hintText: 'Search',
      hintStyle: TextStyle(color: Colors.white70),
    ),
  );
}

Widget noConnectionView({String? error, required Function onRefresh}) {
  return RefreshIndicator(
    onRefresh: () => onRefresh(),
    child: ListView(
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
      children: [
        const Text('Please make sure your device has internet connection, then try to refresh this view!'),
        if (error != null) Text('\nThe following error occurred: $error'),
      ],
    ),
  );
}
