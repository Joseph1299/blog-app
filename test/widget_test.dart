import 'package:flutter_test/flutter_test.dart';

import 'package:blog_app/main.dart';

void main() {
  testWidgets('signup screen shows account creation UI', (tester) async {
    await tester.pumpWidget(const BlogApp());

    expect(find.text('Create your account'), findsOneWidget);
    expect(find.text('Create account'), findsOneWidget);
    expect(find.text('Continue with Google'), findsOneWidget);
  });
}
