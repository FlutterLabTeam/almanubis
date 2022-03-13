import 'dart:io';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart' show DateFormat;
import 'package:flutter_sound/flutter_sound.dart';
import 'package:audio_session/audio_session.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:almanubis/core/model/chat_model.dart';
import 'package:almanubis/core/bloc/global_bloc.dart';
import 'package:almanubis/core/model/user_model.dart';
import 'package:almanubis/core/model/group_model.dart';
import 'package:almanubis/core/util/snack_bar_message.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:almanubis/core/components/noData/no_data.dart';
import 'package:almanubis/core/data/model/image_quality_model.dart';
import 'package:almanubis/core/components/header_chat/header_chat.dart';
import 'package:almanubis/core/components/custom_chat/custom_chat.dart';
import 'package:almanubis/core/components/panel_widget/panel_widget.dart';
import 'package:almanubis/features/chat_group/data/models/audio_model.dart';
import 'package:almanubis/features/chat_group/data/models/element_to_download.dart';
import 'package:almanubis/features/chat_group/presentation/widgets/chat_input.dart';
import 'package:almanubis/features/chat_group/presentation/bloc/chat_group_bloc.dart';
import 'package:almanubis/features/chat_group/presentation/widgets/audio_input_option.dart';
import 'package:flutter_sound_platform_interface/flutter_sound_recorder_platform_interface.dart';
import 'package:almanubis/features/information_panel_groups/presentation/pages/information_panel_groups.dart';
import 'package:almanubis/core/components/custom_circular_progress_indicator/custom_circular_progress_indicator.dart';

class ChatGroupModel {
  final UserModel? userModel;
  final GroupModel? groupModel;

  ChatGroupModel({
    this.userModel,
    this.groupModel,
  });
}

class ChatGroup extends StatefulWidget {
  final ChatGroupModel model;

  const ChatGroup({
    Key? key,
    required this.model,
  }) : super(key: key);

  @override
  _ChatGroupState createState() => _ChatGroupState();
}

class _ChatGroupState extends State<ChatGroup> {
  late Size size;
  late String _mPath;
  late String path = "";
  late bool isSend = false;
  late bool isAssets = false;
  late bool isPlayingAudio = true;
  late int assetMilliseconds = 0;
  late bool isStream = false;
  late bool loadingButton = false;
  late List<String> listPath = [];
  late String _typeAssetsChat = "";
  late bool isSubmitHandled = true;
  String _recorderTxt = '00:00:00';
  final Codec _codec = Codec.aacMP4;
  late List<ChatModel> listChats = [];
  late Stream<QuerySnapshot> dataStream;
  final theSource = AudioSource.microphone;
  static late ElementToDownload elementToSelected;
  final FlutterSoundPlayer _mPlayer = FlutterSoundPlayer();
  final FlutterSoundRecorder _mRecorder = FlutterSoundRecorder();
  late TextEditingController controller = TextEditingController();
  static late ChatInputType chatInputType = ChatInputType.textOption;
  static late AudioInputState audioInputState = AudioInputState.recording;

  @override
  void initState() {
    super.initState();
    _mPlayer.openPlayer();
    openTheRecorder();
    elementToSelected = ElementToDownload.image;
    BlocProvider.of<ChatGroupBloc>(context)
        .add(GetChatStreamEvent(idGroup: widget.model.groupModel!.id!));
  }

  Future<void> generatePath() async {
    final Directory dir = await getApplicationDocumentsDirectory();
    _mPath = dir.path +
        "/" +
        DateTime.now().millisecondsSinceEpoch.toString() +
        '.aac';
  }

