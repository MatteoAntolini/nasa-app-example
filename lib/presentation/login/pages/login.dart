// Firebase

// // import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:nasa/application/auth/auth_bloc.dart';
// import 'package:nasa/application/favorites/favorites_cubit.dart';
// import 'package:nasa/application/user/user_bloc.dart';
// import 'package:nasa/application/user/user_state.dart';
// import 'package:nasa/domain/user/entities/user.dart';
// import 'package:nasa/errors/errors.dart';
// import 'package:nasa/presentation/login/widgets/widgets.dart';
// import 'package:nasa/route/routes.dart';
// import 'package:nasa/route/routes_names.dart';
// import 'package:nasa/util/ui/assets.dart';
// import 'package:nasa/util/ui/nasa_colors.dart';
// import 'package:nasa/util/ui/strings.dart';
// import 'package:nasa/util/ui/text_styles.dart';

// import '../../../injection_container.dart';

// class Login extends StatefulWidget {
//   @override
//   State<StatefulWidget> createState() {
//     return LoginState();
//   }
// }

// class LoginState extends State<Login> {
//   final FocusNode myFocusNodeEmailLogin = FocusNode();
//   final FocusNode myFocusNodePasswordLogin = FocusNode();

//   final FocusNode myFocusNodePassword = FocusNode();
//   final FocusNode myFocusNodeEmail = FocusNode();
//   final FocusNode myFocusNodeName = FocusNode();

//   TextEditingController loginEmailController = TextEditingController();
//   TextEditingController loginPasswordController = TextEditingController();

//   bool _obscureTextLogin = true;
//   bool _obscureTextSignup = true;
//   bool _obscureTextSignupConfirm = true;

//   TextEditingController signupEmailController = TextEditingController();
//   TextEditingController signupNameController = TextEditingController();
//   TextEditingController signupPasswordController = TextEditingController();
//   TextEditingController signupConfirmPasswordController =
//       TextEditingController();

