import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:candella/app/data/controllers/auth_controller.dart';
import 'package:candella/app/resources/constants/app_strings.dart';
import 'package:candella/app/resources/constants/color_palette.dart';
import 'package:candella/app/resources/constants/typedefs.dart';
import 'package:candella/app/resources/routes/app_routes.dart';
import 'package:candella/app/ui/widgets/loader.dart';
import 'package:candella/app/ui/widgets/rounded_icon_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AuthPage extends GetView<AuthController> {
  AuthPage({Key? key}) : super(key: key);

  final _loginFormKey = GlobalKey<FormState>();
  final _signUpFormKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final AuthController _authController = Get.find();

  Widget _getLoginForm(BuildContext context, FormType type) {
    return Form(
      key: _loginFormKey,
      child: Column(
        children: [
          TextFormField(
            enabled: !_authController.isLoading.value,
            controller: _authController.emailController,
            validator: _emailValidator,
            decoration: const InputDecoration(
              border: UnderlineInputBorder(),
              labelText: StringRes.emailAddress,
            ),
          ),
          SizedBox(
            height: 16,
          ),
          Obx(() {
            return TextFormField(
              controller: _authController.passwordController,
              enabled: !_authController.isLoading.value,
              obscureText: _authController.obSecure.value,
              validator: _passwordValidator,
              decoration: InputDecoration(
                  border: UnderlineInputBorder(),
                  labelText: StringRes.password,
                  suffixIcon: AppIconButton(
                      onTap: () {
                        _authController.obSecure.value =
                            !_authController.obSecure.value;
                      },
                      iconData: (_authController.obSecure.value)
                          ? Icons.visibility
                          : Icons.visibility_off)),
            );
          }),
          SizedBox(
            height: 16,
          ),
        ],
      ),
    );
  }

  Widget _getSignUpForm(BuildContext context, FormType type) {
    return Form(
      key: _signUpFormKey,
      child: Column(
        children: [
          TextFormField(
            controller: _authController.nameController,
            decoration: const InputDecoration(
              border: UnderlineInputBorder(),
              labelText: StringRes.fullName,
            ),
          ),
          SizedBox(
            height: 16,
          ),
          TextFormField(
            controller: _authController.emailController,
            validator: _emailValidator,
            decoration: const InputDecoration(
              border: UnderlineInputBorder(),
              labelText: StringRes.emailAddress,
            ),
          ),
          SizedBox(
            height: 16,
          ),
          Obx(() {
            return TextFormField(
              controller: _authController.passwordController,
              obscureText: _authController.obSecure.value,
              validator: _passwordValidator,
              decoration: InputDecoration(
                  border: UnderlineInputBorder(),
                  labelText: StringRes.password,
                  suffixIcon: AppIconButton(
                      onTap: () {
                        _authController.obSecure.value =
                            !_authController.obSecure.value;
                      },
                      iconData: (_authController.obSecure.value)
                          ? Icons.visibility
                          : Icons.visibility_off)),
            );
          }),
          SizedBox(
            height: 16,
          ),
        ],
      ),
    );
  }

  Widget _getMainBody(BuildContext context, FormType type) {
    var headline =
        Theme.of(context).textTheme.headline4!.copyWith(color: Colors.black);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 48, horizontal: 24),
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            (type == FormType.signUp)
                ? _getSignUpHeader(headline)
                : _getLoginHeader(headline),
            Column(
              children: [
                AnimatedCrossFade(
                  firstCurve: Curves.decelerate,
                  secondCurve: Curves.decelerate,
                  firstChild: _getLoginForm(context, type),
                  secondChild: _getSignUpForm(context, type),
                  crossFadeState: (type == FormType.signIn)
                      ? CrossFadeState.showFirst
                      : CrossFadeState.showSecond,
                  duration: Duration(milliseconds: 300),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      (type == FormType.signUp)
                          ? StringRes.signUp
                          : StringRes.login,
                      style: Theme.of(context).textTheme.headline6,
                    ),
                    Obx(
                      () => Loader(
                        isLoading: _authController.isLoading.value,
                        child: AppIconButton(
                          mode: IconButtonMode.rounded,
                          onTap: _handleButtonAction,
                          iconData: Icons.arrow_forward,
                          elevation: 8,
                          iconColor: Theme.of(context).colorScheme.onPrimary,
                        ),
                      ),
                    )
                  ],
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(
                    onPressed: () {
                      (type == FormType.signUp)
                          ? cycleForm(FormType.signIn)
                          : cycleForm(FormType.signUp);
                    },
                    child: Text((type == FormType.signUp)
                        ? StringRes.login
                        : StringRes.signUp)),
                TextButton(
                    onPressed: () {}, child: Text(StringRes.forgetPassword))
              ],
            )
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      resizeToAvoidBottomInset: false,
      body: GetBuilder(
        builder: (AuthController controller) {
          return (_authController.isLoading.value)
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : _getMainBody(context, controller.formType.value);
        },
      ),
    );
  }

  String? _emailValidator(String? value) {
    if (value != null && !value.trim().isEmail) {
      return 'Invalid Email Format.';
    }
  }

  String? _passwordValidator(String? value) {
    if (!(value != null && value.length >= 8 && value.length <= 32)) {
      return 'Password must be in between 8 - 32 characters.';
    }

    if (value.removeAllWhitespace.length != value.length) {
      return 'Password can\'t have whitespaces.';
    }

    if (value.isAlphabetOnly) {
      return 'Password must have at least one number';
    }
  }

  void cycleForm(targetType) {
    _authController.setFormType(targetType);
  }

  void _handleButtonAction() {
    FormType type = _authController.formType.value;
    if (type == FormType.signIn) {
      _handleLogin();
    } else {
      _handleSignUp();
    }
  }

  void _handleLogin() async {
    var state = _loginFormKey.currentState;
    if (state != null && !state.validate()) {
      return;
    }
    var result = await _authController.loginUser();
    ScaffoldMessenger.of(_scaffoldKey.currentContext!).showSnackBar(SnackBar(
      content: Text(result.message),
    ));
    if (result.status) {
      Get.offNamed(Routes.main);
    }
  }

  void _handleSignUp() async {
    var state = _signUpFormKey.currentState;
    if (state != null && !state.validate()) {
      return;
    }

    var result = await _authController.registerUser();

    ScaffoldMessenger.of(_scaffoldKey.currentContext!).showSnackBar(SnackBar(
      content: Text(result.message),
    ));
  }

  //Animations
  Widget _getSignUpHeader(TextStyle style) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Sign Up and',
            style: style,
          ),
          SizedBox(
            height: 16,
          ),
          Row(
            children: [
              Text(
                'Start ',
                style: style,
              ),
              AnimatedTextKit(
                pause: Duration.zero,
                repeatForever: true,
                animatedTexts: getList(
                  0,
                  style.copyWith(
                    color: ColorPalette.lightPink,
                  ),
                ),
              ),
            ],
          )
        ],
      );
  Widget _getLoginHeader(TextStyle style) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Welcome',
            style: style,
          ),
          SizedBox(
            height: 16,
          ),
          Text(
            'Back',
            style: style.copyWith(
              color: ColorPalette.lightPink,
            ),
          )
        ],
      );

  List<FlickerAnimatedText> getList(int index, TextStyle style) {
    List<FlickerAnimatedText> signUpWords = [
      FlickerAnimatedText('Creating',
          entryEnd: 0.3,
          speed: Duration(seconds: 2),
          textStyle: style.copyWith(color: ColorPalette.lightPink)),
      FlickerAnimatedText('Reading',
          entryEnd: 0.3,
          speed: Duration(seconds: 2),
          textStyle: style.copyWith(color: ColorPalette.lightPink)),
      FlickerAnimatedText('Exploring',
          entryEnd: 0.3,
          speed: Duration(seconds: 2),
          textStyle: style.copyWith(color: ColorPalette.lightPink)),
    ];

    List<FlickerAnimatedText> loginWords = [
      FlickerAnimatedText(
        'Back',
        entryEnd: 0.3,
        speed: Duration(seconds: 3),
        textStyle: style.copyWith(
          color: ColorPalette.lightPink,
        ),
      ),
    ];

    return (index == 0) ? signUpWords : loginWords;
  }
}
