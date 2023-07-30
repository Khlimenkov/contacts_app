import 'package:contacts_app/src/feature/contacts/widget/contact_item_screen.dart';
import 'package:contacts_app/src/feature/contacts/widget/contact_screen.dart';
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
    builder: (context, state) => const ContactScreen(),
    routes: [
      GoRoute(
        name: 'NewContact',
        path: 'new',
        builder: (context, state) => const ContactItemScreen(),
      ),
      GoRoute(
        path: ':contactId',
        builder: (context, state) => ContactItemScreen(
          contactId: state.pathParameters['contactId']!,
        ),
      ),
    ],
  )
];
