import 'package:mocktail/mocktail.dart';

import 'package:flamengo/features/auth/domain/repositories/auth_repository.dart';
import 'package:flamengo/features/bucket_list/domain/entities/bucket_item.dart';
import 'package:flamengo/features/bucket_list/domain/repositories/bucket_list_repository.dart';
import 'package:flamengo/features/map/domain/repositories/map_repository.dart';
import 'package:flamengo/features/profile/domain/entities/user_profile.dart';
import 'package:flamengo/features/profile/domain/repositories/profile_repository.dart';

class MockAuthRepository extends Mock implements AuthRepository {}

class MockBucketListRepository extends Mock implements BucketListRepository {}

class MockMapRepository extends Mock implements MapRepository {}

class MockProfileRepository extends Mock implements ProfileRepository {}

class FakeBucketItem extends Fake implements BucketItem {}

class FakeUserProfile extends Fake implements UserProfile {}
