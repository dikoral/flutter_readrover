import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_readrover/Data/DataSource/ListDataSource.dart';
import 'package:flutter_readrover/Data/DataSource/UserDataSource.dart';
import 'package:flutter_readrover/Data/Repository/ListRepository.dart';
import 'package:flutter_readrover/Data/Repository/UserRepository.dart';
import 'package:flutter_readrover/Domain/Use_Case/UserUseCase.dart';
import 'package:flutter_readrover/Presentation/Bloc/User/user_bloc.dart';
import 'package:flutter_readrover/Data/Repository/BookRepository.dart';
import 'package:flutter_readrover/Domain/Use_Case/ListUseCase.dart';
import 'package:flutter_readrover/Presentation/Screen/Splash.dart';
import 'package:flutter_readrover/firebase_options.dart';
import 'package:flutter_readrover/generated/codegen_loader.g.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  EasyLocalization.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  AuthenticationDataSource authDataSource = AuthenticationDataSource();
  AuthenticationRepository authRepository = AuthenticationRepository(dataSource: authDataSource, firestore: FirebaseFirestore.instance);
  SignInUseCase signInUseCase = SignInUseCase(authRepository);
  SignUpUseCase signUpUseCase = SignUpUseCase(authRepository);

  final dio = Dio();
  final apiService = ApiService(dio); 
  final bookDataSource = BookDataSource(apiService);
  final bookRepository = BookRepository(bookDataSource);
  final getBooksUseCase = GetBooksUseCase(bookRepository);

  runApp(
  EasyLocalization(
    supportedLocales: [Locale('en'), Locale('kk'), Locale('ru')],
    path: 'assets/translations', 
    fallbackLocale: Locale('en'),
    child: MyApp(getBooksUseCase, signInUseCase, signUpUseCase),
    assetLoader: CodegenLoader()
  ),
);
}

class MyApp extends StatelessWidget {
  final GetBooksUseCase getBooksUseCase;
  final SignInUseCase signInUseCase;
  final SignUpUseCase signUpUseCase;

  MyApp(this.getBooksUseCase, this.signInUseCase, this.signUpUseCase);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<AuthenticationBloc>(
      create: (context) => AuthenticationBloc(
        signInUseCase: signInUseCase,
        signUpUseCase: signUpUseCase,
      ),
      child: MaterialApp(
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
        theme: ThemeData(
          primarySwatch: Colors.purple,
        ),
        home: SplashScreen(getBooksUseCase: getBooksUseCase),
      ),
    );
  }
}