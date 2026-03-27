import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

import 'package:flamengo/core/constants/enums.dart';
import 'package:flamengo/design_system/design_system.dart';
import 'package:flamengo/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:flamengo/features/stats/presentation/cubit/stats_cubit.dart';
import 'package:flamengo/features/stats/presentation/cubit/stats_state.dart';

class StatsScreen extends StatefulWidget {
  const StatsScreen({super.key});

  @override
  State<StatsScreen> createState() => _StatsScreenState();
}

class _StatsScreenState extends State<StatsScreen> {
  @override
  void initState() {
    super.initState();
    final user = context.read<AuthCubit>().currentUser;
    if (user != null) {
      context.read<StatsCubit>().loadStats(user.uid);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Stats')),
      body: BlocBuilder<StatsCubit, StatsState>(
        builder: (context, state) {
          return state.when(
            initial: () => const SizedBox.shrink(),
            loading: () => const AppLoading(),
            error: (msg) => AppErrorState(message: msg),
            loaded: (stats) {
              if (stats.totalPlaces == 0) {
                return const AppEmptyState(
                  icon: Icons.bar_chart,
                  title: 'No stats yet',
                  subtitle: 'Add places to your bucket list to see stats',
                );
              }

              return ListView(
                padding: const EdgeInsets.all(16),
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: _StatCard(
                          icon: Icons.public,
                          value: '${stats.countries}',
                          label: 'Countries',
                        ),
                      ),
                      const Gap(8),
                      Expanded(
                        child: _StatCard(
                          icon: Icons.location_city,
                          value: '${stats.cities}',
                          label: 'Cities',
                        ),
                      ),
                    ],
                  ),
                  const Gap(8),
                  Row(
                    children: [
                      Expanded(
                        child: _StatCard(
                          icon: Icons.checklist,
                          value: '${stats.totalPlaces}',
                          label: 'Total Places',
                        ),
                      ),
                      const Gap(8),
                      Expanded(
                        child: _StatCard(
                          icon: Icons.check_circle,
                          value: '${stats.visitedPlaces}',
                          label: 'Visited',
                        ),
                      ),
                    ],
                  ),
                  const Gap(24),
                  Text('By Category', style: AppTypography.headlineSmall),
                  const Gap(12),
                  ...PlaceCategory.values.map((cat) {
                    final stat = stats.categoryStats[cat.name];
                    if (stat == null) return const SizedBox.shrink();
                    return _CategoryProgressTile(
                      category: cat,
                      total: stat.total,
                      visited: stat.visited,
                    );
                  }),
                ],
              );
            },
          );
        },
      ),
    );
  }
}

class _StatCard extends StatelessWidget {
  const _StatCard({
    required this.icon,
    required this.value,
    required this.label,
  });

  final IconData icon;
  final String value;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Icon(icon, color: AppColors.primary, size: 28),
            const Gap(8),
            Text(value, style: AppTypography.headlineLarge),
            const Gap(4),
            Text(label, style: AppTypography.labelMedium.copyWith(
              color: AppColors.grey600,
            )),
          ],
        ),
      ),
    );
  }
}

class _CategoryProgressTile extends StatelessWidget {
  const _CategoryProgressTile({
    required this.category,
    required this.total,
    required this.visited,
  });

  final PlaceCategory category;
  final int total;
  final int visited;

  @override
  Widget build(BuildContext context) {
    final progress = total > 0 ? visited / total : 0.0;
    final color = AppColors.categoryColor(category.name);

    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text('${category.icon} ${category.label}',
                  style: AppTypography.titleMedium),
              const Spacer(),
              Text('$visited / $total',
                  style: AppTypography.labelMedium.copyWith(
                    color: AppColors.grey600,
                  )),
            ],
          ),
          const Gap(6),
          ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: LinearProgressIndicator(
              value: progress,
              backgroundColor: color.withValues(alpha: 0.12),
              valueColor: AlwaysStoppedAnimation(color),
              minHeight: 8,
            ),
          ),
        ],
      ),
    );
  }
}
