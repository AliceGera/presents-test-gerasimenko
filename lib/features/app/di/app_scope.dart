import 'package:elementary/elementary.dart';
import 'package:flutter/material.dart';
import 'package:flutter_template/api/data/gift_database.dart';
import 'package:flutter_template/api/data/holiday_database.dart';
import 'package:flutter_template/api/data/persons_database.dart';
import 'package:flutter_template/api/service/gifts_received_api.dart';
import 'package:flutter_template/api/service/holidays_api.dart';
import 'package:flutter_template/api/service/persons_api.dart';
import 'package:flutter_template/features/common/domain/repository/gifrs_repository.dart';
import 'package:flutter_template/features/common/domain/repository/holidays_repository.dart';
import 'package:flutter_template/features/common/domain/repository/persons_repository.dart';
import 'package:flutter_template/features/common/service/gifts_service.dart';
import 'package:flutter_template/features/common/service/holidays_and_gifts_service.dart';
import 'package:flutter_template/features/common/service/holidays_service.dart';
import 'package:flutter_template/features/common/service/persons_service.dart';
import 'package:flutter_template/features/navigation/service/router.dart';
import 'package:flutter_template/util/default_error_handler.dart';

/// Scope of dependencies which need through all app's life.
class AppScope implements IAppScope {
  late final ErrorHandler _errorHandler;
  late final AppRouter _router;
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
  VoidCallback giftRecievedRebuilder = () {};
  @override
  VoidCallback giftGivenRebuilder = () {};

  @override
  ErrorHandler get errorHandler => _errorHandler;

  @override
  AppRouter get router => _router;

  @override
  HolidaysService get holidaysService => _holidaysService;

  @override
  GiftsService get giftsService => _giftsService;

  @override
  HolidayAndGiftsService get holidayAndGiftsService => _holidayAndGiftsService;

  @override
  PersonsService get personsService => _personsService;

  /// Create an instance [AppScope].
  AppScope() {
    /// List interceptor. Fill in as needed.

    _holidaysApi = HolidaysApi(AppDatabase());
    _holidaysService = _initHolidaysService();
    _giftsApi = GiftsApi(AppGiftsDatabase());
    _giftsService = _initGiftsService();
    _holidayAndGiftsService = _initHolidayAndGiftsService();
    _personsApi = PersonsApi(AppPersonsDatabase());
    _personsService = _initPersonsService();
    _errorHandler = DefaultErrorHandler();
    _router = AppRouter.instance();
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
  /// Interface for handle error in business logic.
  ErrorHandler get errorHandler;

  /// Callback to rebuild the whole application.
  VoidCallback get applicationRebuilder;

  VoidCallback get holidayRebuilder;

  VoidCallback get giftRecievedRebuilder;

  VoidCallback get giftGivenRebuilder;

  /// Class that coordinates navigation for the whole app.
  AppRouter get router;

  /// Analytics
  HolidaysService get holidaysService;

  /// Analytics
  GiftsService get giftsService;

  /// Analytics
  HolidayAndGiftsService get holidayAndGiftsService;

  /// Analytics
  PersonsService get personsService;
}
