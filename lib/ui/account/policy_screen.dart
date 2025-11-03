import 'package:flashcard_learning/utils/color/AllColor.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class PolicyScreen extends StatelessWidget {
  const PolicyScreen({super.key});

  @override
  Widget build(BuildContext context) {
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
        title: const Text('Privacy Policy'),
        centerTitle: true,
        foregroundColor: darkBlue,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Privacy Policy for Flashcard Learning App',
              style: textTheme.headlineSmall
                  ?.copyWith(fontWeight: FontWeight.bold, color: darkBlue),
            ),
            const SizedBox(height: 8),
            Text(
              'Last updated: October 26, 2023',
              style: textTheme.bodySmall?.copyWith(fontStyle: FontStyle.italic),
            ),
            const SizedBox(height: 24),
            Text(
              '1. Introduction',
              style: titleStyle,
            ),
            const SizedBox(height: 8),
            Text(
              'Welcome to Flashcard Learning App. We are committed to protecting your personal information and your right to privacy. If you have any questions or concerns about our policy, or our practices with regards to your personal information, please contact us at support@flashcardlearning.com.',
              style: bodyStyle,
              textAlign: TextAlign.justify,
            ),
            const SizedBox(height: 24),
            Text(
              '2. Information We Collect',
              style: titleStyle,
            ),
            const SizedBox(height: 8),
            Text(
              'We collect personal information that you voluntarily provide to us when you register on the app, express an interest in obtaining information about us or our products and services, when you participate in activities on the app or otherwise when you contact us.',
              style: bodyStyle,
              textAlign: TextAlign.justify,
            ),
            const SizedBox(height: 8),
            Text(
              'The personal information that we collect depends on the context of your interactions with us and the app, the choices you make and the products and features you use. The personal information we collect may include the following: name, email address, and user-generated content like flashcards.',
              style: bodyStyle,
              textAlign: TextAlign.justify,
            ),
            const SizedBox(height: 24),
            Text(
              '3. How We Use Your Information',
              style: titleStyle,
            ),
            const SizedBox(height: 8),
            Text(
              'We use personal information collected via our app for a variety of business purposes described below. We process your personal information for these purposes in reliance on our legitimate business interests, in order to enter into or perform a contract with you, with your consent, and/or for compliance with our legal obligations.',
              style: bodyStyle,
              textAlign: TextAlign.justify,
            ),
            const SizedBox(height: 24),
            Text(
              '4. Will Your Information Be Shared With Anyone?',
              style: titleStyle,
            ),
            const SizedBox(height: 8),
            Text(
              'We only share information with your consent, to comply with laws, to provide you with services, to protect your rights, or to fulfill business obligations.',
              style: bodyStyle,
              textAlign: TextAlign.justify,
            ),
            const SizedBox(height: 24),
            Text(
              '5. Contact Us',
              style: titleStyle,
            ),
            const SizedBox(height: 8),
            Text(
              'If you have questions or comments about this policy, you may email us at support@flashcardlearning.com.',
              style: bodyStyle,
              textAlign: TextAlign.justify,
            ),
          ],
        ),
      ),
    );
  }
}
