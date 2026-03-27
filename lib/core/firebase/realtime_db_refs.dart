abstract final class DbRefs {
  static const String users = 'users';

  static String profile(String uid) => '$users/$uid/profile';
  static String bucketList(String uid) => '$users/$uid/bucketList';
  static String bucketItem(String uid, String itemId) =>
      '$users/$uid/bucketList/$itemId';
  static String stats(String uid) => '$users/$uid/stats';
  static String categoryStats(String uid) => '$users/$uid/stats/categoryStats';
}
