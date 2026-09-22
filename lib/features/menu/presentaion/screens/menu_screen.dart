

import 'package:cafe/features/menu/presentaion/screens/search_screen.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/constants/colors.dart';
import '../../../../core/constants/strings.dart';

import '../../../auth/services/firebase_auth_service.dart';
import '../../data/models/item_model.dart';
import '../../data/services/item_service.dart';
import '../cubit/items_cubit.dart';
import '../widgets/card_list.dart';
import '../widgets/custom_app_bar.dart';
import '../widgets/offer_card.dart';
import '../widgets/search_bar.dart';
import '../widgets/section_header.dart';


class MenuScreen extends StatefulWidget {
  const MenuScreen({super.key});

  @override
  State<MenuScreen> createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  static final String _hotCategoryUrl = '${Strings.baseUrl}hot';
  static  final String _coldCategoryUrl ='${Strings.baseUrl}iced';

  late final ItemsCubit _hotCubit;
  late final ItemsCubit _coldCubit;

  late final Map<int, int> _quantities = {};
  List<ItemModel> _hotItems =[];
  List<ItemModel> _coldItems =[];


  @override
  void initState() {
    super.initState();
    var _dio = Dio(BaseOptions(baseUrl: 'https://api.sampleapis.com/coffee'));
    _hotCubit = ItemsCubit(itemService: ItemService(dio: _dio))..fetchItems(_hotCategoryUrl);
    _coldCubit = ItemsCubit(itemService: ItemService(dio: _dio))..fetchItems(_coldCategoryUrl);
  }
  @override
  void dispose() {
    _hotCubit.close();
    _coldCubit.close();
    super.dispose();
  }

  void _increment(ItemModel item) {
    setState(() => _quantities[item.id] = (_quantities[item.id] ?? 0) + 1);
  }

  void _decrement(ItemModel item) {
    final current = _quantities[item.id] ?? 0;
    if (current <= 1) {
      setState(() => _quantities.remove(item.id));
    } else {
      setState(() => _quantities[item.id] = current - 1);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.trinary,
      appBar: buildCustomAppBar(userName: FirebaseAuthService().currentUser?.displayName ?? 'Guest',),
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(top: 12, bottom: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: buildMenuSearchBar(onTap:  _openSearch),
            ),
            const SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: buildOfferCard(
                badgeLabel: 'MORNING ROAST',
                title: '20% off All Slow-Steeped Cold Brews',
                code: 'BREW20',
              ),
            ),
            const SizedBox(height: 20),

            buildSectionHeader(
              title: 'Artisan Hot Espresso',
              onViewAll: () {
              },
            ),
            const SizedBox(height: 12),
            buildHotItemsBlocBuilder(),
            const SizedBox(height: 20),

            buildSectionHeader(
              title: 'Cold Brew & Shaken',
              onViewAll: () {
              },
            ),
            const SizedBox(height: 12),
            buildIcedItemsBlocBuilder(),
          ],
        ),
      ),
    );
  }

  BlocBuilder<ItemsCubit, ItemsState> buildIcedItemsBlocBuilder() {
    return BlocBuilder<ItemsCubit, ItemsState>(
            bloc: _coldCubit,
            builder: (context, state) {
              if (state is ItemsLoading || state is ItemsInitial) {
                return const SizedBox(
                  height: 220,
                  child: Center(child: CircularProgressIndicator(color: AppColors.secondary)),
                );
              }
              if (state is ItemsError) {
                return SizedBox(
                  height: 220,
                  child: Center(
                    child: Text(
                      'Couldn\'t load cold items',
                      style: const TextStyle(color: AppColors.neutral),
                    ),
                  ),
                );
              }
              final items = (state as ItemsSuccess).items;
              _coldItems =items;
              return CardList(
                items: items,
                quantities: _quantities,

              );
            },
          );
  }

  BlocBuilder<ItemsCubit, ItemsState> buildHotItemsBlocBuilder() {
    return BlocBuilder<ItemsCubit, ItemsState>(
            bloc: _hotCubit,
            builder: (context, state) {
              if (state is ItemsLoading || state is ItemsInitial) {
                return const SizedBox(
                  height: 220,
                  child: Center(child: CircularProgressIndicator(color: AppColors.secondary)),
                );
              }
              if (state is ItemsError) {
                return SizedBox(
                  height: 220,
                  child: Center(
                    child: Text(
                      'Couldn\'t load hot items',
                      style: const TextStyle(color: AppColors.neutral),
                    ),
                  ),
                );
              }
              final items = (state as ItemsSuccess).items;
              _hotItems= items;
              return CardList(
                items: items,
                quantities: _quantities,

              );
            },
          );
  }

  void  _openSearch (){
    Navigator.of(context).push(
      MaterialPageRoute(builder: (context)=> SearchScreen(hotItems: _hotItems, coldItems: _coldItems))
    );
  }
}