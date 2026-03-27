import 'package:flamengo/features/bucket_list/domain/entities/bucket_item.dart';

abstract class BucketListRepository {
  Future<List<BucketItem>> getAll(String uid);
  Future<void> addItem(String uid, BucketItem item);
  Future<void> updateItem(String uid, BucketItem item);
  Future<void> deleteItem(String uid, String itemId);
}
