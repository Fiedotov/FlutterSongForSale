import 'package:Effexxion/data/mute_helper.dart';
import 'package:Effexxion/utils/constants.dart';
import 'package:Effexxion/utils/helper.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ocarina/ocarina.dart';
import 'package:pausable_timer/pausable_timer.dart';
import 'package:quiver/async.dart';
import 'package:syncfusion_flutter_core/theme.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';

class SoundPanel extends StatefulWidget {
  final bool disabled;
  final String label;
  final String sound;
  final String image;
  final Duration duration;

  const SoundPanel({
    super.key,
    required this.label,
    required this.sound,
    required this.image,
    required this.disabled,
    required this.duration,
  });

  @override
  State<SoundPanel> createState() => SoundPanelState();
}

class SoundPanelState extends State<SoundPanel> with AutomaticKeepAliveClientMixin<SoundPanel> {
  int _currentPlayer = 0;
  OcarinaPlayer? _player_1;
  OcarinaPlayer? _player_2;
  PausableTimer? _durationTimer_1;
  PausableTimer? _durationTimer_2;

  bool _isMute = false;
  double _volume = 0;

  Duration? mixDuration;

  bool _mixSwitch = false;

  @override
  void initState() {
    super.initState();
    if (!widget.disabled) {
      _initSound();
    }
  }