//   @override
//   void initState() {
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return DefaultTabController(
//       length: 2,
//       child: Scaffold(
//           backgroundColor: PRIMARY,
//           resizeToAvoidBottomInset: false,
//           body: Column(
//             crossAxisAlignment: CrossAxisAlignment.stretch,
//             children: [
//               SizedBox(height: 100),
//               Container(
//                 padding: EdgeInsets.only(left: 50, right: 50, bottom: 25),
//                 child: Image.asset(
//                   NASA_LOGO,
//                 ),
//               ),
//               Padding(
//                 padding: EdgeInsets.all(20),
//                 child: _buildMenuBar(context),
//               ),
//               Expanded(
//                 child: TabBarView(
//                   children: [_buildSignIn(context), _buildSignUp(context)],
//                 ),
//               ),
//               //_userBlocConsumer(),
//               SizedBox(
//                 height: 28,
//               )
//             ],
//           )),
//     );
//   }

//   Widget _buildMenuBar(BuildContext context) {
//     return Container(
//         margin: EdgeInsets.only(left: 20, right: 20),
//         decoration: BoxDecoration(
//           color: PRIMARY_LIGHT,
//           borderRadius: BorderRadius.all(Radius.circular(25.0)),
//         ),
//         child: TabBar(
//           indicator: BoxDecoration(
//             borderRadius: BorderRadius.circular(
//               25.0,
//             ),
//             color: WHITEF1,
//           ),
//           labelColor: text70,
//           unselectedLabelColor: WHITEF1,
//           labelStyle:
//               GoogleFonts.openSans(fontSize: 24, fontWeight: FontWeight.bold),
//           tabs: [
//             Tab(
//               text: Strings.EXISTING,
//             ),
//             Tab(
//               text: Strings.NEW,
//             )
//           ],
//         ));
//   }

//   Widget _buildSignIn(BuildContext context) {
//     return Column(mainAxisSize: MainAxisSize.min, children: [
//       Stack(
//         alignment: Alignment.topCenter,
//         children: [
//           Card(
//             elevation: 2.0,
//             color: Colors.white,
//             shape: RoundedRectangleBorder(
//               borderRadius: BorderRadius.circular(8.0),
//             ),
//             child: Container(
//               width: 300.0,
//               height: 220.0,
//               child: Column(
//                 children: [
//                   Padding(
//                     padding: EdgeInsets.only(
//                         top: 20.0, bottom: 20.0, left: 25.0, right: 25.0),
//                     child: TextField(
//                       focusNode: myFocusNodeEmailLogin,
//                       controller: loginEmailController,
//                       keyboardType: TextInputType.emailAddress,
//                       style: Styles.TEXTFIELD_STYLE,
//                       decoration: InputDecoration(
//                           border: InputBorder.none,
//                           icon: Icon(
//                             FontAwesomeIcons.envelope,
//                             color: Colors.black,
//                             size: 24.0,
//                           ),
//                           hintText: Strings.EMAIL,
//                           hintStyle: Styles.HINT_STYLE),
//                     ),
//                   ),
//                   Container(
//                     width: 250.0,
//                     height: 1.0,
//                     color: Colors.grey[400],
//                   ),
//                   Padding(
//                     padding: EdgeInsets.only(
//                         top: 20.0, bottom: 20.0, left: 25.0, right: 25.0),
//                     child: TextField(
//                       focusNode: myFocusNodePasswordLogin,
//                       controller: loginPasswordController,
//                       obscureText: _obscureTextLogin,
//                       style: Styles.TEXTFIELD_STYLE,
//                       decoration: InputDecoration(
//                         border: InputBorder.none,
//                         icon: Icon(
//                           FontAwesomeIcons.lock,
//                           size: 24.0,
//                           color: Colors.black,
//                         ),
//                         hintText: Strings.PASSWORD,
//                         hintStyle: Styles.HINT_STYLE,
//                         suffixIcon: GestureDetector(
//                           onTap: _toggleLogin,
//                           child: Icon(
//                             _obscureTextLogin
//                                 ? FontAwesomeIcons.eye
//                                 : FontAwesomeIcons.eyeSlash,
//                             size: 16.0,
//                             color: Colors.black,
//                           ),
//                         ),
//                       ),
//                     ),
//                   ),
//                   BlocBuilder<AuthBloc, AuthState>(builder: (context, state) {
//                     if (state is AuthError) {
//                       final code = state.code;
//                       if (code == ARGS_ERROR) {
//                         return Text(Strings.AUTH_ERROR, style: Styles.ERROR);
//                       }
//                     }
//                     return Container(height: 16);
//                   }),
//                 ],
//               ),
//             ),
//           ),
//           Container(
//             margin: EdgeInsets.only(top: 200),
//             width: 150,
//             child: StandardButtonSecondary(Strings.LOGIN, () {
//               final String email = loginEmailController.text.trim();
//               final String password = loginPasswordController.text.trim();
//               context
//                   .read<AuthBloc>()
//                   .add(LoginWithEmailEvent(email: email, password: password));
//             }),
//           ),
//         ],
//       ),
//       Padding(
//         padding: EdgeInsets.only(top: 10.0),
//         child: TextButton(
//             onPressed: () {},
//             child: Text(Strings.FORGOT, style: Styles.FLAT_BUTTON_STYLE)),
//       ),
//       Padding(
//         padding: EdgeInsets.only(top: 10.0),
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: <Widget>[
//             Container(
//               decoration: BoxDecoration(
//                 gradient: LinearGradient(
//                     colors: [
//                       Colors.white10,
//                       Colors.white,
//                     ],
//                     begin: FractionalOffset(0.0, 0.0),
//                     end: FractionalOffset(1.0, 1.0),
//                     stops: [0.0, 1.0],
//                     tileMode: TileMode.clamp),
//               ),
//               width: 100.0,
//               height: 1.0,
//             ),
//             Padding(
//               padding: EdgeInsets.only(left: 15.0, right: 15.0),
//               child: Text(Strings.OR, style: Styles.F1BODY_STYLE),
//             ),
//             Container(
//               decoration: BoxDecoration(
//                 gradient: LinearGradient(
//                     colors: [
//                       Colors.white,
//                       Colors.white10,
//                     ],
//                     begin: FractionalOffset(0.0, 0.0),
//                     end: FractionalOffset(1.0, 1.0),
//                     stops: [0.0, 1.0],
//                     tileMode: TileMode.clamp),
//               ),
//               width: 100.0,
//               height: 1.0,
//             ),
//           ],
//         ),
//       ),
//       SizedBox(height: 12),
//       Padding(
//           padding: EdgeInsets.only(top: 10.0),
//           child: Container(
//             decoration: BoxDecoration(
//                 color: WHITEF1, borderRadius: BorderRadius.circular(25)),
//             child: TextButton.icon(
//                 onPressed: () =>
//                     context.read<AuthBloc>().add(LoginWithGoogleEvent()),
//                 icon: Icon(
//                   FontAwesomeIcons.google,
//                   color: SECONDARY,
//                 ),
//                 label: Text(
//                   "Login with Google",
//                   style: GoogleFonts.openSans(
//                       color: text70, fontSize: 18, fontWeight: FontWeight.bold),
//                 )),
//           )),
//     ]);
//   }

//   Widget _buildSignUp(BuildContext context) {
//     return Container(
//       child: Column(
//         children: <Widget>[
//           Stack(
//             alignment: Alignment.topCenter,
//             children: <Widget>[
//               Card(
//                 elevation: 2.0,
//                 color: Colors.white,
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(8.0),
//                 ),
//                 child: Container(
//                   width: 300.0,
//                   height: 220.0,
//                   child: Column(
//                     children: <Widget>[
//                       BlocBuilder<AuthBloc, AuthState>(
//                           builder: (context, state) {
//                         if (state is RegisterError) {
//                           return Text(Strings.AUTH_ERROR, style: Styles.ERROR);
//                         } else {
//                           return Container();
//                         }
//                       }),
//                       Padding(
//                         padding: EdgeInsets.only(
//                             top: 20.0, bottom: 20.0, left: 25.0, right: 25.0),
//                         child: TextField(
//                           focusNode: myFocusNodeEmail,
//                           controller: signupEmailController,
//                           keyboardType: TextInputType.emailAddress,
//                           style: Styles.TEXTFIELD_STYLE,
//                           decoration: InputDecoration(
//                               border: InputBorder.none,
//                               icon: Icon(
//                                 FontAwesomeIcons.envelope,
//                                 color: Colors.black,
//                               ),
//                               hintText: Strings.EMAIL,
//                               hintStyle: Styles.HINT_STYLE),
//                         ),
//                       ),
//                       Container(
//                         width: 250.0,
//                         height: 1.0,
//                         color: Colors.grey[400],
//                       ),
//                       Padding(
//                         padding: EdgeInsets.only(
//                             top: 20.0, bottom: 20.0, left: 25.0, right: 25.0),
//                         child: TextField(
//                           focusNode: myFocusNodePassword,
//                           controller: signupPasswordController,
//                           obscureText: _obscureTextSignup,
//                           style: Styles.TEXTFIELD_STYLE,
//                           decoration: InputDecoration(
//                             border: InputBorder.none,
//                             icon: Icon(
//                               FontAwesomeIcons.lock,
//                               color: Colors.black,
//                             ),
//                             hintText: Strings.PASSWORD,
//                             hintStyle: Styles.HINT_STYLE,
//                             suffixIcon: GestureDetector(
//                               onTap: _toggleSignup,
//                               child: Icon(
//                                 _obscureTextSignup
//                                     ? FontAwesomeIcons.eye
//                                     : FontAwesomeIcons.eyeSlash,
//                                 size: 15.0,
//                                 color: Colors.black,
//                               ),
//                             ),
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//               Container(
//                 margin: EdgeInsets.only(top: 200.0),
//                 width: 150,
//                 child: StandardButtonSecondary(Strings.SIGNUP, () {
//                   final email = signupEmailController.text.trim();
//                   final password = signupPasswordController.text.trim();
//                   context
//                       .read<AuthBloc>()
//                       .add(RegisterEvent(email: email, password: password));
//                 }),
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }

//   void _toggleLogin() {
//     setState(() {
//       _obscureTextLogin = !_obscureTextLogin;
//     });
//   }

//   void _toggleSignup() {
//     setState(() {
//       _obscureTextSignup = !_obscureTextSignup;
//     });
//   }

//   void _toggleSignupConfirm() {
//     setState(() {
//       _obscureTextSignupConfirm = !_obscureTextSignupConfirm;
//     });
//   }

//   // Widget _userBlocConsumer() {
//   //   return BlocConsumer<UserBloc, UserState>(builder: (context, state) {
//   //     return Container();
//   //   }, listener: (context, state) {
//   //     if (state is UserCompleted) {
//   //       final User user = state.user;
//   //       sl.registerSingleton(user);
//   //       context.read<FavoritesCubit>().fetchFavorites(user.favorites);
//   //       // sl<FirebaseMessaging>().subscribeToTopic('apod');
//   //       _toHomeScreen();
//   //     } else if (state is UserError) {
//   //       final code = state.code;
//   //     }
//   //   });
//   // }

//   void _toHomeScreen() {
//     Routes.seafarer.pop();
//     Routes.seafarer.navigate(HOME_ROUTE);
//   }
// }
