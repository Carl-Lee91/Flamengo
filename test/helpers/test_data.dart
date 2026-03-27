import 'package:flamengo/features/auth/domain/entities/app_user.dart';
import 'package:flamengo/features/bucket_list/domain/entities/bucket_item.dart';
import 'package:flamengo/features/map/domain/entities/place.dart';
import 'package:flamengo/features/profile/domain/entities/user_profile.dart';

const testUid = 'test-uid-123';

const testUser = AppUser(
  uid: testUid,
  email: 'test@example.com',
  displayName: 'Test User',
);

final testProfile = UserProfile(
  uid: testUid,
  displayName: 'Test User',
  email: 'test@example.com',
  createdAt: 1700000000000,
  updatedAt: 1700000000000,
);

final testBucketItems = [
  BucketItem(
    id: 'item-1',
    name: 'Eiffel Tower',
    address: 'Champ de Mars, Paris',
    lat: 48.8584,
    lng: 2.2945,
    country: 'France',
    city: 'Paris',
    category: 'culture',
    createdAt: 1700000000000,
  ),
  BucketItem(
    id: 'item-2',
    name: 'Sushi Dai',
    address: 'Tsukiji, Tokyo',
    lat: 35.6654,
    lng: 139.7707,
    country: 'Japan',
    city: 'Tokyo',
    category: 'food',
    visited: true,
    visitedAt: 1700100000000,
    rating: 4.5,
    memo: 'Amazing sushi!',
    createdAt: 1700000000000,
  ),
  BucketItem(
    id: 'item-3',
    name: 'Shibuya Crossing',
    address: 'Shibuya, Tokyo',
    lat: 35.6595,
    lng: 139.7004,
    country: 'Japan',
    city: 'Tokyo',
    category: 'culture',
    visited: true,
    visitedAt: 1700200000000,
    createdAt: 1700000000000,
  ),
  BucketItem(
    id: 'item-4',
    name: 'Central Park',
    address: 'New York, NY',
    lat: 40.7829,
    lng: -73.9654,
    country: 'USA',
    city: 'New York',
    category: 'nature',
    createdAt: 1700000000000,
  ),
];

const testPlaces = [
  Place(
    name: 'Test Restaurant',
    address: '123 Test St',
    placeId: 'place-1',
    lat: 37.5665,
    lng: 126.978,
    rating: 4.2,
  ),
  Place(
    name: 'Test Cafe',
    address: '456 Cafe Ave',
    placeId: 'place-2',
    lat: 37.567,
    lng: 126.979,
    rating: 4.5,
  ),
];
