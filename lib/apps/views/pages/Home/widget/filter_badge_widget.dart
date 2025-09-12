import 'package:flutter/material.dart';
import 'package:healing_apps/apps/utils/constant/constants.dart'; // Asumsi AppColors ada di sini

/// A horizontal list of tappable category chips for filtering content.
///
/// This is a stateful widget that manages the currently selected category
/// and notifies the parent widget of the selection change via a callback.
class FilterBadgeWidget extends StatefulWidget {
  /// The list of category names to display.
  final List<String> categories;

  /// A callback function that is triggered when a new category is selected.
  final ValueChanged<String> onCategorySelected;

  const FilterBadgeWidget({
    super.key,
    required this.categories,
    required this.onCategorySelected,
  });

  @override
  State<FilterBadgeWidget> createState() => _FilterBadgeWidgetState();
}

class _FilterBadgeWidgetState extends State<FilterBadgeWidget> {
  // Melacak indeks dari kategori yang sedang dipilih. Default-nya adalah item pertama.
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 45, // Memberi tinggi tetap untuk area filter
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        itemCount: widget.categories.length,
        itemBuilder: (context, index) {
          final isSelected = _selectedIndex == index;
          final category = widget.categories[index];

          return Padding(
            padding: const EdgeInsets.only(right: 12.0),
            child: GestureDetector(
              onTap: () {
                // Saat sebuah chip di-tap:
                // 1. Update state untuk mengubah tampilan chip yang dipilih.
                setState(() {
                  _selectedIndex = index;
                });
                // 2. Panggil callback untuk mengirim nama kategori yang dipilih ke parent widget.
                widget.onCategorySelected(category);
              },
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                decoration: BoxDecoration(
                  color: isSelected ? Colors.white : AppColors.card,
                  borderRadius: BorderRadius.circular(30.0),
                  border: isSelected
                      ? Border.all(color: Colors.black87, width: 1.5)
                      : null,
                  boxShadow: isSelected
                      ? [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 5,
                            offset: const Offset(0, 2),
                          ),
                        ]
                      : [],
                ),
                child: Center(
                  child: Text(
                    category,
                    style: TextStyle(
                      color: isSelected ? Colors.black : Colors.grey.shade600,
                      fontWeight: isSelected
                          ? FontWeight.bold
                          : FontWeight.normal,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
