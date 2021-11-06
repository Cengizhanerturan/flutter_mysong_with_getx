import 'package:flutter/material.dart';
import 'package:my_song/constants/color.dart';
import 'package:my_song/constants/text.dart';
import 'package:my_song/pages/muzik_page.dart';

class PlaylistPage extends StatefulWidget {
  List playlistListe;
  String playlistTitle;
  PlaylistPage(
      {required this.playlistListe, required this.playlistTitle, Key? key})
      : super(key: key);

  @override
  _PlaylistPageState createState() => _PlaylistPageState();
}

class _PlaylistPageState extends State<PlaylistPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: double.infinity,
        color: ConstantsColor.appColor,
        child: Column(
          children: [
            SafeArea(
              child: Padding(
                padding:
                    const EdgeInsets.only(top: 8.0, left: 8.0, bottom: 8.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.of(context).pop();
                      },
                      child: Icon(
                        Icons.chevron_left,
                        size: 40,
                        color: ConstantsColor.appColor2,
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: Text(
                        widget.playlistTitle,
                        style: ConstantsText.textStyle6,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: widget.playlistListe.length,
                itemBuilder: (context, index) {
                  return Card(
                    color: ConstantsColor.appColor3.withOpacity(0.07),
                    child: ListTile(
                      leading: CircleAvatar(
                        radius: 30,
                        backgroundColor: ConstantsColor.appColor,
                        backgroundImage: NetworkImage(widget
                            .playlistListe[index]['albumImage']
                            .toString()),
                      ),
                      trailing: IconButton(
                        onPressed: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => MuzikPage(
                                  sarkiciIsmi: widget.playlistListe[index]
                                      ['artistName'],
                                  sarkiIsmi: widget.playlistListe[index]
                                      ['sarkiTitle'],
                                  photo: widget.playlistListe[index]
                                      ['albumImage'],
                                  sarki: widget.playlistListe[index]
                                      ['sarkiPreview'])));
                        },
                        icon: Icon(
                          Icons.music_note_outlined,
                          color: ConstantsColor.appColor2,
                          size: 28,
                        ),
                      ),
                      title: Text(
                        widget.playlistListe[index]['artistName'],
                        style: ConstantsText.textStyle4,
                      ),
                      subtitle: Text(
                        widget.playlistListe[index]['sarkiTitle'],
                        style: ConstantsText.textStyle8,
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
