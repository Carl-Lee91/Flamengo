import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

import 'package:flamengo/design_system/design_system.dart';
import 'package:flamengo/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:flamengo/features/footprint/presentation/cubit/footprint_cubit.dart';
import 'package:flamengo/features/footprint/presentation/cubit/footprint_state.dart';

class FootprintScreen extends StatefulWidget {
  const FootprintScreen({super.key});

  @override
  State<FootprintScreen> createState() => _FootprintScreenState();
}

class _FootprintScreenState extends State<FootprintScreen> {
  @override
  void initState() {
    super.initState();
    final user = context.read<AuthCubit>().currentUser;
    if (user != null) {
      context.read<FootprintCubit>().loadFootprint(user.uid);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Footprint')),
      body: BlocBuilder<FootprintCubit, FootprintState>(
        builder: (context, state) {
          return state.when(
            initial: () => const SizedBox.shrink(),
            loading: () => const AppLoading(),
            error: (msg) => AppErrorState(message: msg),
            loaded: (data) {
              if (data.visitedItems.isEmpty) {
                return const AppEmptyState(
                  icon: Icons.travel_explore,
                  title: 'No footprints yet',
                  subtitle: 'Mark places as visited to see your travel map',
                );
              }

              return ListView(
                padding: const EdgeInsets.all(16),
                children: [
                  _StatsSummary(
                    countries: data.totalCountries,
                    cities: data.totalCities,
                    places: data.visitedItems.length,
                  ),
                  const Gap(24),
                  ...data.byCountry.entries.map((entry) => _CountrySection(
                        country: entry.key,
                        items: entry.value,
                      )),
                ],
              );
            },
          );
        },
      ),
    );
  }
}

class _StatsSummary extends StatelessWidget {
  const _StatsSummary({
    required this.countries,
    required this.cities,
    required this.places,
  });

  final int countries;
  final int cities;
  final int places;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(child: _StatTile(label: 'Countries', value: '$countries')),
        Expanded(child: _StatTile(label: 'Cities', value: '$cities')),
        Expanded(child: _StatTile(label: 'Places', value: '$places')),
      ],
    );
  }
}

class _StatTile extends StatelessWidget {
  const _StatTile({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Text(value, style: AppTypography.headlineLarge.copyWith(
              color: AppColors.primary,
            )),
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

class _CountrySection extends StatelessWidget {
  const _CountrySection({required this.country, required this.items});

  final String country;
  final List items;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '$country (${items.length})',
          style: AppTypography.titleLarge,
        ),
        const Gap(8),
        ...items.map((item) => ListTile(
              leading: Icon(
                item.visited ? Icons.check_circle : Icons.circle_outlined,
                color: item.visited ? AppColors.success : AppColors.grey400,
              ),
              title: Text(item.name),
              subtitle: Text(item.city),
              dense: true,
            )),
        const Gap(16),
      ],
    );
  }
}
