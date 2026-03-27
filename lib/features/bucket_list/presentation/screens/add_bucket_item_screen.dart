import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

import 'package:flamengo/core/constants/enums.dart';
import 'package:flamengo/design_system/design_system.dart';
import 'package:flamengo/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:flamengo/features/bucket_list/domain/entities/bucket_item.dart';
import 'package:flamengo/features/bucket_list/presentation/cubit/bucket_list_cubit.dart';

class AddBucketItemScreen extends StatefulWidget {
  const AddBucketItemScreen({super.key});

  @override
  State<AddBucketItemScreen> createState() => _AddBucketItemScreenState();
}

class _AddBucketItemScreenState extends State<AddBucketItemScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _addressController = TextEditingController();
  final _cityController = TextEditingController();
  final _countryController = TextEditingController();
  final _memoController = TextEditingController();
  PlaceCategory _selectedCategory = PlaceCategory.food;

  @override
  void dispose() {
    _nameController.dispose();
    _addressController.dispose();
    _cityController.dispose();
    _countryController.dispose();
    _memoController.dispose();
    super.dispose();
  }

  void _submit() {
    if (!_formKey.currentState!.validate()) return;

    final user = context.read<AuthCubit>().currentUser;
    if (user == null) return;
    final now = DateTime.now().millisecondsSinceEpoch;
    final item = BucketItem(
      id: '${now}_${user.uid.substring(0, 6)}',
      name: _nameController.text.trim(),
      address: _addressController.text.trim(),
      lat: 0,
      lng: 0,
      country: _countryController.text.trim(),
      city: _cityController.text.trim(),
      category: _selectedCategory.name,
      memo: _memoController.text.trim(),
      createdAt: now,
    );
    context.read<BucketListCubit>().addItem(item);
    context.pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Add Place')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppTextField(
                controller: _nameController,
                label: 'Place Name',
                hint: 'e.g. Gyeongbokgung Palace',
                validator: (v) =>
                    v == null || v.trim().isEmpty ? 'Required' : null,
              ),
              const Gap(16),
              AppTextField(
                controller: _addressController,
                label: 'Address',
                hint: 'e.g. 161 Sajik-ro, Jongno-gu',
              ),
              const Gap(16),
              Row(
                children: [
                  Expanded(
                    child: AppTextField(
                      controller: _cityController,
                      label: 'City',
                      hint: 'e.g. Seoul',
                      validator: (v) =>
                          v == null || v.trim().isEmpty ? 'Required' : null,
                    ),
                  ),
                  const Gap(12),
                  Expanded(
                    child: AppTextField(
                      controller: _countryController,
                      label: 'Country',
                      hint: 'e.g. KR',
                      validator: (v) =>
                          v == null || v.trim().isEmpty ? 'Required' : null,
                    ),
                  ),
                ],
              ),
              const Gap(16),
              Text('Category', style: Theme.of(context).textTheme.titleSmall),
              const Gap(8),
              Wrap(
                spacing: 8,
                children: PlaceCategory.values.map((cat) {
                  return ChoiceChip(
                    label: Text('${cat.icon} ${cat.label}'),
                    selected: _selectedCategory == cat,
                    onSelected: (selected) {
                      if (selected) setState(() => _selectedCategory = cat);
                    },
                  );
                }).toList(),
              ),
              const Gap(16),
              AppTextField(
                controller: _memoController,
                label: 'Memo (optional)',
                hint: 'Any notes about this place...',
                maxLines: 3,
              ),
              const Gap(32),
              AppButton(text: 'Add to Bucket List', onPressed: _submit),
            ],
          ),
        ),
      ),
    );
  }
}
