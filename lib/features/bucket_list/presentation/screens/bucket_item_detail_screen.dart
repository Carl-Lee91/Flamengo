import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

import 'package:flamengo/core/constants/enums.dart';
import 'package:flamengo/design_system/design_system.dart';
import 'package:flamengo/features/bucket_list/domain/entities/bucket_item.dart';
import 'package:flamengo/features/bucket_list/presentation/cubit/bucket_list_cubit.dart';
import 'package:flamengo/features/bucket_list/presentation/cubit/bucket_list_state.dart';

class BucketItemDetailScreen extends StatelessWidget {
  const BucketItemDetailScreen({super.key, required this.itemId});

  final String itemId;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BucketListCubit, BucketListState>(
      builder: (context, state) {
        final item = state.items.where((i) => i.id == itemId).firstOrNull;
        if (item == null) {
          return Scaffold(
            appBar: AppBar(),
            body: const AppErrorState(message: 'Item not found'),
          );
        }

        return Scaffold(
          appBar: AppBar(
            title: Text(item.name),
            actions: [
              IconButton(
                icon: const Icon(Icons.delete_outline),
                onPressed: () => _confirmDelete(context, item),
              ),
            ],
          ),
          body: _DetailBody(item: item),
        );
      },
    );
  }

  void _confirmDelete(BuildContext context, BucketItem item) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Delete Place'),
        content: Text('Remove "${item.name}" from your bucket list?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              context.read<BucketListCubit>().deleteItem(item.id);
              Navigator.of(context).pop();
              context.pop();
            },
            child: const Text('Delete'),
          ),
        ],
      ),
    );
  }
}

class _DetailBody extends StatelessWidget {
  const _DetailBody({required this.item});

  final BucketItem item;

  @override
  Widget build(BuildContext context) {
    final categoryEnum = PlaceCategory.values.firstWhere(
      (c) => c.name == item.category,
      orElse: () => PlaceCategory.other,
    );

    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Chip(
                label: Text('${categoryEnum.icon} ${categoryEnum.label}'),
                backgroundColor:
                    AppColors.categoryColor(item.category).withValues(alpha: 0.12),
              ),
              const Spacer(),
              if (item.visited)
                Chip(
                  avatar: const Icon(Icons.check, size: 16, color: AppColors.success),
                  label: const Text('Visited'),
                  backgroundColor: AppColors.success.withValues(alpha: 0.1),
                ),
            ],
          ),
          const Gap(16),
          _InfoRow(icon: Icons.location_on, text: item.address),
          const Gap(8),
          _InfoRow(icon: Icons.location_city, text: '${item.city}, ${item.country}'),
          if (item.visited && item.rating > 0) ...[
            const Gap(8),
            _InfoRow(icon: Icons.star, text: '${item.rating} / 5'),
          ],
          if (item.memo.isNotEmpty) ...[
            const Gap(16),
            Text('Memo', style: AppTypography.titleMedium),
            const Gap(8),
            Text(item.memo, style: AppTypography.bodyMedium),
          ],
          if (!item.visited) ...[
            const Gap(32),
            AppButton(
              text: 'Mark as Visited',
              onPressed: () => _showVisitDialog(context),
            ),
          ],
        ],
      ),
    );
  }

  void _showVisitDialog(BuildContext context) {
    double rating = 0;
    final memoController = TextEditingController(text: item.memo);

    showDialog(
      context: context,
      builder: (_) => StatefulBuilder(
        builder: (context, setDialogState) => AlertDialog(
          title: const Text('Mark as Visited'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(5, (index) {
                  return IconButton(
                    icon: Icon(
                      index < rating ? Icons.star : Icons.star_border,
                      color: AppColors.warning,
                    ),
                    onPressed: () =>
                        setDialogState(() => rating = index + 1.0),
                  );
                }),
              ),
              const Gap(12),
              TextField(
                controller: memoController,
                decoration: const InputDecoration(
                  hintText: 'Add a note...',
                  border: OutlineInputBorder(),
                ),
                maxLines: 3,
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                context.read<BucketListCubit>().markVisited(
                      item.id,
                      rating,
                      memoController.text.trim(),
                    );
                Navigator.of(context).pop();
              },
              child: const Text('Confirm'),
            ),
          ],
        ),
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  const _InfoRow({required this.icon, required this.text});

  final IconData icon;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, size: 18, color: AppColors.grey600),
        const Gap(8),
        Expanded(
          child: Text(
            text,
            style: AppTypography.bodyMedium.copyWith(color: AppColors.grey700),
          ),
        ),
      ],
    );
  }
}
