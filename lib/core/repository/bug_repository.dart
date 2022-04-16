import 'dart:async';
import 'dart:convert';
import 'package:bugreportingsystem/core/client/api_client.dart';
import 'package:bugreportingsystem/core/helper/connectivity_helper.dart';
import 'package:bugreportingsystem/core/model/api/add_report.dart';
import 'package:bugreportingsystem/core/model/api/company_procurator_list_model_pageable.dart';
import 'package:bugreportingsystem/core/model/api/model_sim.dart';
import 'package:bugreportingsystem/core/model/api/module_model_response.dart';
import 'package:bugreportingsystem/core/model/api/person_model.dart';
import 'package:bugreportingsystem/core/model/api/report.dart';
import 'package:bugreportingsystem/core/model/api/response_of_ienumerable_of_module_model.dart';
import 'package:bugreportingsystem/core/model/api/response_of_pagination_result_of_report_model.dart';
import 'package:dio/dio.dart';
import 'package:hive/hive.dart';

import '../../app_settings.dart';
import 'authentication_repository.dart';

  class BugRepository {

    final Dio _httpClient;
    final ApiSettings _apiSettings;

    BugRepository({
      required AuthenticationRepository? authenticationRepository,
      required ApiSettings? apiConfig,
      required Dio? httpClient,
    })
        : assert(authenticationRepository != null),
          assert(apiConfig != null),
          assert(httpClient != null),
          _apiSettings = apiConfig!,
          _httpClient = httpClient! {
    }
    Future<CompanyProcuratorListModelPageable> getSelectModel(companyId,desc,orderBy,pageNumber,pageSize,searchTerm) async {
      CompanyProcuratorListModelPageable guidSelectModel;
      ApiClient apiService = ApiClient(_httpClient, baseUrl: _apiSettings.secondUrl);
      guidSelectModel= await apiService.getSelectModel(companyId, desc, orderBy, pageNumber, pageSize, searchTerm);
      return guidSelectModel;
    }
    Future<PersonModel> getPersonByPhoneNumber(String number) async {
      PersonModel personModel;
      ApiClient apiService = ApiClient(_httpClient, baseUrl: _apiSettings.secondUrl);
      print(_apiSettings.secondUrl);
      personModel = await apiService.getPersonByPhoneNumber(number);
      return personModel;
    }

    Future<SimModel> getSimByNumber(String number) async {
      SimModel simModel;
      ApiClient apiService = ApiClient(_httpClient, baseUrl: _apiSettings.secondUrl);
        print(_apiSettings.secondUrl);
        simModel = await apiService.getSimByNumber(number);
      return simModel;
    }
    Future<List<Report>> getBugs({int startIndex = 0, int limit = 50}) async {
      var bugsBox = await _ReportStorage().open();
      List<Report> bugs = [];
      List<int> stat=[];
      print(_apiSettings.coreUrl);
      if (await ConnectivityHelper.isOnline()) {
        ApiClient apiService = ApiClient(
            _httpClient, baseUrl: _apiSettings.coreUrl);
        ResponseOfPaginationResultOfReportModel responseOfPaginationResultOfReportMoedel= await apiService.getBugs(false,'',startIndex,limit,'',[],stat);
        var a =responseOfPaginationResultOfReportMoedel.result;
        var b=a.result;
        bugs.addAll(b);
        await bugsBox.setAll(startIndex, limit, bugs);
      }
      else {
        for (int i = startIndex; i < startIndex + limit &&
            i < bugs.length; i++) {
          bugs.add(bugsBox.getAt(i));
        }
      }
      return bugs;
    }
    Future clearCache() async {
      var statusesBox = await _ReportStorage().open();
      await statusesBox.clear();
    }
    Future<List<ModuleModelResponse>> getModules() async{
      List<ModuleModelResponse> moduleList=[];
      try {
        ApiClient apiService = ApiClient(_httpClient, baseUrl: _apiSettings.coreUrl);
        ResponseOfIEnumerableOfModuleModel responseOfIEnumerableOfModuleModel   = await apiService.getModules();
        moduleList =responseOfIEnumerableOfModuleModel.result!;
      }
      catch (e) {
      }
      return moduleList;
    }
  Future sendReport(AddReport model) async {

    if (await ConnectivityHelper.isOnline()) {
      ApiClient apiService = ApiClient(_httpClient, baseUrl: _apiSettings.coreUrl);
      await apiService.sendReport(model);
    }
    else {
      throw Exception('Offline');
    }
  }
  }
class _ReportStorage{
  late Box _bugsBox;
  late Box _indexBox;
  Future<_ReportStorage> open() async {
    _bugsBox = await Hive.openBox('_bugs');
    _indexBox = await Hive.openBox('bug_indexes');
    return this;
  }


  Future setAll(int startIndex, int length, List<Report> bugs) async {
    if (startIndex == 0) {
      await clear();
    }

    for (int i = startIndex, j = 0; i < startIndex + length && j < bugs.length; i++, j++) {
      int index = i;
      Report report = bugs[j];

      await _indexBox.put(report.id, index);
      await _bugsBox.put(index, jsonEncode(report.toJson()));
    }

    for (int i = startIndex + length; i < _bugsBox.length; i++) {
      var bug = Report.fromJson(jsonDecode(_bugsBox.getAt(i)));
      await _indexBox.delete(bug.id);
      await _bugsBox.deleteAt(i);
    }
  }
  Future clear() async {
    await _indexBox.clear();
    await _bugsBox.clear();
  }
  Report getAt(int index) {
    var json = _bugsBox.get(index);
      return Report.fromJson(jsonDecode(json));
  }
}