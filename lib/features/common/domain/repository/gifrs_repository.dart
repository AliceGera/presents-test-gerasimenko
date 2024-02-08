import 'package:flutter_template/api/service/gifts_received_api.dart';
import 'package:flutter_template/features/common/domain/data/gifts/gift_data.dart';
import 'package:flutter_template/features/common/domain/repository/mappers/gifts_mapper.dart';

class GiftsRepository {
  final GiftsApi _apiClient;

  GiftsRepository(this._apiClient);

  Future<List<Gift>> getGifts() async {
    final some = await _apiClient.getGifts();
    return mapDatabaseToGifts(some);
  }
  Future<void> addGift(Gift data) async {
    await _apiClient.addGift(data);
  }
  Future<void> deleteGift(Gift data) async {

    await _apiClient.deleteGift(data);
  }
  Future<void> editGift(Gift data) async {
    await _apiClient.editGift(data);
  }
 /* Future<void> addHoliday(Holiday data) async {
    await _apiClient.addHoliday(data);
  }

  Future<void> editHoliday(Holiday data) async {
    await _apiClient.editHoliday(data);
  }
  Future<void> deleteHoliday(Holiday data) async {

    await _apiClient.deleteHoliday(data);
  }*/
}
