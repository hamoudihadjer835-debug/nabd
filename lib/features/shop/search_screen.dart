import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../core/localization/l10n_extension.dart';
import '../../core/router/app_routes.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_dimens.dart';
import '../../core/widgets/circle_back_button.dart';
import 'data/mock_popular_searches.dart';
import 'data/product_search.dart';
import 'data/search_history.dart';
import 'widgets/pill_button.dart';
import 'widgets/product_card.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final _controller = TextEditingController();
  final _focusNode = FocusNode();

  /// null = نعرضو الاقتراحات. نص = نعرضو نتائج هذا البحث.
  String? _submittedQuery;

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  void _goBack() {
    if (context.canPop()) {
      context.pop();
    } else {
      context.go(AppRoutes.home);
    }
  }

  /// ننفذو البحث بهذا النص ونعرضو النتائج.
  void _runSearch(String query) {
    final q = query.trim();
    if (q.isEmpty) return;
    _controller.text = q;
    _controller.selection = TextSelection.collapsed(offset: q.length);
    addRecentSearch(q);
    FocusScope.of(context).unfocus();
    setState(() => _submittedQuery = q);
  }

  /// كي يمسح المستخدم النص نرجعو للاقتراحات.
  void _onChanged(String value) {
    if (value.trim().isEmpty && _submittedQuery != null) {
      setState(() => _submittedQuery = null);
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final textTheme = Theme.of(context).textTheme;

    OutlineInputBorder border(Color color, [double width = 1]) {
      return OutlineInputBorder(
        borderRadius: AppRadius.cardBorder,
        borderSide: BorderSide(color: color, width: width),
      );
    }

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            // السهم + حقل البحث الحقيقي
            Padding(
              padding: const EdgeInsets.all(AppSpacing.md),
              child: Row(
                children: [
                  CircleBackButton(onPressed: _goBack),
                  const SizedBox(width: AppSpacing.sm),
                  Expanded(
                    child: TextField(
                      controller: _controller,
                      focusNode: _focusNode,
                      autofocus: true,
                      textInputAction: TextInputAction.search,
                      onSubmitted: _runSearch,
                      onChanged: _onChanged,
                      style: textTheme.bodyMedium,
                      decoration: InputDecoration(
                        hintText: l10n.searchHint,
                        hintStyle: textTheme.bodyMedium
                            ?.copyWith(color: AppColors.textMuted),
                        filled: true,
                        fillColor: Colors.white,
                        prefixIcon: const Icon(
                          Icons.search_rounded,
                          color: AppColors.textMuted,
                        ),
                        suffixIcon: const Icon(
                          Icons.tune_rounded,
                          color: AppColors.textMuted,
                        ),
                        contentPadding:
                            const EdgeInsets.symmetric(vertical: 14),
                        border: border(AppColors.primaryLight),
                        enabledBorder: border(AppColors.primaryLight),
                        focusedBorder: border(AppColors.primary, 1.5),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // الباقي: اقتراحات أو نتائج
            Expanded(
              child: _submittedQuery == null
                  ? _Suggestions(onSelect: _runSearch)
                  : _Results(query: _submittedQuery!),
            ),
          ],
        ),
      ),
    );
  }
}

/// حالة ما قبل البحث: آخر عمليات البحث + الأكثر بحثًا.
class _Suggestions extends StatelessWidget {
  const _Suggestions({required this.onSelect});

  final ValueChanged<String> onSelect;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final textTheme = Theme.of(context).textTheme;
    final locale = Localizations.localeOf(context);

    return ListView(
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
      children: [
        // ----- آخر عمليات البحث (تختفي إذا كانت فارغة) -----
        ValueListenableBuilder<List<String>>(
          valueListenable: recentSearches,
          builder: (context, items, _) {
            if (items.isEmpty) return const SizedBox.shrink();

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(l10n.recentSearches, style: textTheme.titleLarge),
                    const Spacer(),
                    TextButton(
                      onPressed: clearRecentSearches,
                      style: TextButton.styleFrom(
                        foregroundColor: AppColors.primary,
                      ),
                      child: Text(l10n.clearAll),
                    ),
                  ],
                ),
                for (final item in items)
                  InkWell(
                    onTap: () => onSelect(item),
                    borderRadius: BorderRadius.circular(12),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: Row(
                        children: [
                          const Icon(
                            Icons.history_rounded,
                            size: 20,
                            color: AppColors.textMuted,
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Text(item, style: textTheme.bodyLarge),
                          ),
                          InkWell(
                            onTap: () => removeRecentSearch(item),
                            customBorder: const CircleBorder(),
                            child: const Padding(
                              padding: EdgeInsets.all(4),
                              child: Icon(
                                Icons.close_rounded,
                                size: 18,
                                color: AppColors.textMuted,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                const SizedBox(height: AppSpacing.lg),
              ],
            );
          },
        ),

        // ----- الأكثر بحثًا -----
        Text(l10n.mostSearched, style: textTheme.titleLarge),
        const SizedBox(height: AppSpacing.md),
        Wrap(
          spacing: AppSpacing.sm,
          runSpacing: AppSpacing.sm,
          children: [
            for (final term in mockPopularSearches)
              Material(
                color: Colors.white,
                clipBehavior: Clip.antiAlias,
                shape: const StadiumBorder(
                  side: BorderSide(color: AppColors.primaryLight),
                ),
                child: InkWell(
                  onTap: () => onSelect(term.of(locale)),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 14,
                      vertical: 8,
                    ),
                    child: Text(term.of(locale), style: textTheme.bodyMedium),
                  ),
                ),
              ),
          ],
        ),
        const SizedBox(height: AppSpacing.lg),
      ],
    );
  }
}

/// حالة ما بعد البحث: حبات التصفية + عدد النتائج + الشبكة (أو رسالة فارغة).
class _Results extends StatelessWidget {
  const _Results({required this.query});

  final String query;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final textTheme = Theme.of(context).textTheme;
    final results = searchProducts(query);

    return CustomScrollView(
      slivers: [
        // حبات التصفية (شكل فقط دابا) + عدد النتائج
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Wrap(
                  spacing: AppSpacing.sm,
                  runSpacing: AppSpacing.sm,
                  children: [
                    PillButton(
                      label: l10n.filterPrice,
                      icon: Icons.keyboard_arrow_down_rounded,
                    ),
                    PillButton(
                      label: l10n.filterAvailability,
                      icon: Icons.keyboard_arrow_down_rounded,
                    ),
                    PillButton(
                      label: l10n.filterCategory,
                      icon: Icons.keyboard_arrow_down_rounded,
                    ),
                  ],
                ),
                const SizedBox(height: AppSpacing.md),
                Text(
                  l10n.resultsCount(results.length),
                  style: textTheme.bodyMedium
                      ?.copyWith(color: AppColors.textMuted),
                ),
                const SizedBox(height: AppSpacing.md),
              ],
            ),
          ),
        ),

        if (results.isEmpty)
          SliverFillRemaining(
            hasScrollBody: false,
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(AppSpacing.lg),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(
                      Icons.search_off_rounded,
                      size: 56,
                      color: AppColors.primary,
                    ),
                    const SizedBox(height: AppSpacing.md),
                    Text(l10n.noResults, style: textTheme.titleLarge),
                    const SizedBox(height: AppSpacing.sm),
                    Text(
                      l10n.noResultsHint,
                      textAlign: TextAlign.center,
                      style: textTheme.bodyMedium
                          ?.copyWith(color: AppColors.textMuted),
                    ),
                  ],
                ),
              ),
            ),
          )
        else
          SliverPadding(
            padding: const EdgeInsets.fromLTRB(
              AppSpacing.md,
              0,
              AppSpacing.md,
              AppSpacing.md,
            ),
            sliver: SliverGrid(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: AppSpacing.md,
                crossAxisSpacing: AppSpacing.md,
                mainAxisExtent: 250,
              ),
              delegate: SliverChildBuilderDelegate(
                (context, index) => ProductCard(product: results[index]),
                childCount: results.length,
              ),
            ),
          ),
      ],
    );
  }
}