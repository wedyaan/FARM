import 'package:farm/widget/app_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'account/register_acount_page.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  final String imagePath = "assets/images/welcome_image.png";

  @override
  void initState() {
    super.initState();
    _afterToSecondsGoToNextPage();
  }

  void _afterToSecondsGoToNextPage() async {
    await Future.delayed(const Duration(seconds: 3));
    onGetStartedClicked(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(imagePath),
          fit: BoxFit.cover,
        ),
      ),
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            const Spacer(),
            icon(),
            const SizedBox(
              height: 20,
            ),
            welcomeTextWidget(),
            const SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
    ));
  }

  Widget icon() {
    String iconPath = "assets/icons/app_icon_color.svg";
    return SvgPicture.asset(
      iconPath,
      width: 48,
      height: 56,
    );
  }

  Widget welcomeTextWidget() {
    return Column(
      children: const [
        AppText(
          text: "اهلا وسهلا بكم",
          fontSize: 40,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
        AppText(
          text: "في تطبيق المزرعة",
          fontSize: 18,
          fontWeight: FontWeight.w600,
          color: Colors.white,
        ),
      ],
    );
  }

  // Widget getButton(BuildContext context) {
  void onGetStartedClicked(BuildContext context) {
    Navigator.of(context).pushReplacement(MaterialPageRoute(
      builder: (BuildContext context) {
        return const RegisterAccountPage();
      },
    ));
  }
}
