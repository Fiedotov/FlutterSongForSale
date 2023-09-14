import 'dart:async';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:Effexxion/data/mute_helper.dart';
import 'package:Effexxion/hive/mix_hive.dart';
import 'package:Effexxion/hive/playlist_hive.dart';
import 'package:Effexxion/main.dart';
import 'package:Effexxion/pages/main_page/overlay/add_mix_bottom_sheet.dart';
import 'package:Effexxion/pages/main_page/overlay/create_playlist_bottom_sheet.dart';
import 'package:Effexxion/pages/main_page/overlay/sleep_time_bottom_sheet.dart';
import 'package:Effexxion/pages/main_page/sound_panel.dart';
import 'package:Effexxion/utils/constants.dart';
import 'package:Effexxion/utils/helper.dart';
import 'package:Effexxion/utils/hive_helper.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:just_audio/just_audio.dart';
import 'package:quiver/async.dart';
import 'package:rxdart/rxdart.dart';
import 'package:stop_watch_timer/stop_watch_timer.dart';

class GlobalState with ChangeNotifier {
  final GlobalKey<SoundPanelState> _soundAKey = GlobalKey<SoundPanelState>();
  final GlobalKey<SoundPanelState> _soundBKey = GlobalKey<SoundPanelState>();
  final GlobalKey<SoundPanelState> _soundCKey = GlobalKey<SoundPanelState>();
  final GlobalKey<SoundPanelState> _soundDKey = GlobalKey<SoundPanelState>();
  final GlobalKey<SoundPanelState> _soundEKey = GlobalKey<SoundPanelState>();
  final GlobalKey<SoundPanelState> _soundFKey = GlobalKey<SoundPanelState>();

  final CarouselController carouselController = CarouselController();

  late StopWatchTimer _playWatchTimer;
  StreamSubscription<Duration>? positionStream;
  StreamSubscription<int?>? indexStream;
  StreamSubscription<Duration?>? durationStream;
  StreamSubscription<bool>? playingStream;

  StopWatchTimer? _sleepWatchTimer;

  bool _isInit = false;
  bool _musicSwitch = false;
  bool _muteSwitch = false;
  int _currentMusicIndex = 0;
  List<MixHive> _musics = [];

  AudioPlayer musicPlayer = AudioPlayer();

  //--------------------------------------------------
  double _volume = 0;
  bool _playing = true;
  bool _isMute = false;
  bool _isLooping = false;
  bool _reachedEnd = false;
  double position = 0;

  Duration? musicDuration;

  //-------------------- Title----------------------
  bool _titleEnable = false;
  String _musicTitle = "";

  //-------------------- Playing Part --------------------------------
  int _playingMode = -1; // -1: Normal Mode, other: playlist id

  double _mixAVolume = 0;
  double _mixBVolume = 0;
  double _mixCVolume = 0;
  double _mixDVolume = 0;
  double _mixEVolume = 0;
  double _mixFVolume = 0;

  setMixAndVolume(MixHive mix) {
    _volume = mix.volume;
    _mixAVolume = mix.soundA;
    _mixBVolume = mix.soundB;
    _mixCVolume = mix.soundC;
    _mixDVolume = mix.soundD;
    _mixEVolume = mix.soundE;
    _mixFVolume = mix.soundF;
  }

  startApp(int playlistId) {
    _isInit = true;
    _initPlayTimer();
    initState(playlistId);
  }

  initState(int playlistId) {
    if (!_isInit) return;
    _isInit = false;
    _playingMode = playlistId;
    notifyListeners();
    _clearAllMusic();
  }

  _loadMusic() {
    if (_playingMode == -1) {
      // Normal Mode
      _musics = Helper.getDefaultMusic();
    } else {
      // PlayListMode
      PlayListHive? hive = HiveHelper.getPlayListById(_playingMode);
      if (hive != null) {
        _musics = HiveHelper.getMixList(hive.musics);
      } else {
        // Can not be reached
        _playingMode = -1;
        _musics = Helper.getDefaultMusic();
      }
    }
  }

