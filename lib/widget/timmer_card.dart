import 'package:flutter/material.dart';
import 'package:stop_watch_timer/stop_watch_timer.dart';
import 'package:wombat_tracker/screen/end_run.dart';
import 'package:wombat_tracker/styles.dart';
import 'package:wombat_tracker/utils/location_services.dart';

class MyTimmer extends StatefulWidget {
  @override
  _MyTimmerState createState() => _MyTimmerState();
}

class _MyTimmerState extends State<MyTimmer> {
  final StopWatchTimer _stopWatchTimer = StopWatchTimer(
    mode: StopWatchMode.countUp,
  );
  final _isHours = true;
  bool _playTimer = false;
  bool _time = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() async {
    super.dispose();
    await _stopWatchTimer.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Column(
        children: [
          Align(alignment: Alignment.topLeft, child: _label("Chrono")),
          StreamBuilder<int>(
            stream: _stopWatchTimer.rawTime,
            initialData: _stopWatchTimer.rawTime.value,
            builder: (context, snapshot) {
              final value = snapshot.data ?? 0;
              final displayTime = StopWatchTimer.getDisplayTime(
                value,
                hours: _isHours,
                milliSecond: false,
              );
              return Text(
                displayTime,
                style: title.copyWith(color: primaryBase),
              );
            },
          ),
          SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _playTimer
                  ? FilledButton(
                      onPressed: () {
                        _stopWatchTimer.onStopTimer();
                        setState(() {
                          _playTimer = false;
                        });
                      },
                      style: FilledButton.styleFrom(
                        backgroundColor: Colors.white, // Couleur de fond
                      ),
                      child: const Icon(
                        Icons.pause_circle_rounded,
                        size: 96,
                        color: primaryBase,
                      ),
                    )
                  : FilledButton(
                      onPressed: () async {
                        _stopWatchTimer.onStartTimer();
                        setState(() {
                          _playTimer = true;
                          _time = true;
                        });
                        await setLocation();
                        LocationServices.setRunReady(true);
                      },
                      style: FilledButton.styleFrom(
                        backgroundColor: Colors.white, // Couleur de fond
                      ),
                      child: const Icon(
                        Icons.play_arrow_rounded,
                        size: 96,
                        color: primaryBase,
                      ),
                    ),
              SizedBox(width: 10),
              _time
                  ? FilledButton(
                      onPressed: () {
                        _stopWatchTimer.onResetTimer();
                        setState(() {
                          _playTimer = false;
                          _time = false;
                          LocationServices.setRunReady(false);
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) {
                                return EndRun();
                              },
                            ),
                          );
                        });
                      },
                      style: FilledButton.styleFrom(
                        backgroundColor: Colors.white, // Couleur de fond
                      ),
                      child: const Icon(
                        Icons.stop_circle_rounded,
                        size: 96,
                        color: primaryBase,
                      ),
                    )
                  : SizedBox(),
            ],
          ),
          SizedBox(height: 10),
        ],
      ),
    );
  }

  Widget _label(String text) => Container(
    color: primaryBase,
    padding: EdgeInsets.only(left: 18.0, right: 31.0, top: 4.0, bottom: 9.0),
    child: Text(text, style: addStick.copyWith(color: secondaryBase)),
  );

  Future<void> setLocation() async {
    final service = LocationServices();
    await service.setInitialLocation();
  }
}