  Future<void> _initSound() async {
    try {
      _player_1 = OcarinaPlayer(
        asset: widget.sound,
        loop: true,
        volume: 0,
      );
      _player_2 = OcarinaPlayer(
        asset: widget.sound,
        loop: true,
        volume: 0,
      );
      await _player_1!.load();
      await _player_2!.load();
      await _player_1!.updateVolume(0);
      await _player_2!.updateVolume(0);
      mixDuration = widget.duration;
      _durationTimer_1 = PausableTimer((mixDuration! - Constants.soundSwitchDuration), () {
        _nextMusic();
      });
      _player_1!.play();
      _durationTimer_1!.start();
      setState(() {});
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }

  _nextMusic() async {
    try {
      if (_mixSwitch) return;
      _mixSwitch = true;
      setState(() {});
      if (_currentPlayer == 0) {
        if (_durationTimer_1 != null) {
          _durationTimer_1!.cancel();
          _durationTimer_1 = null;
        }
        await _player_2!.updateVolume(0);
        await _player_2!.seek(Duration.zero);
        _durationTimer_2 = PausableTimer((mixDuration! - Constants.soundSwitchDuration), () {
          _nextMusic();
        });
        _player_2!.play();
        _durationTimer_2!.start();
        CountdownTimer(Constants.soundSwitchDuration, Constants.fadeSmoothDuration).listen((event) {
          if (!_isMute) {
            final percent_1 = (event.remaining.inMilliseconds / Constants.soundSwitchDuration.inMilliseconds);
            final percent_2 = 1 - (event.remaining.inMilliseconds / Constants.soundSwitchDuration.inMilliseconds);
            _setVolume_1(percent_1);
            _setVolume_2(percent_2);
          }
        }).onDone(() async {
          await _player_1!.stop();
          _currentPlayer = 1;
          _mixSwitch = false;
          setState(() {});
        });
      } else {
        if (_durationTimer_2 != null) {
          _durationTimer_2!.cancel();
          _durationTimer_2 = null;
        }
        await _player_1!.updateVolume(0);
        await _player_1!.seek(Duration.zero);
        _durationTimer_1 = PausableTimer((mixDuration! - Constants.soundSwitchDuration), () {
          _nextMusic();
        });
        _player_1!.play();
        _durationTimer_1!.start();
        CountdownTimer(Constants.soundSwitchDuration, Constants.fadeSmoothDuration).listen((event) {
          if (!_isMute) {
            final percent_1 = 1 - (event.remaining.inMilliseconds / Constants.soundSwitchDuration.inMilliseconds);
            final percent_2 = (event.remaining.inMilliseconds / Constants.soundSwitchDuration.inMilliseconds);
            _setVolume_1(percent_1);
            _setVolume_2(percent_2);
          }
        }).onDone(() async {
          await _player_2!.stop();
          _currentPlayer = 0;
          _mixSwitch = false;
          setState(() {});
        });
      }
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }

  stopMixSound() async {
    try {
      if (widget.disabled || _volume == 0) return;
      if (_mixSwitch) {
        await Helper.sleep(Constants.soundSwitchDuration.inSeconds * 2);
      }
      if (_currentPlayer == 0) {
        if (_isMute) {
          _setVolume_1(0);
          _volume = 0;
          setState(() {});
        } else {
          CountdownTimer(Constants.soundSwitchDuration, Constants.fadeSmoothDuration).listen((event) {
            final percent = (event.remaining.inMilliseconds / Constants.musicSwitchDuration.inMilliseconds);
            _setVolume_1(percent);
          }).onDone(() {
            _setVolume_1(0);
            _volume = 0;
            setState(() {});
          });
        }
      } else {
        if (_isMute) {
          _setVolume_2(0);
          _volume = 0;
          setState(() {});
        } else {
          CountdownTimer(Constants.soundSwitchDuration, Constants.fadeSmoothDuration).listen((event) {
            final percent = (event.remaining.inMilliseconds / Constants.musicSwitchDuration.inMilliseconds);
            _setVolume_2(percent);
          }).onDone(() {
            _setVolume_2(0);
            _volume = 0;
            setState(() {});
          });
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }

  setMixVolume(double volume) async {
    try {
      if (widget.disabled) return;
      if (_mixSwitch) {
        await Helper.sleep(Constants.soundSwitchDuration.inSeconds * 2);
      }
      _volume = volume;
      setState(() {});
      if (_currentPlayer == 0) {
        CountdownTimer(Constants.soundSwitchDuration, Constants.fadeSmoothDuration).listen((event) {
          if(!_isMute){
            final percent = 1 - (event.remaining.inMilliseconds / Constants.soundSwitchDuration.inMilliseconds);
            _setVolume_1(percent);
          }
        });
      } else {
        CountdownTimer(Constants.soundSwitchDuration, Constants.fadeSmoothDuration).listen((event) {
          if(!_isMute){
            final percent = 1 - (event.remaining.inMilliseconds / Constants.soundSwitchDuration.inMilliseconds);
            _setVolume_2(percent);
          }
        });
      }
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  Future<void> _setVolume_1(double volume) async {
    try {
      if (volume > 1) {
        volume = 1;
      }
      if (volume < 0) {
        volume = 0;
      }
      if (volume > _volume) {
        volume = _volume;
      }
      if (_player_1 != null) {
        await _player_1!.updateVolume(volume);
      }
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }

  Future<void> _setVolume_2(double volume) async {
    try {
      if (volume > 1) {
        volume = 1;
      }
      if (volume < 0) {
        volume = 0;
      }
      if (volume > _volume) {
        volume = _volume;
      }
      if (_player_2 != null) {
        await _player_2!.updateVolume(volume);
      }
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }

  muteOn() {
    try {
      if (widget.disabled) return;
      switch (widget.label) {
        case "A":
          MuteHelper.sound_a = _volume;
          break;
        case "B":
          MuteHelper.sound_b = _volume;
          break;
        case "C":
          MuteHelper.sound_c = _volume;
          break;
        case "D":
          MuteHelper.sound_d = _volume;
          break;
        case "E":
          MuteHelper.sound_e = _volume;
          break;
        case "F":
          MuteHelper.sound_f = _volume;
          break;
      }
      setState(() {
        _isMute = true;
      });
      CountdownTimer(Constants.soundSwitchDuration, Constants.fadeSmoothDuration).listen((event) {
        final percent = (event.remaining.inMilliseconds / Constants.soundSwitchDuration.inMilliseconds);
        _setVolume_1(percent);
        _setVolume_2(percent);
      });
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }

  muteOff() {
    try {
      if (widget.disabled) return;
      double old = 0.0;
      switch (widget.label) {
        case "A":
          old = MuteHelper.sound_a;
          break;
        case "B":
          old = MuteHelper.sound_b;
          break;
        case "C":
          old = MuteHelper.sound_c;
          break;
        case "D":
          old = MuteHelper.sound_d;
          break;
        case "E":
          old = MuteHelper.sound_e;
          break;
        case "F":
          old = MuteHelper.sound_f;
          break;
      }
      _volume = old;
      setState(() {
        _isMute = false;
      });
      CountdownTimer(Constants.soundSwitchDuration, Constants.fadeSmoothDuration).listen((event) {
        final percent = 1 - (event.remaining.inMilliseconds / Constants.soundSwitchDuration.inMilliseconds);
        _setVolume_1(percent);
        _setVolume_2(percent);
      });
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }

  switchMusic() {
    try {
      if (widget.disabled) return;
      double current = _volume;
      CountdownTimer(Constants.soundSwitchDuration, Constants.fadeSmoothDuration).listen((event) {
        if (!_isMute) {
          if (event.remaining.inMilliseconds < Constants.soundSwitchDuration.inMilliseconds / 2) {
            final percent = current - current * (event.remaining.inMilliseconds / Constants.soundSwitchDuration.inMilliseconds);
            _setVolume_1(percent);
            _setVolume_2(percent);
          } else {
            final percent = current * (event.remaining.inMilliseconds / Constants.soundSwitchDuration.inMilliseconds);
            _setVolume_1(percent);
            _setVolume_2(percent);
          }
        }
      });
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }

  double getVolume() {
    return _volume;
  }

  @override
  void dispose() {
    _player_1?.dispose();
    _player_2?.dispose();
    _durationTimer_1?.cancel();
    _durationTimer_2?.cancel();
    super.dispose();
  }

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Container(
      constraints: const BoxConstraints.expand(),
      child: Center(
        child: SfSliderTheme(
          data: SfSliderThemeData(
            thumbRadius: 23.w,
            thumbColor: const Color(0xFF282D3B),
            activeTrackColor: const Color(0xFF090E12),
            inactiveTrackHeight: 4.w,
            activeTrackHeight: 4.w,
            inactiveTrackColor: const Color(0xFF090E12),
          ),
          child: SfSlider.vertical(
            min: 0,
            max: 1,
            value: _volume,
            interval: 0.1,
            thumbIcon: Stack(
              children: [
                Positioned.fill(
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50.w),
                      boxShadow: [
                        BoxShadow(color: const Color(0xFF111111), offset: Offset(0, 5.h), blurRadius: 15),
                      ],
                    ),
                  ),
                ),
                Positioned.fill(
                  child: Center(
                    child: Image.asset(widget.image, fit: BoxFit.cover),
                  ),
                ),
                Positioned.fill(
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50.w),
                      color: _isMute ? Colors.transparent.withOpacity(0.5) : Colors.transparent,
                    ),
                  ),
                ),
              ],
            ),
            showTicks: false,
            showLabels: false,
            onChanged: _isMute || widget.disabled
                ? null
                : (value) {
                    setState(() {
                      _volume = value;
                    });
                    _setVolume_1(value);
                    _setVolume_2(value);
                  },
          ),
        ),
      ),
    );
  }
}