  @override
  void dispose() {
    super.dispose();
    isStream = false;
    _mPlayer.closePlayer();
    _mRecorder.closeRecorder();
    _mRecorder.closeRecorder();
  }

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    return BlocListener<GlobalBloc, GlobalState>(
      listener: (context, state) {
        if (state is DownloadAssetsLoadingState) {
          snackBarMessage(context,
              message: "Descargando ${state.assetsImage}...");
        }
        if (state is DownloadAssetsErrorState) {
          snackBarMessage(context,
              message: "Ha fallado la descarga de la ${state.assetsImage}.");
        }
        if (state is DownloadAssetsState) {
          snackBarMessage(context,
              message: "La ${state.assetsImage} fue descargada exitosamente.");
          BlocProvider.of<ChatGroupBloc>(context).add(InitBlocEvent());
        }
      },
      child: SafeArea(
        child: Scaffold(
          body: BlocBuilder<ChatGroupBloc, ChatGroupState>(
            builder: (context, state) {
              if (state is GetChatGroupStreamState) {
                dataStream = state.stream;
                isStream = true;
              }
              if (state is CreateChatState) {
                createMessage();
              }
              if (state is CreateChatErrorState) {
                createMessage();
              }
              if (state is CreateChatLoadingState) {
                createMessage();
              }
              if (state is SaveAudioState) {
                isAssets = true;
                path = state.path;
                _typeAssetsChat = "AUDIO";
                chatInputType = ChatInputType.textOption;
                audioInputState = AudioInputState.recording;
                handledSaveMessage();
              }
              if (state is SaveVideoState) {
                listPath = [];
                isAssets = true;
                path = state.path;
                loadingButton = false;
                _typeAssetsChat = "VIDEO";
                chatInputType = ChatInputType.textOption;
                handledSaveMessage();
              }
              return Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  HeaderChat(
                    model: HeaderChatModel(
                        image: widget.model.groupModel!.image,
                        title: widget.model.groupModel!.title,
                        description: widget.model.groupModel!.description,
                        handledMenu: () => draggableBottomPanel(
                              context: context,
                              handledTapItem: (e) {},
                              body: InformationPanelGroups(
                                model: InformationPanelGroupsModel(
                                  userModel: widget.model.userModel,
                                  typeUser:
                                      widget.model.userModel!.rol == "USER"
                                          ? InformationPanelGroupsEnum.user
                                          : InformationPanelGroupsEnum.admin,
                                  groupModel: widget.model.groupModel,
                                ),
                              ),
                            )),
                  ),
                  Flexible(
                    fit: FlexFit.tight,
                    flex: 1,
                    child: isStream
                        ? StreamBuilder(
                            stream: dataStream,
                            builder: (BuildContext context,
                                AsyncSnapshot<QuerySnapshot> snapShot) {
                              bool pause = _mPlayer.isPaused;
                              if ((snapShot.hasData && pause) ||
                                  (snapShot.hasData && isPlayingAudio)) {
                                handledMapData(snapShot.data!);
                              }
                              return listChats.isNotEmpty
                                  ? ListView.builder(
                                      reverse: true,
                                      shrinkWrap: true,
                                      itemCount: listChats.length,
                                      itemBuilder:
                                          (BuildContext context, int index) {
                                        ChatModel chat = listChats[index];
                                        return Container(
                                          margin: const EdgeInsets.symmetric(
                                            vertical: 5,
                                          ),
                                          padding: EdgeInsets.symmetric(
                                            horizontal: size.width * 0.05,
                                          ),
                                          child: CustomChat(
                                            model: CustomChatModel(
                                              color: chat.idUserCreate ==
                                                      widget
                                                          .model.userModel!.uid!
                                                  ? CustomChatColor.light
                                                  : CustomChatColor.dark,
                                              chatModel: chat,
                                              playAudio: playAudio,
                                              downloadImage: downloadImage,
                                              downloadAudio: downloadAudio,
                                              downloadVideo: downloadVideo,
                                            ),
                                          ),
                                        );
                                      },
                                    )
                                  : Container(
                                      margin: EdgeInsets.symmetric(
                                        vertical: size.height * 0.12,
                                      ),
                                      child: const NoData(),
                                    );
                            },
                          )
                        : const Center(
                            child: CustomCircularProgressIndicator()),
                  ),
                  BlocBuilder<GlobalBloc, GlobalState>(
                      builder: (context, state) {
                    if (state is TakeImageState) {
                      listPath = [state.path];
                      BlocProvider.of<GlobalBloc>(context).add(DisposeEvent());
                    }
                    if (state is SaveImageState) {
                      listPath = [];
                      path = state.link;
                      loadingButton = false;
                      _typeAssetsChat = "IMAGE";
                      handledSaveMessage();
                      BlocProvider.of<GlobalBloc>(context).add(DisposeEvent());
                    }
                    if (state is TakeVideoState) {
                      listPath = [state.path];
                      BlocProvider.of<GlobalBloc>(context).add(DisposeEvent());
                    }
                    return ChatInput(
                      isSend: isSend,
                      mediaList: listPath,
                      saveAudio: saveAudio,
                      saveVideo: saveVideo,
                      counter: _recorderTxt,
                      controller: controller,
                      loadingButton: loadingButton,
                      typeInputChat: chatInputType,
                      audioInputState: audioInputState,
                      handledTapOption: handledTapOption,
                      handledPlayAudio: handledPlayAudio,
                      elementToDownload: elementToSelected,
                      handledDeleteAudio: handledDeleteAudio,
                      handledChangeInput: handledChangeInput,
                      handledDeleteImage: handledDeleteImage,
                      handledListenAudio: handledListenAudio,
                      handledStopRecorder: handledStopRecorder,
                      handledTapCamara: () => handledTakeImage(isPhoto: true),
                      handledSubmitChat: () {
                        listPath.isNotEmpty
                            ? saveImage()
                            : handledSaveMessage();
                      },
                    );
                  })
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  handledMapData(QuerySnapshot data) {
    listChats =
        data.docs.map((e) => ChatModel.fromJson(e.data(), e.id)).toList();
    listChats.sort((a, b) => b.dateCreate.compareTo(a.dateCreate));
    List<ChatModel> listChatsFilter = listChats
        .where((element) =>
            element.listUserReceiver.contains(widget.model.userModel!.uid!))
        .toList();
    List<String> listChatId = listChatsFilter.map((e) => e.id!).toList();
    if (listChatId.isNotEmpty) {
      BlocProvider.of<ChatGroupBloc>(context).add(
        ReadingChatEvent(
          listIdChat: listChatId,
          userId: widget.model.userModel!.uid!,
        ),
      );
    }
  }

  handledSaveMessage() {
    if ((controller.text.isNotEmpty && isSubmitHandled) || isAssets) {
      isSubmitHandled = false;
      List<String> listUser = [];
      listUser = widget.model.groupModel!.listUser.map((e) => e.uid!).toList();

      BlocProvider.of<ChatGroupBloc>(context).add(
        CreateChatEvent(
          chatModel: ChatModel(
            dataAsset: AssetModel(
              urlAsset: path,
              typeAsset: _typeAssetsChat,
              millisecondTime: assetMilliseconds,
            ),
            listUserViewed: [],
            label: controller.text,
            dateCreate: DateTime.now(),
            listUserReceiver: listUser,
            idGroup: widget.model.groupModel!.id!,
            nameUser: widget.model.userModel!.name,
            imageUser: widget.model.userModel!.image!,
            idUserCreate: widget.model.userModel!.uid!,
          ),
        ),
      );
    }
  }

  handledChangeInput(String text) {
    isSend = text.isNotEmpty;
    BlocProvider.of<ChatGroupBloc>(context).add(InitBlocEvent());
  }

  handledDeleteImage(String text) {
    listPath.removeWhere((element) => element == text);
    BlocProvider.of<ChatGroupBloc>(context).add(InitBlocEvent());
    BlocProvider.of<GlobalBloc>(context).add(DisposeEvent());
  }

  handledTakeImage({required bool isPhoto}) {
    elementToSelected = ElementToDownload.image;
    BlocProvider.of<GlobalBloc>(context).add(
      TakeImageEvent(
        imageQualityModel: ImageQualityModel(size: ImageSizeEnum.xxl),
        isPhoto: isPhoto,
      ),
    );
  }

  saveImage() {
    loadingButton = true;
    isAssets = true;
    BlocProvider.of<GlobalBloc>(context).add(
      SaveImageEvent(
        folderDB: "imageChat",
        path: listPath[0],
      ),
    );
  }

  saveVideo() {
    loadingButton = true;
    BlocProvider.of<ChatGroupBloc>(context).add(
      SaveVideoEvent(
        file: File(listPath[0]),
      ),
    );
  }

  downloadImage(String url) => BlocProvider.of<GlobalBloc>(context).add(
        DownloadAssetsEvent(
          path: url,
          folderDB: "imageChat",
        ),
      );

  downloadAudio(String url) => BlocProvider.of<GlobalBloc>(context).add(
        DownloadAssetsEvent(
          path: url,
          folderDB: "audio",
          assetsName: "audio",
        ),
      );

  downloadVideo(String url) => BlocProvider.of<GlobalBloc>(context).add(
        DownloadAssetsEvent(
          path: url,
          folderDB: "video",
        ),
      );

  handledDeleteAudio() async {
    await _mRecorder.stopRecorder();
    audioInputState = AudioInputState.recording;
    chatInputType = ChatInputType.textOption;
    BlocProvider.of<ChatGroupBloc>(context).add(InitBlocEvent());
  }

  handledStopRecorder() async {
    await _mRecorder.stopRecorder();
    audioInputState = AudioInputState.slow;
    BlocProvider.of<ChatGroupBloc>(context).add(InitBlocEvent());
  }

  handledPlayAudio() async {
    chatInputType = ChatInputType.audioOption;
    audioInputState = AudioInputState.recording;
    await generatePath();
    BlocProvider.of<ChatGroupBloc>(context).add(InitBlocEvent());
    timeRecorder();
    await _mRecorder.startRecorder(
      codec: _codec,
      toFile: _mPath,
      audioSource: theSource,
    );
  }

  handledListenAudio() {
    if (_mPlayer.isPlaying) {
      stopPlayer();
    } else {
      play();
    }
  }

  void play() async {
    assert(_mRecorder.isStopped && _mPlayer.isStopped);
    audioInputState = AudioInputState.listening;
    BlocProvider.of<ChatGroupBloc>(context).add(InitBlocEvent());
    await _mPlayer.startPlayer(
        fromURI: _mPath,
        whenFinished: () {
          audioInputState = AudioInputState.slow;
          BlocProvider.of<ChatGroupBloc>(context).add(InitBlocEvent());
        });
  }

  void stopPlayer() async {
    await _mPlayer.stopPlayer();
    audioInputState = AudioInputState.slow;
    BlocProvider.of<ChatGroupBloc>(context).add(InitBlocEvent());
  }

  Future<void> openTheRecorder() async {
    if (!kIsWeb) {
      var status = await Permission.microphone.request();
      if (status != PermissionStatus.granted) {
        throw RecordingPermissionException('Microphone permission not granted');
      }
    }
    await _mRecorder.openRecorder();
    await initializeDateFormatting();
    _mRecorder.setSubscriptionDuration(const Duration(milliseconds: 10));
    final session = await AudioSession.instance;
    await session.configure(AudioSessionConfiguration(
      avAudioSessionCategory: AVAudioSessionCategory.playAndRecord,
      avAudioSessionCategoryOptions:
          AVAudioSessionCategoryOptions.allowBluetooth |
              AVAudioSessionCategoryOptions.defaultToSpeaker,
      avAudioSessionMode: AVAudioSessionMode.spokenAudio,
      avAudioSessionRouteSharingPolicy:
          AVAudioSessionRouteSharingPolicy.defaultPolicy,
      avAudioSessionSetActiveOptions: AVAudioSessionSetActiveOptions.none,
      androidAudioAttributes: const AndroidAudioAttributes(
        contentType: AndroidAudioContentType.speech,
        flags: AndroidAudioFlags.none,
        usage: AndroidAudioUsage.voiceCommunication,
      ),
      androidAudioFocusGainType: AndroidAudioFocusGainType.gain,
      androidWillPauseWhenDucked: true,
    ));
  }

  timeRecorder() async {
    _mRecorder.onProgress!.listen((e) {
      assetMilliseconds = e.duration.inMilliseconds;
      var date = DateTime.fromMillisecondsSinceEpoch(
        e.duration.inMilliseconds,
        isUtc: true,
      );
      var txt = DateFormat('mm:ss:SS', 'en_GB').format(date);
      _recorderTxt = txt.substring(0, 8);
      BlocProvider.of<ChatGroupBloc>(context).add(InitBlocEvent());
    });
  }

  saveAudio() async {
    await handledStopRecorder();
    loadingButton = true;
    audioInputState = AudioInputState.slow;
    BlocProvider.of<ChatGroupBloc>(context)
        .add(SaveAudioEvent(file: File(_mPath)));
  }

  createMessage() {
    path = "";
    isAssets = false;
    controller.text = "";
    _typeAssetsChat = "";
    assetMilliseconds = 0;
    isSubmitHandled = true;
    loadingButton = false;
    BlocProvider.of<ChatGroupBloc>(context).add(InitBlocEvent());
  }

  void playAudio(ChatModel chatModel) async {
    _mPlayer.openPlayer();
    await _mPlayer.setSubscriptionDuration(const Duration(milliseconds: 10));
    await _mPlayer.startPlayer(
        fromURI: chatModel.dataAsset.urlAsset,
        whenFinished: () {
          listChats.map((e) {
            if (e.id == chatModel.id) {
              e.dataAsset.counted = 0;
            }
            return e;
          }).toList();
          BlocProvider.of<ChatGroupBloc>(context).add(InitBlocEvent());
        });
    timeRecorderPlay(chatModel);
  }

  timeRecorderPlay(ChatModel chatModel) async {
    BlocProvider.of<ChatGroupBloc>(context).add(InitBlocEvent());
    isPlayingAudio = false;
    _mPlayer.onProgress!.listen((e) {
      int count = chatModel.dataAsset.counted! + 10;
      listChats = listChats.map((e) {
        if (e.id == chatModel.id) {
          e.dataAsset.counted = count;
        }
        return e;
      }).toList();
      BlocProvider.of<ChatGroupBloc>(context).add(InitBlocEvent());
    });
  }

  handledTapOption(e) {
    if (e == Icons.image) {
      handledTakeImage(isPhoto: false);
    } else {
      elementToSelected = ElementToDownload.video;
      BlocProvider.of<GlobalBloc>(context).add(TakeVideoEvent());
    }
  }
}
