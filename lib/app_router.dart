import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'layout/admin_layout.dart';
import 'pages/dashboard_page.dart';
import 'pages/users_page.dart';
import 'pages/settings_page.dart';
import 'pages/login_page.dart';
import 'services/auth_service.dart';

class AppRouter {
  static GoRouter router(AuthService auth) {
    return GoRouter(
      initialLocation: '/login',
      refreshListenable: auth,
      redirect: (context, state) {
        final loggedIn = auth.isAuthenticated;
        final isLoggingIn = state.fullPath == '/login';

        if (!loggedIn && !isLoggingIn) return '/login';
        if (loggedIn && isLoggingIn) return '/';
        return null;
      },
      routes: [
        GoRoute(
          path: '/login',
          builder: (context, state) => const LoginPage(),
        ),
        ShellRoute(
          builder: (context, state, child) => AdminLayout(child: child),
          routes: [
            GoRoute(
              path: '/',
              builder: (context, state) => const DashboardPage(),
            ),
            GoRoute(
              path: '/users',
              builder: (context, state) => const UsersPage(),
            ),
            GoRoute(
              path: '/settings',
              builder: (context, state) => const SettingsPage(),
            ),
          ],
        ),
      ],
    );
  }
}