  _initPlayTimer() {
    _playWatchTimer = StopWatchTimer(
        mode: StopWatchMode.countUp,
        onChangeRawMinute: (value) {
          if (value == 0) return;
          _playWatchTimer.onStopTimer();
          int millSeconds = _playWatchTimer.rawTime.value;
          HiveHelper.addPlayTime(millSeconds, playingMode, _musics[_currentMusicIndex].id);
          _playWatchTimer.onResetTimer();
          _playWatchTimer.onStartTimer();
        });
  }

  _initMusic() async {
    try {
      MixHive targetMusic = _musics[_currentMusicIndex];
      setMixAndVolume(targetMusic);
      final playlist = ConcatenatingAudioSource(
        useLazyPreparation: true,
        shuffleOrder: DefaultShuffleOrder(),
        children: _musics.map((e) => AudioSource.asset(e.file)).toList(),
      );
      await musicPlayer.setAudioSource(playlist, initialIndex: 0, initialPosition: Duration.zero);
      if (_playingMode == -1) {
        await musicPlayer.setLoopMode(LoopMode.all);
      } else {
        await musicPlayer.setLoopMode(LoopMode.off);
      }
      await _setVolume(0);
      if (positionStream != null) {
        await positionStream!.cancel();
        positionStream = null;
      }
      positionStream = musicPlayer.positionStream.throttleTime(const Duration(seconds: 1)).listen((pos) {
        if (musicDuration != null) {
          int gap = musicDuration!.inSeconds - pos.inSeconds;
          if (gap == Constants.musicSwitchDuration.inSeconds + 1) {
            if (_isLooping) {
              loopMusic();
            } else {
              if (_currentMusicIndex < _musics.length - 1) {
                switchMusic(_currentMusicIndex + 1);
              } else {
                if (_playingMode == -1) {
                  switchMusic(0);
                } else {
                  _endOfMusic();
                }
              }
            }
          }
          if (_playingMode != -1) {
            position = pos.inSeconds / musicDuration!.inSeconds;
            notifyListeners();
          }
        }
      });
      if (durationStream != null) {
        await durationStream!.cancel();
        durationStream = null;
      }
      durationStream = musicPlayer.durationStream.listen((duration) {
        musicDuration = duration;
      });
      if (indexStream != null) {
        await indexStream!.cancel();
        indexStream = null;
      }
      indexStream = musicPlayer.currentIndexStream.listen((index) {
        _currentMusicIndex = index ?? 0;
        if (carouselController.ready) {
          carouselController.animateToPage(index ?? 0);
        }
        if (_playingMode != -1) {
          MixHive targetMusic = _musics[_currentMusicIndex];
          setMixAndVolume(targetMusic);
        }
        switchTitle();
        if (_playingMode == -1) {
          _changeMusicForEffect();
        } else {
          _setMixVolume();
        }
      });
      if (playingStream != null) {
        await playingStream!.cancel();
        playingStream = null;
      }
      playingStream = musicPlayer.playingStream.listen((event) {
        if (!_musicSwitch) {
          _playing = event;
          if (event) {
            // reset playWatchTime and start
            _playWatchTimer.onResetTimer();
            _playWatchTimer.onStartTimer();
          } else {
            // stop playWatchTime and save playtime
            _playWatchTimer.onStopTimer();
            int millSeconds = _playWatchTimer.rawTime.value;
            HiveHelper.addPlayTime(millSeconds, playingMode, _musics[_currentMusicIndex].id);
          }
          notifyListeners();
        }
      });
      musicPlayer.play();
      _playWatchTimer.onStartTimer();
      _musicTitle = _musics[_currentMusicIndex].title;
      _titleEnable = true;
      _isInit = true;
      notifyListeners();
      CountdownTimer(Constants.musicSwitchDuration, Constants.fadeSmoothDuration).listen((event) {
        final percent = 1 - (event.remaining.inMilliseconds / Constants.musicSwitchDuration.inMilliseconds);
        _setVolume(percent);
      }).onDone(() {
        _setMixVolume();
      });
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }

  switchMusic(int index) async {
    try {
      if (_musicSwitch) return;
      _musicSwitch = true;
      notifyListeners();
      bool isNext = true;
      if (index == _currentMusicIndex + 1) {
        isNext = true;
      } else if (index == _currentMusicIndex - 1) {
        isNext = false;
      } else {
        if (_currentMusicIndex > index) {
          isNext = true;
        } else {
          isNext = false;
        }
      }
      // Next song
      CountdownTimer(Constants.musicSwitchDuration, Constants.fadeSmoothDuration).listen((event) {
        if (!_isMute) {
          final percent = (event.remaining.inMilliseconds / Constants.musicSwitchDuration.inMilliseconds);
          _setVolume(percent);
        }
      }).onDone(() async {
        if (isNext) {
          await musicPlayer.seekToNext();
        } else {
          await musicPlayer.seekToPrevious();
        }
        if (!_playing) {
          musicPlayer.play();
        }
        _musicSwitch = false;
        if (!_playWatchTimer.isRunning) {
          _playWatchTimer.onStartTimer();
        }
        notifyListeners();
        CountdownTimer(Constants.musicSwitchDuration, Constants.fadeSmoothDuration).listen((event) {
          if (!_isMute) {
            final percent = 1 - (event.remaining.inMilliseconds / Constants.musicSwitchDuration.inMilliseconds);
            _setVolume(percent);
          }
        }).onDone(() {
          notifyListeners();
        });
      });
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }

  loopMusic() async {
    try {
      if (_musicSwitch) return;
      _musicSwitch = true;
      notifyListeners();
      CountdownTimer(Constants.musicSwitchDuration, Constants.fadeSmoothDuration).listen((event) {
        if (!_isMute) {
          final percent = (event.remaining.inMilliseconds / Constants.musicSwitchDuration.inMilliseconds);
          _setVolume(percent);
        }
      }).onDone(() async {
        await musicPlayer.seek(Duration.zero);
        if (!_playing) {
          musicPlayer.play();
        }
        _musicSwitch = false;
        if (!_playWatchTimer.isRunning) {
          _playWatchTimer.onStartTimer();
        }
        notifyListeners();
        CountdownTimer(Constants.musicSwitchDuration, Constants.fadeSmoothDuration).listen((event) {
          if (!_isMute) {
            final percent = 1 - (event.remaining.inMilliseconds / Constants.musicSwitchDuration.inMilliseconds);
            _setVolume(percent);
          }
        }).onDone(() {
          notifyListeners();
        });
      });
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }

  muteHandler() {
    try {
      if (_muteSwitch) return;
      _muteSwitch = true;
      notifyListeners();
      if (_isMute) {
        // Need to un-mute
        _soundAKey.currentState?.muteOff();
        _soundBKey.currentState?.muteOff();
        _soundCKey.currentState?.muteOff();
        _soundDKey.currentState?.muteOff();
        _soundEKey.currentState?.muteOff();
        _soundFKey.currentState?.muteOff();
        _volume = MuteHelper.music;
        _isMute = false;
        notifyListeners();
        CountdownTimer(Constants.musicSwitchDuration, Constants.fadeSmoothDuration).listen((event) {
          final percent = 1 - (event.remaining.inMilliseconds / Constants.musicSwitchDuration.inMilliseconds);
          _setVolume(percent);
        }).onDone(() {
          _muteSwitch = false;
          notifyListeners();
        });
      } else {
        // Need to mute
        MuteHelper.music = _volume;
        _soundAKey.currentState?.muteOn();
        _soundBKey.currentState?.muteOn();
        _soundCKey.currentState?.muteOn();
        _soundDKey.currentState?.muteOn();
        _soundEKey.currentState?.muteOn();
        _soundFKey.currentState?.muteOn();
        _isMute = true;
        notifyListeners();
        CountdownTimer(Constants.musicSwitchDuration, Constants.fadeSmoothDuration).listen((event) {
          final percent = (event.remaining.inMilliseconds / Constants.musicSwitchDuration.inMilliseconds);
          _setVolume(percent);
        }).onDone(() {
          _muteSwitch = false;
          notifyListeners();
        });
      }
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }

  _changeMusicForEffect() {
    _soundAKey.currentState?.switchMusic();
    _soundBKey.currentState?.switchMusic();
    _soundCKey.currentState?.switchMusic();
    _soundDKey.currentState?.switchMusic();
    _soundEKey.currentState?.switchMusic();
    _soundFKey.currentState?.switchMusic();
  }

  _stopMixEffect() {
    _soundAKey.currentState?.stopMixSound();
    _soundBKey.currentState?.stopMixSound();
    _soundCKey.currentState?.stopMixSound();
    _soundDKey.currentState?.stopMixSound();
    _soundEKey.currentState?.stopMixSound();
    _soundFKey.currentState?.stopMixSound();
  }

  _setMixVolume() {
    _soundAKey.currentState?.setMixVolume(_mixAVolume);
    _soundBKey.currentState?.setMixVolume(_mixBVolume);
    _soundCKey.currentState?.setMixVolume(_mixCVolume);
    _soundDKey.currentState?.setMixVolume(_mixDVolume);
    _soundEKey.currentState?.setMixVolume(_mixEVolume);
    _soundFKey.currentState?.setMixVolume(_mixFVolume);
  }

  _endOfMusic() {
    _stopAllMusic();
    _reachedEnd = true;
  }

  _stopAllMusic() async {
    try {
      _stopMixEffect();
      if (_musicSwitch) {
        await Helper.sleep(Constants.musicSwitchDuration.inSeconds * 2);
      }
      if (_playing) {
        if (_isMute) {
          musicPlayer.pause();
        } else {
          double currentVolume = musicPlayer.volume;
          CountdownTimer(Constants.musicSwitchDuration, Constants.fadeSmoothDuration).listen((event) {
            final percent = (event.remaining.inMilliseconds / Constants.musicSwitchDuration.inMilliseconds);
            _setVolume(percent);
          }).onDone(() {
            musicPlayer.pause();
            _setVolume(currentVolume);
          });
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }

  _clearAllMusic() async {
    try {
      _stopMixEffect();
      if (_musicSwitch) {
        await Helper.sleep(Constants.musicSwitchDuration.inSeconds * 2);
      }
      if (_playing) {
        CountdownTimer(Constants.musicSwitchDuration, Constants.fadeSmoothDuration).listen((event) {
          if (!_isMute) {
            final percent = (event.remaining.inMilliseconds / Constants.musicSwitchDuration.inMilliseconds);
            _setVolume(percent);
          }
        }).onDone(() {
          musicPlayer.stop().then((value) => _clearAllVariants());
        });
      } else {
        musicPlayer.stop().then((value) => _clearAllVariants());
      }
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }

  _clearAllVariants() {
    if(_isMute){
      muteHandler();
    }
    _isInit = false;
    _currentMusicIndex = 0;
    _musics = [];
    _volume = 0;
    _playing = true;
    _isMute = false;
    _isLooping = false;
    _titleEnable = false;
    _musicTitle = "";

    notifyListeners();
    _loadMusic();
    _initMusic();
  }

  @override
  void dispose() {
    musicPlayer.dispose();
    _playWatchTimer.dispose();
    _sleepWatchTimer?.dispose();
    positionStream?.cancel();
    indexStream?.cancel();
    durationStream?.cancel();
    playingStream?.cancel();
    super.dispose();
  }

  switchTitle() async {
    _titleEnable = false;
    notifyListeners();
    await Helper.sleepWithMilliseconds(500);
    _musicTitle = _musics[_currentMusicIndex].title;
    _titleEnable = true;
    notifyListeners();
  }

  Future<void> _setVolume(double volume) async {
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
      await musicPlayer.setVolume(volume);
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }

  togglePlay() {
    try {
      if (_musicSwitch) return;
      if (_reachedEnd) {
        _reachedEnd = false;
        initState(_playingMode);
      } else {
        if (_playing) {
          musicPlayer.pause();
        } else {
          musicPlayer.play();
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }

  toggleLoop() {
    _isLooping = !isLooping;
    notifyListeners();
  }

  setVolume(double value) {
    _volume = value;
    _setVolume(value);
    notifyListeners();
  }

  onSleepTimerHandler(BuildContext context) {
    FocusScope.of(context).requestFocus(FocusNode());
    showModalBottomSheet(
      context: context,
      elevation: 10,
      isScrollControlled: true,
      enableDrag: false,
      useSafeArea: true,
      constraints: BoxConstraints(maxHeight: 1.sh, minHeight: 1.sh),
      builder: (_) => const SleepTimeBottomSheet(),
    );
  }

  onAddMixHandler(BuildContext context) {
    FocusScope.of(context).requestFocus(FocusNode());
    showModalBottomSheet(
      context: context,
      elevation: 10,
      isScrollControlled: true,
      enableDrag: true,
      useSafeArea: true,
      shape: RoundedRectangleBorder(
        side: BorderSide(color: Colors.black.withOpacity(0.2)),
        borderRadius: BorderRadius.only(topLeft: Radius.circular(25.w), topRight: Radius.circular(25.w)),
      ),
      builder: (_) => Padding(
        padding: MediaQuery.of(context).viewInsets,
        child: AddMixBottomSheet(
          music: _musics[_currentMusicIndex],
          volume: _volume,
          mix_A_volume: isPurchased ? soundAKey.currentState?.getVolume() ?? 0 : 0,
          mix_B_volume: soundBKey.currentState?.getVolume() ?? 0,
          mix_C_volume: isPurchased ? soundCKey.currentState?.getVolume() ?? 0 : 0,
          mix_D_volume: isPurchased ? soundDKey.currentState?.getVolume() ?? 0 : 0,
          mix_E_volume: soundEKey.currentState?.getVolume() ?? 0,
          mix_F_volume: isPurchased ? soundFKey.currentState?.getVolume() ?? 0 : 0,
        ),
      ),
    ).then((value) {
      if (value != null) {
        onCreatePlaylistHandler(value, context);
      }
    });
  }

  onCreatePlaylistHandler(int mixID, BuildContext context) {
    FocusScope.of(context).requestFocus(FocusNode());
    showModalBottomSheet(
      context: context,
      elevation: 10,
      isScrollControlled: true,
      enableDrag: true,
      useSafeArea: true,
      constraints: BoxConstraints(maxHeight: 1.sh, minHeight: 1.sh),
      shape: RoundedRectangleBorder(
        side: BorderSide(color: Colors.black.withOpacity(0.2)),
        borderRadius: BorderRadius.only(topLeft: Radius.circular(25.w), topRight: Radius.circular(25.w)),
      ),
      builder: (_) => CreatePlaylistBottomSheet(mixID: mixID),
    ).then((value) {
      if (value == null) {
        HiveHelper.removeMix(mixID);
      }
    });
  }

  startSleepTimer(int minutes) {
    if (_sleepWatchTimer != null) {
      _sleepWatchTimer!.onStopTimer();
      _sleepWatchTimer = null;
    }
    _sleepWatchTimer = StopWatchTimer(
        mode: StopWatchMode.countDown,
        presetMillisecond: minutes * 1000 * 60,
        onEnded: () {
          _stopAllMusic();
          _sleepWatchTimer = null;
        });
    _sleepWatchTimer!.onStartTimer();
    notifyListeners();
    Helper.showToast("Sleep Timer started!", true);
  }

  stopSleepTimer() {
    if (_sleepWatchTimer != null) {
      _sleepWatchTimer!.onStopTimer();
      _sleepWatchTimer = null;
    }
    notifyListeners();
  }

  //---------------- SETTER: DO NOT EDIT THIS PART------------------------------

  bool get isInit => _isInit;

  List<MixHive> get musics => _musics;

  int get currentMusicIndex => _currentMusicIndex;

  bool get musicSwitch => _musicSwitch;

  get playWatchTimer => _playWatchTimer;

  get sleepWatchTimer => _sleepWatchTimer;

  String get musicTitle => _musicTitle;

  bool get titleEnable => _titleEnable;

  bool get playing => _playing;

  bool get isMute => _isMute;

  double get volume => _volume;

  bool get isLooping => _isLooping;

  GlobalKey<SoundPanelState> get soundAKey => _soundAKey;

  GlobalKey<SoundPanelState> get soundBKey => _soundBKey;

  GlobalKey<SoundPanelState> get soundCKey => _soundCKey;

  GlobalKey<SoundPanelState> get soundDKey => _soundDKey;

  GlobalKey<SoundPanelState> get soundEKey => _soundEKey;

  GlobalKey<SoundPanelState> get soundFKey => _soundFKey;

  int get playingMode => _playingMode;
}
