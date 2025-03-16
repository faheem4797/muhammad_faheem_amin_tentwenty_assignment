// import 'dart:async';

// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:go_router/go_router.dart';
// import 'package:project_pro/core/common/cubits/app_user_cubit.dart';
// import 'package:project_pro/core/common/widgets/loader.dart';
// import 'package:project_pro/core/common/domain/entities/app_user.dart';
// import 'package:project_pro/features/authentication/presentation/blocs/auth_bloc/auth_bloc.dart';
// import 'package:project_pro/routing/app_route_constants.dart';

// class InitialWidget extends StatefulWidget {
//   const InitialWidget({
//     super.key,
//   });

//   @override
//   State<InitialWidget> createState() => _InitialWidgetState();
// }

// class _InitialWidgetState extends State<InitialWidget> {
//   StreamSubscription<AuthState>? _subscription;

//   void _triggerEvent() {
//     _subscription = context.read<AuthBloc>().stream.listen((state) {
//       if (state is AuthSuccess) {
//         if (!mounted) return;
//         context.read<AppUserCubit>().updateUser(state.user);

//         _subscription?.cancel();
//       } else if (state is AuthFailure) {
//         if (!mounted) return;
//         context.read<AppUserCubit>().updateUser(null);

//         _subscription?.cancel();
//       }
//       if (!mounted) return;
//       final appUserState = context.read<AppUserCubit>().state;
//       if (appUserState is AppUserInitial) {
//         context.goNamed(AppRouteConstants.signinRouteName);
//       } else if (appUserState is AppUserLoggedIn) {
//         if (appUserState.user.role == AppUserRole.admin) {
//           context.goNamed(AppRouteConstants.adminUserRouteName);
//         } else if (appUserState.user.role == AppUserRole.projectManager) {
//           context.goNamed(AppRouteConstants.pmProjectsRouteName);
//         } else if (appUserState.user.role == AppUserRole.manager) {
//           context.goNamed(AppRouteConstants.managerHomeRouteName);
//         } else {
//           context.goNamed(AppRouteConstants.noConnectionRouteName);
//         }
//       }
//     });

//     context.read<AuthBloc>().add(AuthIsUserLoggedIn());
//   }

//   @override
//   void initState() {
//     super.initState();
//     _triggerEvent();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return const Scaffold(
//       body: Center(
//         child: Loader(),
//       ),
//     );
//   }
// }
