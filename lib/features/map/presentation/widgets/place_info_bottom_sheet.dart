import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import 'package:flamengo/design_system/theme/app_colors.dart';
import 'package:flamengo/design_system/theme/app_typography.dart';
import 'package:flamengo/features/map/domain/entities/place.dart';

class PlaceInfoBottomSheet extends StatelessWidget {
  const PlaceInfoBottomSheet({
    super.key,
    required this.place,
    required this.onAddToBucketList,
  });

  final Place place;
  final VoidCallback onAddToBucketList;

  static void show(
    BuildContext context, {
    required Place place,
    required VoidCallback onAddToBucketList,
  }) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (_) => PlaceInfoBottomSheet(
        place: place,
        onAddToBucketList: onAddToBucketList,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: AppColors.grey300,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ),
          const Gap(16),
          Text(place.name, style: AppTypography.headlineMedium),
          const Gap(8),
          if (place.address.isNotEmpty)
            Row(
              children: [
                const Icon(Icons.location_on, size: 16, color: AppColors.grey600),
                const Gap(4),
                Expanded(
                  child: Text(
                    place.address,
                    style: AppTypography.bodyMedium
                        .copyWith(color: AppColors.grey600),
                  ),
                ),
              ],
            ),
          const Gap(8),
          Row(
            children: [
              if (place.rating > 0) ...[
                const Icon(Icons.star, size: 16, color: AppColors.warning),
                const Gap(4),
                Text('${place.rating}', style: AppTypography.labelMedium),
                const Gap(16),
              ],
              if (place.businessStatus != null) ...[
                Icon(
                  place.businessStatus == 'OPERATIONAL'
                      ? Icons.check_circle
                      : Icons.cancel,
                  size: 16,
                  color: place.businessStatus == 'OPERATIONAL'
                      ? AppColors.success
                      : AppColors.error,
                ),
                const Gap(4),
                Text(
                  place.businessStatus == 'OPERATIONAL' ? 'Open' : 'Closed',
                  style: AppTypography.labelMedium,
                ),
              ],
            ],
          ),
          const Gap(24),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              onPressed: onAddToBucketList,
              icon: const Icon(Icons.add),
              label: const Text('Add to Bucket List'),
            ),
          ),
          const Gap(8),
        ],
      ),
    );
  }
}
