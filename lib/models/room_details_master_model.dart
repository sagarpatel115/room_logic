import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class RoomDetailsMasterModel{
  int mnRoomId;
  String msRoomName;
  TextEditingController mcAdultTextEditingCntrl;
  TextEditingController mcChildTextEditingCntrl;
  GlobalKey<FormState> mcFormKey;
  List<GuestDetailsModel>? mlGuestDetailsModelList = [];
  RoomDetailsMasterModel(
      { required this.mnRoomId,
        required this.msRoomName,
        required this.mcAdultTextEditingCntrl,
        required this.mcChildTextEditingCntrl,
        required this.mcFormKey,
        this.mlGuestDetailsModelList
      });
}

class GuestDetailsModel{
  GuestType? meGuestType;
  TextEditingController? mcGuestNameTextEditingCntrl;
  TextEditingController? mcGuestAgeTextEditingCntrl;
  GlobalKey<FormState>? mcFormKey;
  GuestDetailsModel(
  {
    required this.meGuestType,
    required this.mcGuestAgeTextEditingCntrl,
    required this.mcGuestNameTextEditingCntrl,
    required this.mcFormKey
  });
}

enum GuestType{
  adult,
  child
}

extension GuestTypeName on GuestType {
  String get name => describeEnum(this);
}

// extension ParseToString on GuestType {
//   String toShortString() {
//     return this.toString().split('.').last;
//   }
// }