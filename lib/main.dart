import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tasks/core/injection/injection.dart';
import 'package:tasks/domain/usecases/project/get_all_projects.dart';
import 'package:tasks/presentation/blocs/projectList/project_list_bloc.dart';
import 'package:tasks/presentation/routers/router.dart';
import 'package:tasks/presentation/theme/app_theme.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  initialize();
  runApp(const Tasks());
}

class Tasks extends StatefulWidget {
  const Tasks({super.key});

  @override
  State<Tasks> createState() => _TasksState();
}

class _TasksState extends State<Tasks> {
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: const Size(375, 812),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: ((context, child) {
          return MultiBlocProvider(
              providers: [
                BlocProvider<ProjectListBloc>(create: (context) {
                  return getIt.get<ProjectListBloc>();
                }),
              ],
              child: MaterialApp.router(
                theme: appTheme,
                routerConfig: appRouter,
                title: "Tasks",
                builder: EasyLoading.init(),
                debugShowCheckedModeBanner: false,
              ));
        }));
  }
}
