import 'package:flashcard_learning/l10n/app_localization.dart';
import 'package:flashcard_learning/utils/color/AllColor.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class TermsOfServiceScreen extends StatelessWidget {
  const TermsOfServiceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final textTheme = Theme.of(context).textTheme;
    final titleStyle =
        textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold);
    final bodyStyle = textTheme.bodyMedium?.copyWith(height: 1.5);

    return Scaffold(
      appBar: AppBar(
        leading: BackButton(
          onPressed: () {
            context.pop();
          },
        ),
        title: Text(l10n.term_title),
        centerTitle: true,
        foregroundColor: darkBlue,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              l10n.term_header,
              style: textTheme.headlineSmall
                  ?.copyWith(fontWeight: FontWeight.bold, color: darkBlue),
            ),
            const SizedBox(height: 8),
            Text(
              l10n.term_last_updated,
              style: textTheme.bodySmall?.copyWith(fontStyle: FontStyle.italic),
            ),
            const SizedBox(height: 24),

            // Section 1
            Text(l10n.term_1_title, style: titleStyle),
            const SizedBox(height: 8),
            Text(l10n.term_1_body,
                style: bodyStyle, textAlign: TextAlign.justify),
            const SizedBox(height: 24),

            // Section 2
            Text(l10n.term_2_title, style: titleStyle),
            const SizedBox(height: 8),
            Text(l10n.term_2_body_1,
                style: bodyStyle, textAlign: TextAlign.justify),
            const SizedBox(height: 8),
            Text(l10n.term_2_body_2,
                style: bodyStyle, textAlign: TextAlign.justify),
            const SizedBox(height: 24),

            // Section 3
            Text(l10n.term_3_title, style: titleStyle),
            const SizedBox(height: 8),
            Text(l10n.term_3_body_1,
                style: bodyStyle, textAlign: TextAlign.justify),
            const SizedBox(height: 8),
            Text(l10n.term_3_body_2,
                style: bodyStyle, textAlign: TextAlign.justify),
            const SizedBox(height: 24),

            // Section 4
            Text(l10n.term_4_title, style: titleStyle),
            const SizedBox(height: 8),
            Text(l10n.term_4_intro,
                style: bodyStyle, textAlign: TextAlign.justify),
            const SizedBox(height: 8),
            Padding(
              padding: const EdgeInsets.only(left: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(l10n.term_4_list_1, style: bodyStyle),
                  Text(l10n.term_4_list_2, style: bodyStyle),
                  Text(l10n.term_4_list_3, style: bodyStyle),
                  Text(l10n.term_4_list_4, style: bodyStyle),
                  Text(l10n.term_4_list_5, style: bodyStyle),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // Section 5
            Text(l10n.term_5_title, style: titleStyle),
            const SizedBox(height: 8),
            Text(l10n.term_5_body,
                style: bodyStyle, textAlign: TextAlign.justify),
            const SizedBox(height: 24),

            // Section 6
            Text(l10n.term_6_title, style: titleStyle),
            const SizedBox(height: 8),
            Text(l10n.term_6_body,
                style: bodyStyle, textAlign: TextAlign.justify),
            const SizedBox(height: 24),

            // Section 7
            Text(l10n.term_7_title, style: titleStyle),
            const SizedBox(height: 8),
            Text(l10n.term_7_body,
                style: bodyStyle, textAlign: TextAlign.justify),
            const SizedBox(height: 24),

            // Section 8
            Text(l10n.term_8_title, style: titleStyle),
            const SizedBox(height: 8),
            Text(l10n.term_8_body,
                style: bodyStyle, textAlign: TextAlign.justify),
            const SizedBox(height: 24),

            // Section 9
            Text(l10n.term_9_title, style: titleStyle),
            const SizedBox(height: 8),
            Text(l10n.term_9_body,
                style: bodyStyle, textAlign: TextAlign.justify),
            const SizedBox(height: 24),

            // Section 10
            Text(l10n.term_10_title, style: titleStyle),
            const SizedBox(height: 8),
            Text(l10n.term_10_body,
                style: bodyStyle, textAlign: TextAlign.justify),
            const SizedBox(height: 24),

            // Section 11
            Text(l10n.term_11_title, style: titleStyle),
            const SizedBox(height: 8),
            Text(l10n.term_11_body,
                style: bodyStyle, textAlign: TextAlign.justify),
          ],
        ),
      ),
    );
  }
}
