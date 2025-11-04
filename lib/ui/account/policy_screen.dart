import 'package:flashcard_learning/l10n/app_localization.dart';
import 'package:flashcard_learning/utils/color/AllColor.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class PolicyScreen extends StatelessWidget {
  const PolicyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    final textTheme = Theme.of(context).textTheme;
    final titleStyle =
        textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold);
    final bodyStyle = textTheme.bodyMedium?.copyWith(height: 1.5);

    return Scaffold(
      appBar: AppBar(
        leading: BackButton(onPressed: () => context.pop()),
        title: Text(l10n.policy_title),
        centerTitle: true,
        foregroundColor: darkBlue,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(l10n.policy_header,
                style: textTheme.headlineSmall
                    ?.copyWith(fontWeight: FontWeight.bold, color: darkBlue)),
            const SizedBox(height: 8),
            Text(l10n.policy_last_updated,
                style:
                    textTheme.bodySmall?.copyWith(fontStyle: FontStyle.italic)),
            const SizedBox(height: 24),
            Text(l10n.policy_section_1_title, style: titleStyle),
            const SizedBox(height: 8),
            Text(l10n.policy_section_1_body,
                style: bodyStyle, textAlign: TextAlign.justify),
            const SizedBox(height: 24),
            Text(l10n.policy_section_2_title, style: titleStyle),
            const SizedBox(height: 8),
            Text(l10n.policy_section_2_body_1,
                style: bodyStyle, textAlign: TextAlign.justify),
            const SizedBox(height: 8),
            Text(l10n.policy_section_2_body_2,
                style: bodyStyle, textAlign: TextAlign.justify),
            const SizedBox(height: 24),
            Text(l10n.policy_section_3_title, style: titleStyle),
            const SizedBox(height: 8),
            Text(l10n.policy_section_3_body,
                style: bodyStyle, textAlign: TextAlign.justify),
            const SizedBox(height: 24),
            Text(l10n.policy_section_4_title, style: titleStyle),
            const SizedBox(height: 8),
            Text(l10n.policy_section_4_body,
                style: bodyStyle, textAlign: TextAlign.justify),
            const SizedBox(height: 24),
            Text(l10n.policy_section_5_title, style: titleStyle),
            const SizedBox(height: 8),
            Text(l10n.policy_section_5_body,
                style: bodyStyle, textAlign: TextAlign.justify),
          ],
        ),
      ),
    );
  }
}
