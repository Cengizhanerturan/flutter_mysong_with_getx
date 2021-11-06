import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:my_song/constants/color.dart';
import 'package:my_song/constants/text.dart';

class MuzikPage extends StatefulWidget {
  String? sarkiciIsmi;
  String? sarkiIsmi;
  String? photo;
  String? sarki;
  MuzikPage(
      {required this.sarkiciIsmi,
      required this.sarkiIsmi,
      required this.photo,
      required this.sarki,
      Key? key})
      : super(key: key);

  @override
  _MuzikPageState createState() => _MuzikPageState();
}

class _MuzikPageState extends State<MuzikPage> {
  bool playing = false;
  IconData playBtn = Icons.play_arrow;

  AudioPlayer? _player;
  Duration position = Duration();
  Duration musicLenght = Duration();

  @override
  void initState() {
    super.initState();
    _player = AudioPlayer();

    _player!.onDurationChanged.listen((d) {
      setState(() {
        musicLenght = d;
      });
    });

    _player!.onAudioPositionChanged.listen((p) {
      setState(() {
        position = p;
      });
    });

    _player!.onPlayerCompletion.listen((event) {
      setState(() {
        position = Duration(seconds: 0);
        playing = false;
        playBtn = Icons.play_arrow;
      });
    });

    _player!.setUrl(widget.sarki.toString());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: double.infinity,
        color: ConstantsColor.appColor,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SafeArea(
              child: Padding(
                padding:
                    const EdgeInsets.only(top: 8.0, left: 8.0, bottom: 8.0),
                child: InkWell(
                  onTap: () {
                    _player!.stop();
                    Navigator.of(context).pop();
                  },
                  child: Icon(
                    Icons.chevron_left,
                    size: 40,
                    color: ConstantsColor.appColor2,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 16.0),
              child: Center(
                child: Container(
                  height: 300,
                  width: MediaQuery.of(context).size.width * 0.8,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(40),
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: NetworkImage(widget.photo.toString()),
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(top: 16.0),
                child: Column(
                  children: [
                    Center(
                      child: Text(widget.sarkiciIsmi.toString(),
                          style: ConstantsText.textStyle4),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Center(
                      child: Text(widget.sarkiIsmi.toString(),
                          style: ConstantsText.textStyle8),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Spacer(
                      flex: 1,
                    ),
                    Expanded(
                      flex: 2,
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(60),
                            topRight: Radius.circular(60),
                          ),
                          color: ConstantsColor.appColor2,
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              width: MediaQuery.of(context).size.width * 0.8,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    position.toString().split(".")[0],
                                    style: ConstantsText.textStyle9,
                                  ),
                                  Expanded(child: slider()),
                                  Text(
                                    musicLenght.toString().split(".")[0],
                                    style: ConstantsText.textStyle9,
                                  ),
                                ],
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                IconButton(
                                  onPressed: () {
                                    _player!.setPlaybackRate(playbackRate: 0.5);
                                  },
                                  icon: Icon(
                                    Icons.skip_previous,
                                  ),
                                  iconSize: 45,
                                  color: ConstantsColor.appColor,
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                IconButton(
                                  onPressed: () {
                                    if (!playing) {
                                      _player!.play(widget.sarki.toString());
                                      setState(() {
                                        playBtn = Icons.pause;
                                        playing = true;
                                      });
                                    } else {
                                      _player!.pause();
                                      setState(() {
                                        playBtn = Icons.play_arrow;
                                        playing = false;
                                      });
                                    }
                                  },
                                  icon: Icon(
                                    playBtn,
                                  ),
                                  iconSize: 62,
                                  color: ConstantsColor.appColor,
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                IconButton(
                                  onPressed: () {
                                    _player!.setPlaybackRate(playbackRate: 1.5);
                                  },
                                  icon: Icon(
                                    Icons.skip_next,
                                  ),
                                  iconSize: 45,
                                  color: ConstantsColor.appColor,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget slider() {
    return Slider.adaptive(
      value: position.inSeconds.toDouble(),
      min: 0.0,
      max: musicLenght.inSeconds.toDouble(),
      onChanged: (double value) {
        setState(() {
          changeToSecond(value.toInt());
          value = value;
        });
      },
      activeColor: ConstantsColor.appColor,
      inactiveColor: ConstantsColor.textColor1,
    );
  }

  void changeToSecond(int second) {
    Duration newDuration = Duration(seconds: second);
    _player!.seek(newDuration);
  }
}
