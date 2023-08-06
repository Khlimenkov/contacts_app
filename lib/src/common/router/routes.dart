import 'package:contacts_app/src/feature/contacts/widget/contact_screen.dart';
import 'package:contacts_app/src/feature/contacts/widget/contact_view_screen.dart';
import 'package:contacts_app/src/feature/feed/widget/feed_screen.dart';
import 'package:go_router/go_router.dart';

final List<RouteBase> routes = [
  GoRoute(
    path: '/',
    name: 'Home',
    redirect: (context, state) => Uri(path: '/contacts', queryParameters: state.pathParameters).toString(),
  ),
  GoRoute(
    path: '/contacts',
    name: 'Contacts',
    builder: (context, state) => const FeedScreen(),
    routes: [
      GoRoute(
        name: 'NewContact',
        path: 'new',
        builder: (context, state) => const ContactScreen(),
      ),
      GoRoute(
        path: 'edit/:contactId',
        builder: (context, state) => ContactScreen(
          contactId: state.pathParameters['contactId'],
        ),
      ),
      GoRoute(
        path: ':contactId',
        builder: (context, state) => ContactViewScreen(
          contactId: state.pathParameters['contactId']!,
        ),
      ),
    ],
  )
];
