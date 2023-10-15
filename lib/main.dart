import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled1/bloc/room_master_bloc.dart';
import 'package:untitled1/models/room_details_master_model.dart';
import 'package:untitled1/widgtes/app_text_form_field_widget.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  //
  // List<int> mcDropDownItem = [1,2,3,4,5];
  // int mnSelectedItem =1;
  // List<RoomDetailsMasterModel> mlRoomDetailsMasterModelList = [];
  // GlobalKey<FormState> _mcGuestValidateFormKey = GlobalKey<FormState>();
  // void changeNoOfRoomFun(){
  //   mlRoomDetailsMasterModelList.clear();
  //   for(int i=1;i<=mnSelectedItem;i++){
  //     mlRoomDetailsMasterModelList.add(
  //         RoomDetailsMasterModel(mnRoomId: i,msRoomName:'Room $i',
  //             mcAdultTextEditingCntrl: TextEditingController(),
  //             mcChildTextEditingCntrl: TextEditingController(),
  //             mcFormKey: GlobalKey<FormState>(),
  //             mlGuestDetailsModelList: []
  //         )
  //     );
  //   }
  // }
  //
  // void addGuestDetailsFormFun(int pnParentIndex,int pnGuestCnt,peGuestType){
  //   for(int i=1;i<=pnGuestCnt;i++){
  //     mlRoomDetailsMasterModelList[pnParentIndex].mlGuestDetailsModelList!.add(
  //         GuestDetailsModel(
  //             meGuestType: peGuestType,
  //             mcGuestAgeTextEditingCntrl: TextEditingController(),
  //             mcGuestNameTextEditingCntrl: TextEditingController(),
  //             mcFormKey: GlobalKey<FormState>())
  //     );
  //   }
  // }

  RoomMasterBloc? mcRoomMasterBloc;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
         backgroundColor: Theme.of(context).colorScheme.inversePrimary,
         title: Text(widget.title),
      ),
      body: SingleChildScrollView(
        child: BlocProvider<RoomMasterBloc>(
        create: (context) {
          mcRoomMasterBloc = RoomMasterBloc();
          return mcRoomMasterBloc!;
        },
        child: BlocBuilder<RoomMasterBloc, RoomMasterState>(
        builder: (context, state) {
          // if(state is GuestDetailsEmptyErrorState){
          //   GuestDetailsEmptyErrorIndex = state.mnGuestDataErrorIndex;
          // }
          return Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        DropdownButton<int>(
                          elevation: 4,value: mcRoomMasterBloc!.mnSelectedItem,
                            padding: EdgeInsets.all(8),
                            items: mcRoomMasterBloc!.mcDropDownItem.map((e) => DropdownMenuItem<int>(value: e,child: Text(e.toString()),)).toList(),
                            onChanged: (int? val){
                              //setState(() {
                                mcRoomMasterBloc!.mnSelectedItem = val!;
                                mcRoomMasterBloc!.add(ChangeRoomNoEvent());
                                //changeNoOfRoomFun();
                            //  });
                            }),
                        Form(
                          key: mcRoomMasterBloc!.mcGuestValidateFormKey,
                          child: ListView.builder(
                              shrinkWrap: true,
                              itemCount: mcRoomMasterBloc!.mlRoomDetailsMasterModelList.length,
                              physics: NeverScrollableScrollPhysics(),
                              itemBuilder: (context,index){
                                RoomDetailsMasterModel lcmlRoomDetailsMasterModel =mcRoomMasterBloc!. mlRoomDetailsMasterModelList[index];
                                return Container(
                                  margin:EdgeInsets.all(5),
                                   padding: EdgeInsets.symmetric(vertical: 10),
                                   decoration: BoxDecoration(
                                     color: Colors.amber,
                                     border:mcRoomMasterBloc!.mnGuestDataErrorIndex ==index ? Border.all(width: 2,color: Colors.red) : null,
                                   ),
                                   child: Column(children: [
                                     SizedBox(height: 20,child: Text(lcmlRoomDetailsMasterModel.msRoomName)),
                                     Form(
                                       key: lcmlRoomDetailsMasterModel.mcFormKey,
                                       child: SizedBox(
                                         height: 50,
                                         child: Row(children: [
                                           Expanded(child: AppTextFormField(
                                             ctrl: lcmlRoomDetailsMasterModel.mcAdultTextEditingCntrl,
                                             keyboardType: TextInputType.number,
                                             hintText: 'Enter Adult',
                                             validator: (value){
                                                 if (value.isEmpty) {
                                                   return 'Enter a Adult details';
                                                 }
                                                 return null;
                                             },
                                           )),
                                           Expanded(child: AppTextFormField(
                                             ctrl: lcmlRoomDetailsMasterModel.mcChildTextEditingCntrl,
                                             keyboardType: TextInputType.number,
                                             hintText: 'Enter Child',
                                             validator: (value){
                                               if (value.isEmpty) {
                                                 return 'Enter a child';
                                               }
                                               return null;
                                             },
                                           )),
                                           Expanded(child: ElevatedButton(
                                             child: Text('Add'),
                                             onPressed: (){
                                               try{
                                                 if (lcmlRoomDetailsMasterModel.mcFormKey.currentState!.validate()) {
                                                     int adultCnt = int.parse(lcmlRoomDetailsMasterModel.mcAdultTextEditingCntrl.text);
                                                     int childCnt = int.parse(lcmlRoomDetailsMasterModel.mcChildTextEditingCntrl.text);
                                                     mcRoomMasterBloc!.add(AddGuestDetailsEvent(index: index,adultCnt:adultCnt,childCnt: childCnt));
                                                     //lcmlRoomDetailsMasterModel.mlGuestDetailsModelList!.
                                                     // addGuestDetailsFormFun(index,adultCnt,GuestType.Adult);
                                                     // addGuestDetailsFormFun(index,childCnt,GuestType.Child);
                                                     // setState(() { });
                                                 }
                                                }catch(e){
                                                 print(e);
                                               }

                                             },
                                           ))

                                         ],
                                         ),
                                       ),
                                     ),
                                     mcRoomMasterBloc!.mnGuestDataErrorIndex ==index ? Text('Please Add Guest Details to proceed more',style: TextStyle(color: Colors.red),maxLines: 2,) :SizedBox.shrink(),
                                    ListView.builder(
                                        physics: NeverScrollableScrollPhysics(),
                                        shrinkWrap: true,
                                        itemCount: mcRoomMasterBloc!.mlRoomDetailsMasterModelList[index].mlGuestDetailsModelList?.length ?? 0,
                                        itemBuilder: (context,ind){
                                          GuestDetailsModel? lcGuestDetailsModel = mcRoomMasterBloc!.mlRoomDetailsMasterModelList[index].mlGuestDetailsModelList?[ind];
                                          return Column(children: [
                                            SizedBox(height: 20,child: Text(lcGuestDetailsModel?.meGuestType?.name.toString() ?? "")),
                                            SizedBox(
                                              height: 50,
                                              child: Row(children: [
                                                Expanded(child: AppTextFormField(
                                                  ctrl: lcGuestDetailsModel?.mcGuestNameTextEditingCntrl,
                                                  keyboardType: TextInputType.number,
                                                  hintText: 'Enter Name',
                                                  validator: (value){
                                                    if (value.isEmpty) {
                                                      return 'Enter a name';
                                                    }
                                                    return null;
                                                  },
                                                )),
                                                Expanded(child: AppTextFormField(
                                                  ctrl: lcGuestDetailsModel?.mcGuestAgeTextEditingCntrl,
                                                  keyboardType: TextInputType.number,
                                                  hintText: 'Enter Age',
                                                  validator: (value){
                                                    if (value.isEmpty) {
                                                      return 'Enter a age';
                                                    }
                                                    return null;
                                                  },
                                                )),
                                              ],
                                              ),
                                            ),
                                          ],);
                                        }
                                    ),
                                   ],),
                                );
                              }),
                        ),
                        ElevatedButton(onPressed: (){
                          mcRoomMasterBloc!.add(ValidateAndSubmitEvent());
                        }, child: Text('Submit'))
                      ],
                    );
        },
      ),
      ),
      ),
       // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
