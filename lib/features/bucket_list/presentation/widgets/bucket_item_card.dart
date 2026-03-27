import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import 'package:flamengo/design_system/theme/app_colors.dart';
import 'package:flamengo/design_system/theme/app_typography.dart';
import 'package:flamengo/core/constants/enums.dart';
import 'package:flamengo/features/bucket_list/domain/entities/bucket_item.dart';

class BucketItemCard extends StatelessWidget {
  const BucketItemCard({
    super.key,
    required this.item,
    required this.onTap,
  });

  final BucketItem item;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final categoryColor = AppColors.categoryColor(item.category);
    final categoryEnum = PlaceCategory.values.firstWhere(
      (c) => c.name == item.category,
      orElse: () => PlaceCategory.other,
    );

    return Card(
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: categoryColor.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Center(
                  child: Text(categoryEnum.icon, style: const TextStyle(fontSize: 24)),
                ),
              ),
              const Gap(12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item.name,
                      style: AppTypography.titleMedium,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const Gap(2),
                    Text(
                      '${item.city}, ${item.country}',
                      style: AppTypography.bodySmall.copyWith(
                        color: AppColors.grey600,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
              if (item.visited)
                const Icon(Icons.check_circle, color: AppColors.success, size: 20)
              else
                const Icon(Icons.circle_outlined, color: AppColors.grey400, size: 20),
            ],
          ),
        ),
      ),
    );
  }
}
