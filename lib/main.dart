import 'package:flutter/material.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sellit_mobileapp/bloc/bloc.dart';
import 'package:sellit_mobileapp/data/categoryrepository.dart';
import 'package:sellit_mobileapp/data/productrepository.dart';
import 'package:sellit_mobileapp/data/searchrepository.dart';
import 'package:sellit_mobileapp/data/userrepository.dart';
import 'package:sellit_mobileapp/globalwidgets/loading.dart';
import 'package:sellit_mobileapp/globalwidgets/splashpage.dart';
import 'package:sellit_mobileapp/routes/router.dart';
import 'package:sellit_mobileapp/screens/buttomNav.dart';
import 'package:sellit_mobileapp/screens/login.dart';
import 'package:sellit_mobileapp/services/coredata.dart';
import 'package:sellit_mobileapp/utilis/utili.dart';

class SimpleBlocDelegate extends BlocDelegate {
  @override
  void onEvent(Bloc bloc, Object event) {
    super.onEvent(bloc, event);
    print(event);
  }

  @override
  void onTransition(Bloc bloc, Transition transition) {
    super.onTransition(bloc, transition);
    print(transition);
  }

  @override
  void onError(Bloc bloc, Object error, StackTrace stacktrace) {
    super.onError(bloc, error, stacktrace);
    print(error);
  }
}

void main() {
  BlocSupervisor.delegate = SimpleBlocDelegate();
  final userRepository = UserServices();
  final productRepository = ProductService();
  final categoryRepository = CategoryService();
  final searchRepository = SearchService();

  runApp(MultiBlocProvider(
    providers: [
      BlocProvider<AuthenticationBloc>(create: (context) {
        return AuthenticationBloc(userRepository: userRepository)
          ..add(AppStarted());
      }),
      BlocProvider<ProductBloc>(create: (context) {
        return ProductBloc(
            productRepository: productRepository,
            categoryRepository: categoryRepository)
          ..add(FetchProduct());
      }),
      BlocProvider<SearchBloc>(create: (context) {
        return SearchBloc(searchRepository: searchRepository);
      })
    ],
    child: MyApp(
      userRepository: userRepository,
    ),
  ));
}

class MyApp extends StatelessWidget {
  final UserRepository userRepository;
  MyApp({Key key, @required this.userRepository}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(statusBarColor: UtilityWidget.white, systemNavigationBarColor: Color(0xFF48AC98)));
    return MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
            primarySwatch: UtilityWidget.white,
            primaryColor: UtilityWidget.white,
            accentColor: Color(0xFF48AC98),
            textTheme: TextTheme(
                title: TextStyle(
                    fontSize: 22.5,
                    fontFamily: "Varela",
                    fontWeight: FontWeight.w700,
                    color: Colors.black87),
                subtitle: TextStyle(
                  fontSize: 20.5,
                  fontFamily: "Varela",
                  fontStyle: FontStyle.normal,
                  fontWeight: FontWeight.w500,
                  color: Colors.black,
                ),
                body1: TextStyle(
                    fontSize: 16,
                    fontFamily: "Varela",
                    fontStyle: FontStyle.normal,
                    fontWeight: FontWeight.w500,
                    color: Colors.black),
                caption: TextStyle(
                    fontSize: 12.5,
                    fontFamily: "Varela",
                    fontStyle: FontStyle.normal,
                    color: Colors.black))),
        onGenerateRoute: Router.generateRoute,
        home: BlocBuilder<AuthenticationBloc, AuthenticationState>(
          builder: (context, state) {
            if (state is AuthenticationUninitialized) {
              return SplashPage();
            } else if (state is AuthenticationAuthenticated) {
              return BottomNavWrapper();
            } else if (state is AuthenticationUnauthenticated) {
              return Login(
                userRepository: userRepository,
              ); //LoadingIndicator();
            } else if (state is AuthenticationLoading) {
              return LoadingIndicator();
            } else {
              return LoadingIndicator();
            }
          },
        ));
  }
}
