import 'package:bugreportingsystem/core/model/api/add_report.dart';
import 'package:bugreportingsystem/core/repository/authentication_repository.dart';
import 'package:bugreportingsystem/core/repository/bug_repository.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_sms/flutter_sms.dart';
import 'package:lil_guid/lil_guid.dart';
import 'add_bug_event.dart';
import 'add_bug_state.dart';

class AddBugBloc extends Bloc<AddBugEvent, AddBugState> {
  late String time;
final BugRepository _bugRepository;
final AuthenticationRepository _authenticationRepository;
  AddBugBloc({
    required BugRepository bugRepository,
    required AuthenticationRepository authenticationRepository,
  })  : _bugRepository = bugRepository,
        _authenticationRepository=authenticationRepository,
        super(AddBugStateSplash());

  @override
  Stream<AddBugState> mapEventToState(AddBugEvent event) async* {
    if (event is AddBugWaitingForEvent) {
      yield await _mapAddBugWaitingForAddBugToState(event);
    }else if (event is AddBugTryEvent) {
      yield* _mapAddBugValueTryEvent(event);
    }else if (event is AddBugValueChangedEvent) {
      yield* _mapAddBugValueChangedToState(event);
    }else if (event is AddBugErrorEvent) {
      yield* _mapAddBugErrorToState(event);
    }
  }
  Future<AddBugState> _mapAddBugWaitingForAddBugToState(AddBugWaitingForEvent event) async {
    return AddBugStateWaitingForAnswer();
  }
  Stream<AddBugState> _mapAddBugValueTryEvent(AddBugTryEvent event) async* {

    var now=DateTime.now();
    time=DateFormat("yyyy-MM-ddTHH:mm:ss","pl").format(now);
    yield AddBugStateInitial();
    try{
      var moduleModelList=await _bugRepository.getModules();
      yield AddBugStateUpdate(
        category: moduleModelList,
      );
    }catch(e){
      yield* _mapAddBugErrorToState(e.toString());
    }
  }

  Stream<AddBugState> _mapAddBugValueChangedToState(AddBugValueChangedEvent event) async* {
    yield AddBugStateInitial();
    try{
      var moduleModelList=await _bugRepository.getModules();
      AddBugStateUpdate(
          category: moduleModelList,
          type: event.type,
          modelResponse: event.modelResponse,
        description: event.description,
        priority: event.priority,
        phoneNumber: event.phoneNumber,
        imeiNumber:event.imei,
      );
      if( event.type!=null && event.modelResponse!=null && event.priority!=null && event.description!=null){
        var phone=await _authenticationRepository.getUserPhoneNumber();
        var person=await _bugRepository.getPersonByPhoneNumber(phone);
        var sim=await _bugRepository.getSimByNumber(phone);
        String id="${Guid.newGuid.toString()}";
        AddReport addReport =new AddReport(
            id: id,
            moduleId: event.modelResponse!.id,
            simId: sim.id,
            email:person.email,
            description:event.description,
            username:'',
            reportNumber: 0,
            simNumber:sim.phoneNumber,//await _authenticationRepository.getUserPhoneNumber(),
            applicantFirstName:person.firstName,
            applicantLastName:person.lastName,
            supervisorId:null,
            supervisorFirstName:'',
            supervisorLastName:'',
            supervisorComment:'',
            supervisorEmail:'',
            supervisorPhoneNumber:'',
            mobileFirstName: await _authenticationRepository.getUserFirstName(),
            mobileLastName: await _authenticationRepository.getUserLastName(),
            mobileIMEI: event.imei,
            mobilePhoneNumber: event.phoneNumber,
            fillFormStartDate: time,
            comments: [],
            redmine: 0,
            type: event.type!,
            priority: event.priority!,
            status: 0,
            fillFormTime: '0',
            source: 'Mobile App');
        await _bugRepository.sendReport(addReport);
        List<String> recipents = ["513877458"];
         _sendSMS('zgloszenie ${id}',recipents);
      }
      yield AddBugStateWaitingForAnswer();
    }catch(e){
      yield* _mapAddBugErrorToState(e.toString());
    }
  }
  void _sendSMS(String message, List<String> recipents) async {
    String _result = await sendSMS(message: message, recipients: recipents)
        .catchError((onError) {
      print(onError);
    });
    print(_result);
  }
  Stream<AddBugState> _mapAddBugErrorToState(event) async* {
    var str = event;
    if(event.substring(event.length-8, event.length-3)=='30000')
      str = "Twoja próba połączyć z siecią przekroczyła 30 sekund sprawdż status internetu";
    yield AddBugStateError(str);
  }
}