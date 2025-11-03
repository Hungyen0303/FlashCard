import 'package:flashcard_learning/utils/color/AllColor.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class TermsOfServiceScreen extends StatelessWidget {
  const TermsOfServiceScreen({super.key});

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
        title: const Text('Terms of Service'),
        centerTitle: true,
        foregroundColor: darkBlue,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Terms of Service for Flashcard Learning App',
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
              '1. Acceptance of Terms',
              style: titleStyle,
            ),
            const SizedBox(height: 8),
            Text(
              'By accessing or using the Flashcard Learning App, you agree to be bound by these Terms of Service and our Privacy Policy. If you disagree with any part of the terms, you may not access our service.',
              style: bodyStyle,
              textAlign: TextAlign.justify,
            ),
            const SizedBox(height: 24),
            Text(
              '2. User Accounts',
              style: titleStyle,
            ),
            const SizedBox(height: 8),
            Text(
              'You are responsible for maintaining the confidentiality of your account and password. You agree to accept responsibility for all activities that occur under your account.',
              style: bodyStyle,
              textAlign: TextAlign.justify,
            ),
            const SizedBox(height: 8),
            Text(
              'You must be at least 13 years old to use this service. If you are under 18, you must have parental consent to use this app.',
              style: bodyStyle,
              textAlign: TextAlign.justify,
            ),
            const SizedBox(height: 24),
            Text(
              '3. User-Generated Content',
              style: titleStyle,
            ),
            const SizedBox(height: 8),
            Text(
              'You retain all rights to the flashcards and other content you create using our app. By submitting content, you grant us a worldwide, non-exclusive, royalty-free license to use, store, and display that content for the purpose of providing our services to you.',
              style: bodyStyle,
              textAlign: TextAlign.justify,
            ),
            const SizedBox(height: 8),
            Text(
              'You are solely responsible for the content you create and share. You agree not to create content that is illegal, offensive, or infringes on others\' intellectual property rights.',
              style: bodyStyle,
              textAlign: TextAlign.justify,
            ),
            const SizedBox(height: 24),
            Text(
              '4. Prohibited Activities',
              style: titleStyle,
            ),
            const SizedBox(height: 8),
            Text(
              'You may not use our service to:',
              style: bodyStyle,
            ),
            const SizedBox(height: 8),
            Padding(
              padding: const EdgeInsets.only(left: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('• Violate any laws or regulations', style: bodyStyle),
                  Text('• Infringe on intellectual property rights',
                      style: bodyStyle),
                  Text('• Harass, abuse, or harm others', style: bodyStyle),
                  Text('• Distribute malware or malicious code',
                      style: bodyStyle),
                  Text('• Attempt to gain unauthorized access to our systems',
                      style: bodyStyle),
                ],
              ),
            ),
            const SizedBox(height: 24),
            Text(
              '5. Service Modifications and Availability',
              style: titleStyle,
            ),
            const SizedBox(height: 8),
            Text(
              'We reserve the right to modify, suspend, or discontinue any part of our service at any time. We do not guarantee that our service will be available uninterrupted or error-free.',
              style: bodyStyle,
              textAlign: TextAlign.justify,
            ),
            const SizedBox(height: 24),
            Text(
              '6. Termination',
              style: titleStyle,
            ),
            const SizedBox(height: 8),
            Text(
              'We may terminate or suspend your account immediately, without prior notice, for conduct that we believe violates these Terms of Service or is harmful to other users, us, or third parties, or for any other reason.',
              style: bodyStyle,
              textAlign: TextAlign.justify,
            ),
            const SizedBox(height: 24),
            Text(
              '7. Disclaimer of Warranties',
              style: titleStyle,
            ),
            const SizedBox(height: 8),
            Text(
              'The service is provided "as is" without warranties of any kind, either express or implied. We do not warrant that the service will meet your requirements or be available on an uninterrupted, secure, or error-free basis.',
              style: bodyStyle,
              textAlign: TextAlign.justify,
            ),
            const SizedBox(height: 24),
            Text(
              '8. Limitation of Liability',
              style: titleStyle,
            ),
            const SizedBox(height: 8),
            Text(
              'To the maximum extent permitted by law, we shall not be liable for any indirect, incidental, special, consequential, or punitive damages, or any loss of profits or revenues.',
              style: bodyStyle,
              textAlign: TextAlign.justify,
            ),
            const SizedBox(height: 24),
            Text(
              '9. Changes to Terms',
              style: titleStyle,
            ),
            const SizedBox(height: 8),
            Text(
              'We reserve the right to modify these terms at any time. We will provide notice of significant changes through our app or via email. Continued use of our service after changes constitutes acceptance of the new terms.',
              style: bodyStyle,
              textAlign: TextAlign.justify,
            ),
            const SizedBox(height: 24),
            Text(
              '10. Governing Law',
              style: titleStyle,
            ),
            const SizedBox(height: 8),
            Text(
              'These terms shall be governed by and construed in accordance with the laws of the jurisdiction where our company is established, without regard to its conflict of law provisions.',
              style: bodyStyle,
              textAlign: TextAlign.justify,
            ),
            const SizedBox(height: 24),
            Text(
              '11. Contact Us',
              style: titleStyle,
            ),
            const SizedBox(height: 8),
            Text(
              'If you have any questions about these Terms of Service, please contact us at support@flashcardlearning.com.',
              style: bodyStyle,
              textAlign: TextAlign.justify,
            ),
          ],
        ),
      ),
    );
  }
}
