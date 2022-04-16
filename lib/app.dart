import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'components/home/bloc/alert_bloc.dart';
import 'components/home/home_page.dart';
import 'components/login/login_page.dart';
import 'components/shared/center_loader_widget.dart';
import 'components/splash/splash_page.dart';
import 'core/bloc/authentication/bloc/authentication_bloc.dart';
import 'core/bloc/authentication/bloc/authentication_state.dart';
import 'core/repository/authentication_repository.dart';
import 'core/repository/bug_repository.dart';
import 'core/repository/configuration_repository.dart';
import 'core/service/shared_preferences_service.dart';

class App extends StatelessWidget {

  final ConfigurationRepository _configurationRepository;
  final AuthenticationRepository _authenticationRepository;
  App({

     required ConfigurationRepository? configurationRepository,
     required AuthenticationRepository? authenticationRepository
  }) : assert(configurationRepository != null),
        assert(authenticationRepository != null),
        _configurationRepository = configurationRepository!,
        _authenticationRepository = authenticationRepository!;

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(

        providers: [
          RepositoryProvider.value(
              value: _configurationRepository
          ),

          RepositoryProvider.value(
              value: _authenticationRepository
          ),

          RepositoryProvider(
            create: (context) => BugRepository(
                authenticationRepository: context.read<AuthenticationRepository>(),
                apiConfig: context.read<ConfigurationRepository>().apiSettings,
                httpClient: context.read<AuthenticationRepository>().securedHttpClient
            ),
          ),


          // if(AppConfiguration().configuration.useSignalr)
          //   RepositoryProvider(
          //       create: (context) => BleRepository(
          //           apiConfig: context.read<ConfigurationRepository>().apiSettings,
          //           httpClient: context.read<AuthenticationRepository>().securedHttpClient
          //       )
          //   ),
        ],
        child: MultiBlocProvider(
            providers: [
              BlocProvider(
                  create  : (context) => AuthenticationBloc(
                      authenticationRepository: context.read<AuthenticationRepository>()
                  )
              ),
              BlocProvider(
                  create: (context) => AlertBloc()
              ),

              // if(AppConfiguration().configuration.useSignalr)
              //   BlocProvider(
              //       create: (context) => BleBloc(
              //           authenticationRepository: context.read<AuthenticationRepository>(),
              //           bleRepository: context.read<BleRepository>()
              //       )
              //   ),
/*
              BlocProvider(
                  create: (context) => AdminServiceBloc(
                      authenticationRepository: context.watch<AuthenticationRepository>(),
                  )
              )

              /*BlocProvider(
              create: (context) => GeolocationBloc(
                  geolocationRepository: context.repository<GeolocationRepository>()
              ) ..add(GeolocationInitializeEvent())
          )*/*/
            ],
            child: AppView()
        )
    );
  }
}

class AppView extends StatefulWidget {

  @override
  _AppViewState createState() => _AppViewState();
}

class _AppViewState extends State<AppView> with WidgetsBindingObserver {
  Key key = UniqueKey();
  List<Locale> localeList = [ Locale('pl'), Locale('en') ];

  final _navigatorKey = GlobalKey<NavigatorState>();
  NavigatorState? get _navigator => _navigatorKey.currentState;


  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addObserver(this);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String>(
      future: _getLanguage(),
      builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.active:
          case ConnectionState.waiting:
           // return CenterLoaderWidget();
          case ConnectionState.done:
            return MaterialApp(
              localizationsDelegates: context.localizationDelegates,
              supportedLocales: context.supportedLocales,
              locale: context.locale,
              navigatorKey: _navigatorKey,
              title: 'Raporty',
              builder: (context, child) {
                return MultiBlocListener(
                  listeners: [
                    _getAuthenticationBlocListener(),
                  ],
                  child: child!,
                );
              },
              onGenerateRoute: (_) => SplashPage.route(),
            );
          case ConnectionState.none:return CenterLoaderWidget();
        }

      },
    );
  }

  Future<String>? _getLanguage() async{
    return (await SharedPreferencesService().getLanguage())!;
  }

  BlocListener _getAuthenticationBlocListener() {
    return BlocListener<AuthenticationBloc, AuthenticationState>(
      listener: (context, state) async {
        switch (state.status) {
          case AuthenticationStatus.authenticated:

              _navigator!.pushAndRemoveUntil<void>(HomePage.route(state.user!), (route) => false);

            break;

          case AuthenticationStatus.unauthenticated:
            _navigator!.pushAndRemoveUntil<void>(LoginPage.route(), (route) => false);
            break;

          default:
            break;
        }
      },
    );
  }
  @override
  void dispose() {


    super.dispose();
  }

/*BlocListener _getGeolocationBlocListener() {
    return BlocListener<GeolocationBloc, GeolocationState>(
        listener: (context, state) {

        }
    );
  }*/
}