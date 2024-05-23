import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:injectable/injectable.dart';
import 'package:insuranceapp/core/constants/constant.dart';
import 'package:insuranceapp/core/extensions/either_extension.dart';
import 'package:insuranceapp/core/models/send_message.dart';
import 'package:insuranceapp/core/utils/app_navigator.dart';
import 'package:insuranceapp/features/support/domain/usecases/user_cancel_usecase.dart';
import 'package:location/location.dart';

import '../../../../../core/constants/api_path.dart';
import '../../../../../core/models/response_data.dart';
import '../../../../../core/models/sos_message.dart';
import '../../../../../core/models/ticket.dart';
import '../../../../../core/models/user.dart';
import '../../../../../core/usecases/no_params.dart';
import '../../../../../core/utils/utils.dart';
import '../../../../app/domain/usecases/get_user_local_usecase.dart';
import '../../../../home/domain/usecases/upload_file_usecase.dart';
import '../../../../maps/domain/usecases/get_calculate_distance_usecase.dart';
import '../../../../maps/domain/usecases/get_current_location_usecase.dart';
import '../../../domain/usecases/get_message_stream_usecase.dart';
import '../../../domain/usecases/get_ticket_info_usecase.dart';
import '../../../domain/usecases/send_message_usecase.dart';

part 'chat_cubit.freezed.dart';
part 'chat_state.dart';

@injectable
class ChatCubit extends Cubit<ChatState> {
  final GetMessageStreamUsecase _getMessageStreamUsecase;
  final GetUserLocalUsecase _getUserLocalUsecase;
  final SendMessageUsecase _sendMessageUsecase;
  final GetTicketInfoUsecase _getTicketInfoUsecase;
  final GetCurrentLocationUsecase _getCurrentLocationUsecase;
  final GetCalculateDistanceUsecase _calculateDistanceUsecase;
  final UploadFileUsecase _uploadFileUsecase;
  final UserCancelUsecase _userCancelUsecase;
  late ScrollController scrollController;
  late TextEditingController messageTextController;
  late FocusNode focusNode;
  late Completer<GoogleMapController> mapController;
  late ImagePicker _picker;
  ChatCubit(
    this._getMessageStreamUsecase,
    this._getUserLocalUsecase,
    this._sendMessageUsecase,
    this._getTicketInfoUsecase,
    this._getCurrentLocationUsecase,
    this._calculateDistanceUsecase,
    this._uploadFileUsecase,
    this._userCancelUsecase,
  ) : super(const ChatState()) {
    scrollController = ScrollController();
    messageTextController = TextEditingController();
    focusNode = FocusNode();
    mapController = Completer();
    _picker = ImagePicker();

    focusNode.addListener(() async {
      if (focusNode.hasFocus) {
        await Future.delayed(const Duration(seconds: 1), () {
          scrollController.animateTo(scrollController.position.maxScrollExtent,
              duration: const Duration(milliseconds: 300), curve: Curves.ease);
        });
      }
    });

    messageTextController.addListener(() {
      if (messageTextController.text.isNotEmpty) {
        emit(state.copyWith(canSend: true, status: DataStatus.success));
      } else {
        emit(state.copyWith(canSend: false));
      }
    });
  }

  StreamController<List<SOSMessage>>? _getMessageController;
  StreamSubscription<List<SOSMessage>>? _getMessageSubcription;

  Future<void> getCurrentuser() async {
    final currentuser = _getUserLocalUsecase(NoParams());
    emit(state.copyWith(currentUser: currentuser));
  }

  void getMessageStream(int? ticketId) {
    emit(state.copyWith(status: DataStatus.loading));
    if (_getMessageController != null) {
      _getMessageController?.close();
    }
    _getMessageController = StreamController<List<SOSMessage>>();

    try {
      final messageStream = _getMessageStreamUsecase(
          GetMessageParams(_getMessageController!, ticketId));
      if (_getMessageSubcription != null) {
        _getMessageSubcription?.cancel();
      }
      _getMessageSubcription = messageStream.listen((message) {
        if (message != state.listMessage) {
          emit(
              state.copyWith(status: DataStatus.success, listMessage: message));
        }
      });
    } catch (e) {
      close();
      emit(state.copyWith(status: DataStatus.failure, error: e.toString()));
    }
  }

  Future<void> getTicketDetail(Ticket ticket) async {
    emit(state.copyWith(ticket: ticket, status: DataStatus.loading));
    final ticketInfo = await _getTicketInfoUsecase(ticket.ticketId);
    if (ticketInfo.isLeft()) {
      emit(state.copyWith(
          status: DataStatus.failure, error: ticketInfo.getLeft()?.msg));
    } else {
      if (super.isClosed) return;
      final ticket = ticketInfo.getRight();
      emit(state.copyWith(ticket: ticket, status: DataStatus.success));
    }
  }

