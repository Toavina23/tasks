import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:tasks/presentation/blocs/projectList/project_list_bloc.dart';
import 'package:tasks/presentation/blocs/projectList/project_list_event.dart';
import 'package:tasks/presentation/components/app_scaffold.dart';
import 'package:tasks/presentation/screens/home/home.dart';

final GoRouter appRouter = GoRouter(routes: <RouteBase>[
  ShellRoute(
      builder: (context, state, child) => AppScafold(child: child),
      routes: [
        GoRoute(
          path: '/',
          builder: (context, state) {
            context.read<ProjectListBloc>().add(FetchProjectListEvent());
            return const Home();
          },
        )
      ]),
]);
