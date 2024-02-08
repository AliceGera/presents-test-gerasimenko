import 'package:flutter_template/features/common/domain/data/gifts/gift_data.dart';
import 'package:flutter_template/features/common/domain/repository/gifrs_repository.dart';

class GiftsService {
  final GiftsRepository _giftsRepository;

  GiftsService(this._giftsRepository);

  Future<Future<List<Gift>>> getGifts() async {
    return _giftsRepository.getGifts();
  }

  Future<void> addGift(Gift data) async {
    await _giftsRepository.addGift(data);
  }

  Future<void> deleteGift(Gift data) async {
    await _giftsRepository.deleteGift(data);
  }

  Future<void> editGift(Gift data) async {
    await _giftsRepository.editGift(data);
  }
}