  bool isUserMessage({int? userId}) {
    print("#### UserId ${state.currentUser?.id}");
    return state.currentUser?.id == userId;
  }

  void liveLocation() async{
    Location location = Location();
    await location.enableBackgroundMode(enable: true);
    await location.changeNotificationOptions(
      title: 'Geolocation',
      subtitle: 'Geolocation detection',
    );
    location.onLocationChanged.listen((LocationData currentLocation) {
  // Use current location
        print(currentLocation);
    });
  }

  Future<void> sendMessage({
    int? receiverId,
    int? ticketId,
    MessageType messageType = MessageType.TEXT,
    String? imageUrl,
  }) async {
    SendMessage message = SendMessage(
        senderId: state.currentUser?.id,
        receiverId: receiverId,
        ticketId: ticketId,
        message: messageTextController.text,
        messageType: messageType.name,
        lat: state.currentLocation?.latitude,
        lng: state.currentLocation?.longitude,
        image: imageUrl);

    List<SOSMessage> stateMessage = List.of(state.listMessage ?? []);

    SOSMessage sosMessage = SOSMessage(
        message: message.message,
        reveiverId: message.receiverId,
        senderId: message.senderId,
        ticketId: message.ticketId,
        createdAt: DateTime.now(),
        sender: state.currentUser,
        messageType: MessageType.TEXT.name,
        lat: state.currentLocation?.latitude,
        lng: state.currentLocation?.longitude,
        image: imageUrl);
    stateMessage.add(sosMessage);

    //Clear textfiled message
    messageTextController.clear();

    emit(state.copyWith(listMessage: stateMessage));
    final sent = await _sendMessageUsecase(message);
    if (sent.isLeft()) {
      emit(state.copyWith(status: DataStatus.failure));
    } else {
      emit(state.copyWith(status: DataStatus.success));
    }
  }

  void scrollToEnd() {
    SchedulerBinding.instance.addPostFrameCallback((_) {
      if (scrollController.hasClients) {
        scrollController.animateTo(
          scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 200),
          curve: Curves.easeOut,
        );
      }
    });
  }

  Future<void> getCurrentLocation() async {
    emit(state.copyWith(status: DataStatus.loading));
    final currentLocation = await _getCurrentLocationUsecase(NoParams());
    if (currentLocation.isLeft()) {
      emit(state.copyWith(
          status: DataStatus.failure, error: currentLocation.getLeft()?.msg));
    } else {
      if (super.isClosed) return;
      emit(state.copyWith(
        currentLocation: currentLocation.getRight(),
        status: DataStatus.success,
      ));
    }
  }

  Future<void> getLocationDistance() async {
    final distance = await _calculateDistanceUsecase(
      GetCalculateDistanceParams(
          distantLat: state.ticket?.sosInfo?.lat ?? 0,
          distantLong: state.ticket?.sosInfo?.lng ?? 0),
    );
    if (distance.isLeft()) {
      emit(state.copyWith(
          status: DataStatus.failure,
          error: distance.getLeft()?.msg,
          distance: 0));
    } else {
      final dis = Utils.calculateKm(distance.getRight() ?? 0);
      if (super.isClosed) return;
      emit(state.copyWith(distance: dis));
    }
  }

  Future<void> currentPosition() async {
    final GoogleMapController controller = await mapController.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(
      CameraPosition(
        bearing: 0,
        target: LatLng(state.currentLocation?.latitude ?? 0,
            state.currentLocation?.longitude ?? 0),
        zoom: 16.0,
      ),
    ));
  }

  Future<void> getImage(ImageSource source) async {
    final pcikedFile = await _picker.pickImage(source: source);
    if (pcikedFile != null) {
      final File file = File(pcikedFile.path);
      final upload = await _uploadFileUsecase(file);
      if (upload.isLeft()) {
        emit(state.copyWith(
            status: DataStatus.failure, error: upload.getLeft()?.msg));
      } else {
        final ResponseData? data = upload.getRight();
        final String urlImage = "${APIPath.publicUrl}/${data?.name}";
        await sendMessage(
          ticketId: state.ticket?.ticketId,
          receiverId: state.ticket?.sosInfo?.user?.id,
          messageType: MessageType.FILE,
          imageUrl: urlImage,
        );
      }
    } else {
      print("No file");
    }
  }

  Future<void> userCanel({required int ticketId}) async {
    emit(state.copyWith(status: DataStatus.loading));
    final result = await _userCancelUsecase(ticketId);
    if (result.isLeft()) {
      emit(
        state.copyWith(
            status: DataStatus.failure, error: result.getLeft()?.msg),
      );
    } else {
      AppNavigator.goBack();
    }
  }

  @override
  Future<void> close() async {
    await _getMessageController?.close();
    await _getMessageSubcription?.cancel();
    messageTextController.dispose();
    scrollController.dispose();
    return super.close();
  }
}
