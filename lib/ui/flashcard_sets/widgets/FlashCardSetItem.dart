import 'package:flashcard_learning/domain/models/flashSet.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:pie_menu/pie_menu.dart';

import '../../../routing/route.dart';

class FlashCardSetItem extends StatelessWidget {
  final FlashCardSet flashCardSet;
  final Function edit;
  final Function delete;
  final Function share;
  final bool isGridView;
  final bool isPublic;

  const FlashCardSetItem({
    super.key,
    required this.flashCardSet,
    required this.edit,
    required this.delete,
    required this.share,
    required this.isGridView,
    required this.isPublic,
  });

  void _goToSpecificFlashCardSet(String nameOfSet, BuildContext context) {
    context.push(AppRoute.gotoFlashcardSet(nameOfSet, isPublic.toString()));
  }

  Widget _buildGridItem(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Top info section
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  border: Border.all(color: flashCardSet.color, width: 1),
                  color: flashCardSet.color.withOpacity(0.1),
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(16),
                    topRight: Radius.circular(16),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "${flashCardSet.numOfCard} cards",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: flashCardSet.color,
                      ),
                    ),
                    if (flashCardSet.done) _buildCompletionBadge(),
                  ],
                ),
              ),

              // Main content
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      flashCardSet.iconData,
                      size: 48,
                      color: flashCardSet.color,
                    ),
                    const SizedBox(height: 12),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      child: Text(
                        flashCardSet.name,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                        textAlign: TextAlign.center,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ),

              // Bottom section
              Container(
                padding: const EdgeInsets.symmetric(vertical: 12),
                decoration: BoxDecoration(
                  color: flashCardSet.color.withOpacity(0.8),
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(16),
                    bottomRight: Radius.circular(16),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.timer_outlined,
                        size: 16, color: Colors.white70),
                    const SizedBox(width: 4),
                    Text(
                      "Study now",
                      style: TextStyle(
                        color: Colors.white.withOpacity(0.9),
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildListItem() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        border: Border.all(width: 1, color: flashCardSet.color),
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 6,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: ListTile(
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        leading: Container(
          width: 48,
          height: 48,
          decoration: BoxDecoration(
            color: flashCardSet.color.withOpacity(0.1),
            shape: BoxShape.circle,
          ),
          child: Icon(
            flashCardSet.iconData,
            color: flashCardSet.color,
            size: 24,
          ),
        ),
        title: Text(
          flashCardSet.name,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
        subtitle: Text(
          "${flashCardSet.numOfCard} cards",
          style: TextStyle(
            color: Colors.grey.shade600,
            fontSize: 14,
          ),
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (flashCardSet.done) _buildCompletionBadge(),
            const SizedBox(width: 8),
            Icon(
              Icons.chevron_right,
              color: Colors.grey.shade400,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCompletionBadge() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.green.withOpacity(0.2),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.check_circle,
            color: Colors.green.shade600,
            size: 16,
          ),
          const SizedBox(width: 4),
          Text(
            "Completed",
            style: TextStyle(
              color: Colors.green.shade600,
              fontSize: 12,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return PieMenu(
      theme: const PieTheme(
        buttonTheme: PieButtonTheme(
          backgroundColor: Color(0xFF9AC2EA),
          iconColor: Colors.black87,
        ),
      ),
      actions: [
        PieAction(
          tooltip: Text('Edit'),
          onSelect: () => edit(),
          child: const Icon(Icons.edit, size: 20),
        ),
        PieAction(
          tooltip: Text('Delete'),
          onSelect: () => delete(),
          buttonTheme: const PieButtonTheme(
            backgroundColor: Colors.red,
            iconColor: Colors.white,
          ),
          child: const Icon(Icons.delete, size: 20),
        ),
        PieAction(
          tooltip: Text('Share'),
          onSelect: () => share(),
          buttonTheme: const PieButtonTheme(
            backgroundColor: Colors.blue,
            iconColor: Colors.white,
          ),
          child: const Icon(Icons.share, size: 20),
        ),
      ],
      child: GestureDetector(
        onTap: () => _goToSpecificFlashCardSet(flashCardSet.name, context),
        child: isGridView ? _buildGridItem(context) : _buildListItem(),
      ),
    );
  }
}
