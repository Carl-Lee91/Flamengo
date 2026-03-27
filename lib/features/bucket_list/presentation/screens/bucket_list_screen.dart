import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

import 'package:flamengo/core/constants/enums.dart';
import 'package:flamengo/design_system/design_system.dart';
import 'package:flamengo/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:flamengo/features/bucket_list/presentation/cubit/bucket_list_cubit.dart';
import 'package:flamengo/features/bucket_list/presentation/cubit/bucket_list_state.dart';
import 'package:flamengo/features/bucket_list/presentation/widgets/bucket_item_card.dart';
import 'package:flamengo/features/bucket_list/presentation/widgets/category_chip.dart';

class BucketListScreen extends StatefulWidget {
  const BucketListScreen({super.key});

  @override
  State<BucketListScreen> createState() => _BucketListScreenState();
}

class _BucketListScreenState extends State<BucketListScreen> {
  @override
  void initState() {
    super.initState();
    _loadItems();
  }

  void _loadItems() {
    final user = context.read<AuthCubit>().currentUser;
    if (user != null) {
      context.read<BucketListCubit>().loadItems(user.uid);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Bucket List'),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () => context.push('/settings'),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.push('/bucket-list/add'),
        child: const Icon(Icons.add),
      ),
      body: Column(
        children: [
          const _CategoryFilterBar(),
          Expanded(
            child: BlocBuilder<BucketListCubit, BucketListState>(
              builder: (context, state) {
                if (state.isLoading) return const AppLoading();

                if (state.errorMessage != null) {
                  return AppErrorState(
                    message: state.errorMessage!,
                    onRetry: _loadItems,
                  );
                }

                if (state.filteredItems.isEmpty) {
                  return AppEmptyState(
                    icon: Icons.checklist,
                    title: 'No places yet',
                    subtitle: 'Tap + to add your first bucket list place',
                    action: AppButton(
                      text: 'Add Place',
                      onPressed: () => context.push('/bucket-list/add'),
                      isExpanded: false,
                    ),
                  );
                }

                return RefreshIndicator(
                  onRefresh: () async => _loadItems(),
                  child: ListView.separated(
                    padding: const EdgeInsets.all(16),
                    itemCount: state.filteredItems.length,
                    separatorBuilder: (_, i) => const Gap(8),
                    itemBuilder: (context, index) {
                      final item = state.filteredItems[index];
                      return BucketItemCard(
                        item: item,
                        onTap: () => context.push('/bucket-list/${item.id}'),
                      );
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _CategoryFilterBar extends StatelessWidget {
  const _CategoryFilterBar();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BucketListCubit, BucketListState>(
      buildWhen: (prev, curr) => prev.selectedCategory != curr.selectedCategory,
      builder: (context, state) {
        return SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Row(
            children: [
              CategoryChip(
                label: 'All',
                isSelected: state.selectedCategory == null,
                onTap: () =>
                    context.read<BucketListCubit>().filterByCategory(null),
              ),
              const Gap(8),
              ...PlaceCategory.values.map((cat) => Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: CategoryChip(
                      label: cat.label,
                      isSelected: state.selectedCategory == cat.name,
                      categoryColor: AppColors.categoryColor(cat.name),
                      onTap: () => context
                          .read<BucketListCubit>()
                          .filterByCategory(cat.name),
                    ),
                  )),
            ],
          ),
        );
      },
    );
  }
}
