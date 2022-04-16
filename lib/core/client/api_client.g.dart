// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'api_client.dart';

// **************************************************************************
// RetrofitGenerator
// **************************************************************************

class _ApiClient implements ApiClient {
  _ApiClient(this._dio, {this.baseUrl});

  final Dio _dio;

  String? baseUrl;

  @override
  Future<ResponseOfPaginationResultOfReportModel> getBugs(desc, orderBy,
      pageNumber, pageSize, searchTerm, statuses, filterType) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{
      r'Desc': desc,
      r'OrderBy': orderBy,
      r'PageNumber': pageNumber,
      r'PageSize': pageSize,
      r'SearchTerm': searchTerm,
      r'Statuses': statuses,
      r'FilterType': filterType
    };
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<ResponseOfPaginationResultOfReportModel>(
            Options(method: 'GET', headers: _headers, extra: _extra)
                .compose(_dio.options, '/api/Reports',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value =
        ResponseOfPaginationResultOfReportModel.fromJson(_result.data!);
    return value;
  }

  @override
  Future<ResponseOfIEnumerableOfModuleModel> getModules() async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<ResponseOfIEnumerableOfModuleModel>(
            Options(method: 'GET', headers: _headers, extra: _extra)
                .compose(_dio.options, '/api/Module/allModules',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = ResponseOfIEnumerableOfModuleModel.fromJson(_result.data!);
    return value;
  }

  @override
  Future<dynamic> sendReport(addReport) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(addReport.toJson());
    final _result = await _dio.fetch(_setStreamType<dynamic>(
        Options(method: 'POST', headers: _headers, extra: _extra)
            .compose(_dio.options, '/api/Reports',
                queryParameters: queryParameters, data: _data)
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = _result.data;
    return value;
  }

  @override
  Future<PersonModel> getPersonByPhoneNumber(phoneNumber) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<PersonModel>(Options(
                method: 'GET', headers: _headers, extra: _extra)
            .compose(
                _dio.options, '/api/Person/GetPersonByPhoneNumber/$phoneNumber',
                queryParameters: queryParameters, data: _data)
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = PersonModel.fromJson(_result.data!);
    return value;
  }

  @override
  Future<SimModel> getSimByNumber(phoneNumber) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{r'PhoneNumber': phoneNumber};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<SimModel>(
            Options(method: 'GET', headers: _headers, extra: _extra)
                .compose(_dio.options, '/api/SIM/GetByPhoneNumber',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = SimModel.fromJson(_result.data!);
    return value;
  }

  @override
  Future<CompanyProcuratorListModelPageable> getSelectModel(
      companyId, desc, orderBy, pageNumber, pageSize, searchTerm) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{
      r'CompanyId': companyId,
      r'Desc': desc,
      r'OrderBy': orderBy,
      r'PageNumber': pageNumber,
      r'PageSize': pageSize,
      r'SearchTerm': searchTerm
    };
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<CompanyProcuratorListModelPageable>(
            Options(method: 'GET', headers: _headers, extra: _extra)
                .compose(_dio.options, '/api/CompanyProcurator/pageable',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = CompanyProcuratorListModelPageable.fromJson(_result.data!);
    return value;
  }

  RequestOptions _setStreamType<T>(RequestOptions requestOptions) {
    if (T != dynamic &&
        !(requestOptions.responseType == ResponseType.bytes ||
            requestOptions.responseType == ResponseType.stream)) {
      if (T == String) {
        requestOptions.responseType = ResponseType.plain;
      } else {
        requestOptions.responseType = ResponseType.json;
      }
    }
    return requestOptions;
  }
}
