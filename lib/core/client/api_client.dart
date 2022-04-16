import 'package:bugreportingsystem/core/interceptors/api_response_interceptor.dart';
import 'package:bugreportingsystem/core/model/api/add_report.dart';
import 'package:bugreportingsystem/core/model/api/company_procurator_list_model_pageable.dart';
import 'package:bugreportingsystem/core/model/api/model_sim.dart';
import 'package:bugreportingsystem/core/model/api/person_model.dart';
import 'package:bugreportingsystem/core/model/api/response_of_ienumerable_of_module_model.dart';
import 'package:bugreportingsystem/core/model/api/response_of_pagination_result_of_report_model.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/http.dart';

part 'api_client.g.dart';

@RestApi()
abstract class ApiClient {
  factory ApiClient(Dio dio, {required String baseUrl}) {
    dio..interceptors.add(ApiResponseInterceptor());
    dio.options.connectTimeout = 30000;
    dio.options.receiveTimeout = 30000;
    return _ApiClient(dio, baseUrl: baseUrl);
  }

  @GET('/api/Reports')
  Future<ResponseOfPaginationResultOfReportModel> getBugs(@Query("Desc") bool desc,
      @Query("OrderBy") String orderBy,
      @Query("PageNumber") int pageNumber, @Query("PageSize") int pageSize,
      @Query("SearchTerm") String searchTerm, @Query("Statuses") List<int> statuses,
      @Query("FilterType") List<int> filterType);

  @GET('/api/Module/allModules')
  Future<ResponseOfIEnumerableOfModuleModel> getModules();

  @POST('/api/Reports')
  Future sendReport(@Body() AddReport addReport);

  @GET('/api/Person/GetPersonByPhoneNumber/{phoneNumber}')
  Future<PersonModel> getPersonByPhoneNumber(@Path("phoneNumber") String phoneNumber);

  @GET('/api/SIM/GetByPhoneNumber')
  Future<SimModel> getSimByNumber(@Query("PhoneNumber") String phoneNumber);

  @GET('/api/CompanyProcurator/pageable')
  Future<CompanyProcuratorListModelPageable> getSelectModel(@Query("CompanyId") String companyId,@Query("Desc") bool desc,@Query("OrderBy") String orderBy,@Query("PageNumber")int pageNumber ,@Query("PageSize") int pageSize, @Query("SearchTerm") String searchTerm);

}