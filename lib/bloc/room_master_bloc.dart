import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:untitled1/models/room_details_master_model.dart';

part 'room_master_event.dart';
part 'room_master_state.dart';

class RoomMasterBloc extends Bloc<RoomMasterEvent, RoomMasterState> {

  List<int> mcDropDownItem = [1,2,3,4,5];
  int mnSelectedItem =1;
  List<RoomDetailsMasterModel> mlRoomDetailsMasterModelList = [];
  GlobalKey<FormState> mcGuestValidateFormKey = GlobalKey<FormState>();
  int mnGuestDataErrorIndex =-1;

  RoomMasterBloc() : super(RoomMasterInitial()) {
    on<RoomMasterEvent>((event, emit) {

      if(event is ChangeRoomNoEvent){
        changeNoOfRoomFun();
        emit(ChangeRoomNoState());
      }else if(event is AddGuestDetailsEvent){
        if(mnGuestDataErrorIndex == event.index) {mnGuestDataErrorIndex =-1 ;}
        addGuestDetailsFormFun(event.index,event.adultCnt,GuestType.Adult);
        addGuestDetailsFormFun(event.index,event.childCnt,GuestType.Child);
        emit(AddGuestDetailsState());
      }
      // else if(event is ValidateAndSubmitEvent){
      //   validateRoomDataAndSubmit();
      //   emit(ValidateAndSubmitState());
      // }

    });

    on<ValidateAndSubmitEvent>(_validateRoomDataAndSubmit);


  }

  changeNoOfRoomFun(){
    mlRoomDetailsMasterModelList.clear();
    mnGuestDataErrorIndex =-1;
    for(int i=1;i<=mnSelectedItem;i++){
      mlRoomDetailsMasterModelList.add(
          RoomDetailsMasterModel(mnRoomId: i,msRoomName:'Room $i',
              mcAdultTextEditingCntrl: TextEditingController(),
              mcChildTextEditingCntrl: TextEditingController(),
              mcFormKey: GlobalKey<FormState>(),
              mlGuestDetailsModelList: []
          )
      );
    }

  }

  addGuestDetailsFormFun(int pnParentIndex,int pnGuestCnt,peGuestType){
    for(int i=1;i<=pnGuestCnt;i++){
      mlRoomDetailsMasterModelList[pnParentIndex].mlGuestDetailsModelList!.add(
          GuestDetailsModel(
              meGuestType: peGuestType,
              mcGuestAgeTextEditingCntrl: TextEditingController(),
              mcGuestNameTextEditingCntrl: TextEditingController(),
              mcFormKey: GlobalKey<FormState>())
      );
    }
    mlRoomDetailsMasterModelList[pnParentIndex].mlGuestDetailsModelList!.sort((a,b)=>a.meGuestType!.name.compareTo(b.meGuestType!.name));
  }

  FutureOr<void> _validateRoomDataAndSubmit(RoomMasterEvent event, Emitter<RoomMasterState> emit){


    bool isParentForm = mlRoomDetailsMasterModelList.every((element) {

      if(element.mcFormKey.currentState!.validate()){
        return true;
      }else{return false;}
    } );

    final isValid = mcGuestValidateFormKey.currentState!.validate();
    if (isValid && isParentForm) {
      if(isGuestDataEmptyFun()){
        emit(GuestDetailsEmptyErrorState(mnGuestDataErrorIndex:mnGuestDataErrorIndex));
      }
      print(" all is right om namh shivay , jay shree krishna , ganesha");


    }else{
     // return;
    }
    mcGuestValidateFormKey.currentState!.save();

  }

   bool isGuestDataEmptyFun(){
     for(int i=0;i<mlRoomDetailsMasterModelList.length;i++){
       if(mlRoomDetailsMasterModelList[i].mlGuestDetailsModelList!.isEmpty){
         mnGuestDataErrorIndex = i;//mlRoomDetailsMasterModelList.indexOf(element);
         return true;
        }
     }
    return false;
   }

}


