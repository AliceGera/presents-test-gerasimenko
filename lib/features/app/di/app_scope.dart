import 'dart:io';

import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'package:elementary/elementary.dart';
import 'package:flutter/material.dart';
import 'package:flutter_template/api/data/gift_database.dart';
import 'package:flutter_template/api/data/holiday_database.dart';
import 'package:flutter_template/api/data/persons_database.dart';
import 'package:flutter_template/api/service/gifts_received_api.dart';
import 'package:flutter_template/api/service/holidays_api.dart';
import 'package:flutter_template/api/service/persons_api.dart';
import 'package:flutter_template/config/environment/environment.dart';
import 'package:flutter_template/features/common/domain/repository/gifrs_repository.dart';
import 'package:flutter_template/features/common/domain/repository/holidays_repository.dart';
import 'package:flutter_template/features/common/domain/repository/persons_repository.dart';
import 'package:flutter_template/features/common/service/gifts_service.dart';
import 'package:flutter_template/features/common/service/holidays_and_gifts_service.dart';
import 'package:flutter_template/features/common/service/holidays_service.dart';
import 'package:flutter_template/features/common/service/persons_service.dart';
import 'package:flutter_template/features/common/utils/analytics/amplitude/amplitude_analytic_tracker.dart';
import 'package:flutter_template/features/common/utils/analytics/firebase/firebase_analytic_tracker.dart';
import 'package:flutter_template/features/common/utils/analytics/mock/mock_amplitude_analytics.dart';
import 'package:flutter_template/features/common/utils/analytics/mock/mock_firebase_analytics.dart';
import 'package:flutter_template/features/common/utils/analytics/service/analytics_service.dart';
import 'package:flutter_template/features/common/utils/analytics/service/analytics_service_impl.dart';
import 'package:flutter_template/features/navigation/service/router.dart';
import 'package:flutter_template/util/default_error_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Scope of dependencies which need through all app's life.
class AppScope implements IAppScope {
  final SharedPreferences _sharedPreferences;

  late final Dio _dio;
  late final ErrorHandler _errorHandler;
  late final AppRouter _router;
  late final IAnalyticsService _analyticsService;
  late final HolidaysService _holidaysService;
  late final HolidaysRepository _holidaysRepository;
  late final HolidaysApi _holidaysApi;
  late final GiftsApi _giftsApi;
  late final GiftsService _giftsService;
  late final GiftsRepository _giftsRepository;
  late final HolidayAndGiftsService _holidayAndGiftsService;
  late final PersonsApi _personsApi;
  late final PersonsService _personsService;
  late final PersonsRepository _personsRepository;
  @override
  late VoidCallback applicationRebuilder;

  @override
  VoidCallback holidayRebuilder = () {};

  @override
  VoidCallback gifRecievedRebuilder = () {};

  @override
  Dio get dio => _dio;

  @override
  ErrorHandler get errorHandler => _errorHandler;

  @override
  AppRouter get router => _router;

  @override
  SharedPreferences get sharedPreferences => _sharedPreferences;

  @override
  IAnalyticsService get analyticsService => _analyticsService;

  @override
  HolidaysService get holidaysService => _holidaysService;

  @override
  GiftsService get giftsService => _giftsService;

  @override
  HolidayAndGiftsService get holidayAndGiftsService => _holidayAndGiftsService;

  @override
  PersonsService get personsService => _personsService;

  /// Create an instance [AppScope].
  AppScope(this._sharedPreferences) {
    /// List interceptor. Fill in as needed.
    final additionalInterceptors = <Interceptor>[];
    _holidaysApi = HolidaysApi(AppDatabase());
    _holidaysService = _initHolidaysService();
    _giftsApi = GiftsApi(AppGiftsDatabase());
    _giftsService = _initGiftsService();
    _holidayAndGiftsService = _initHolidayAndGiftsService();
    _personsApi = PersonsApi(AppPersonsDatabase());
    _personsService = _initPersonsService();
    _dio = _initDio(additionalInterceptors);
    _errorHandler = DefaultErrorHandler();
    _router = AppRouter.instance();
    _analyticsService = AnalyticsServiceImpl([]);
  }

  Dio _initDio(Iterable<Interceptor> additionalInterceptors) {
    const timeout = Duration(seconds: 30);

    final dio = Dio();

    dio.options
      ..baseUrl = Environment.instance().config.url
      ..connectTimeout = timeout
      ..receiveTimeout = timeout
      ..sendTimeout = timeout;

    (dio.httpClientAdapter as IOHttpClientAdapter).createHttpClient = () {
      final client = HttpClient();
      final proxyUrl = Environment.instance().config.proxyUrl;
      if (proxyUrl != null && proxyUrl.isNotEmpty) {
        client
          ..findProxy = (uri) {
            return 'PROXY $proxyUrl';
          }
          ..badCertificateCallback = (_, __, ___) {
            return true;
          };
      }

      return client;
    };

    dio.interceptors.addAll(additionalInterceptors);

    if (Environment.instance().isDebug) {
      dio.interceptors.add(LogInterceptor(requestBody: true, responseBody: true));
    }

    return dio;
  }

  HolidaysService _initHolidaysService() {
    _holidaysRepository = HolidaysRepository(_holidaysApi);
    return HolidaysService(_holidaysRepository);
  }

  GiftsService _initGiftsService() {
    _giftsRepository = GiftsRepository(_giftsApi);
    return GiftsService(_giftsRepository);
  }

  HolidayAndGiftsService _initHolidayAndGiftsService() {
    return HolidayAndGiftsService(_giftsRepository, _holidaysRepository);
  }

  PersonsService _initPersonsService() {
    _personsRepository = PersonsRepository(_personsApi);
    return PersonsService(_personsRepository);
  }
}

/// App dependencies.
abstract class IAppScope {
  /// Http client.
  Dio get dio;

  /// Interface for handle error in business logic.
  ErrorHandler get errorHandler;

  /// Callback to rebuild the whole application.
  VoidCallback get applicationRebuilder;

  VoidCallback get holidayRebuilder;

  VoidCallback get gifRecievedRebuilder;

  /// Class that coordinates navigation for the whole app.
  AppRouter get router;

  /// Shared preferences.
  SharedPreferences get sharedPreferences;

  /// Analytics sending service
  IAnalyticsService get analyticsService;

  /// Analytics
  HolidaysService get holidaysService;

  /// Analytics
  GiftsService get giftsService;

  /// Analytics
  HolidayAndGiftsService get holidayAndGiftsService;

  /// Analytics
  PersonsService get personsService;
}
