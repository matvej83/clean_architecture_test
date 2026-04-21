import 'dart:async';

import 'package:clean_architecture_test/features/auth/domain/entity/user_entity.dart';
import 'package:clean_architecture_test/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:clean_architecture_test/features/auth/presentation/bloc/auth_event.dart';
import 'package:clean_architecture_test/features/auth/presentation/bloc/auth_state.dart';
import 'package:clean_architecture_test/features/auth/presentation/widgets/user_avatar.dart';
import 'package:clean_architecture_test/features/profile/presentation/pages/profile_page.dart';
import 'package:clean_architecture_test/features/profile/presentation/widgets/language_selector.dart';
import 'package:clean_architecture_test/features/profile/presentation/widgets/theme_selector.dart';
import 'package:clean_architecture_test/features/theme/cubit/cubit.dart';
import 'package:clean_architecture_test/features/theme/cubit/state.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

// Mocks
class MockAuthBloc extends Mock implements AuthBloc {}

class MockThemeCubit extends Mock implements ThemeCubit {}

class FakeAuthState extends Fake implements AuthState {}

class FakeThemeState extends Fake implements ThemeState {}

class AuthEventFake extends Fake implements AuthEvent {}

void main() {
  late AuthBloc authBloc;
  late ThemeCubit themeCubit;
  late StreamController<AuthState> controller;

  TestWidgetsFlutterBinding.ensureInitialized();

  setUpAll(() {
    registerFallbackValue(FakeAuthState());
    registerFallbackValue(AuthEventFake());
  });

  setUp(() {
    authBloc = MockAuthBloc();
    themeCubit = MockThemeCubit();
    controller = StreamController<AuthState>.broadcast();
  });

  tearDown(() {
    controller.close();
  });

  testWidgets('ProfilePage displays user info and logout button', (
    WidgetTester tester,
  ) async {
    final userState = const AuthState(
      status: AuthStatus.authenticated,
      user: UserEntity(
        id: '1',
        name: 'Jhon',
        email: 'john@mail.com',
        avatar: 'https://api.lorem.space/image/face?w=640&h=480&r=867',
        role: 'customer',
      ),
    );

    // Mock state and stream
    when(() => authBloc.state).thenReturn(userState);
    when(() => authBloc.stream).thenAnswer((_) => controller.stream);

    when(() => themeCubit.state).thenReturn(const ThemeState());
    when(
      () => themeCubit.stream,
    ).thenAnswer((_) => const Stream<ThemeState>.empty());

    // Set screen size inside a test
    await tester.binding.setSurfaceSize(const Size(800, 600));

    await tester.pumpWidget(
      MultiBlocProvider(
        providers: [
          BlocProvider<AuthBloc>.value(value: authBloc),
          BlocProvider<ThemeCubit>.value(value: themeCubit),
        ],
        child: EasyLocalization(
          supportedLocales: const [Locale('en')],
          startLocale: const Locale('en'),
          path: 'assets/translations/en.json',
          fallbackLocale: const Locale('en'),
          child: const MaterialApp(home: Scaffold(body: ProfilePage())),
        ),
      ),
    );

    await tester.pumpAndSettle();

    // Check user data widgets
    expect(find.byType(UserAvatar), findsOneWidget);
    expect(find.text('Jhon'), findsOneWidget);
    expect(find.textContaining('john@mail.com'), findsOneWidget);

    // Check language and theme selectors
    expect(find.byType(ThemeSelector), findsOneWidget);
    expect(find.byType(LanguageSelector), findsOneWidget);

    // Check logout button
    final logoutButton = find.byIcon(Icons.logout);
    expect(logoutButton, findsOneWidget);

    // Push the button
    await tester.tap(logoutButton);
    await tester.pump();

    // Check that AuthLogoutRequested is sent
    verify(() => authBloc.add(any(that: isA<AuthLogoutRequested>()))).called(1);

    // Reset screen size
    await tester.binding.setSurfaceSize(null);
  });
}
