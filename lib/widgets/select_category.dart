import 'package:ant_todo_list/providers/category_provider.dart';
import 'package:ant_todo_list/utils/extensions.dart';
import 'package:ant_todo_list/utils/task_category.dart';
import 'package:ant_todo_list/widgets/circle_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';

class SelectCategory extends ConsumerWidget {
  const SelectCategory({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectcategory = ref.watch(categoryProvider);
    final categories = TaskCategories.values.toList();
    return SizedBox(
      height: 60,
      child: Row(
        children: [
          Text(
            'ប្រភេទ៖', 
            style: context.textTheme.titleLarge,
          ),
          const Gap(10),
          Expanded(
            child: ListView.separated(
              physics: const AlwaysScrollableScrollPhysics(),
              scrollDirection: Axis.horizontal,
              itemBuilder: (ctx, index) {
                final category = categories[index];
                return InkWell(
                  onTap: () {
                    ref.read(categoryProvider.notifier).state = category;
                  },
                  borderRadius: BorderRadius.circular(30),
                  child: CircleContainer(
                    color: category.color.withOpacity(0.3), 
                    child: Icon(
                      category.icon,
                      color: category == selectcategory 
                        ? context.colorScheme.primary
                        : category.color,
                    ),
                  ),
                );
              }, 
              separatorBuilder: (ctx, index) => const Gap(8), 
              itemCount: categories.length,
            ),
          ),
        ],
      ),
    );
  }
}