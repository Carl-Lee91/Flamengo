import 'package:injectable/injectable.dart';

import 'package:flamengo/features/bucket_list/domain/entities/bucket_item.dart';
import 'package:flamengo/features/bucket_list/domain/repositories/bucket_list_repository.dart';
import 'package:flamengo/features/bucket_list/data/datasources/bucket_list_remote_data_source.dart';

@Injectable(as: BucketListRepository)
class BucketListRepositoryImpl implements BucketListRepository {
  BucketListRepositoryImpl(this._dataSource);

  final BucketListRemoteDataSource _dataSource;

  @override
  Future<List<BucketItem>> getAll(String uid) async {
    final dataList = await _dataSource.getAll(uid);
    return dataList.map((data) => BucketItem.fromJson(data)).toList()
      ..sort((a, b) => b.createdAt.compareTo(a.createdAt));
  }

  @override
  Future<void> addItem(String uid, BucketItem item) async {
    final data = item.toJson()..remove('id');
    await _dataSource.addItem(uid, item.id, data);
  }

  @override
  Future<void> updateItem(String uid, BucketItem item) async {
    final data = item.toJson()..remove('id');
    await _dataSource.updateItem(uid, item.id, data);
  }

  @override
  Future<void> deleteItem(String uid, String itemId) async {
    await _dataSource.deleteItem(uid, itemId);
  }
}
