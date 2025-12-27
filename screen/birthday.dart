import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:ticktokclone/repos/signup_view_model.dart';
import 'package:ticktokclone/screen/authentication/emailscreen.dart';
import 'package:ticktokclone/screen/interests.dart';
import 'package:ticktokclone/setting/gaps.dart';
import 'package:ticktokclone/setting/sizes.dart';
import 'package:ticktokclone/widgets/button/formbutton.dart';

class BirthdayScreen extends ConsumerStatefulWidget {
  const BirthdayScreen({super.key});

  @override
  ConsumerState<BirthdayScreen> createState() => BirthdayScreenState();
}

class BirthdayScreenState extends ConsumerState<BirthdayScreen> {
  void onBackgroundTap(BuildContext context) {
    FocusScope.of(context).unfocus();
  }

  final DateTime _dateTime = DateTime(2000);
  final TextEditingController _controller = TextEditingController();

  void onNextTap() {
    if (_birthday.isNotEmpty) {
      // Navigator.of(
      //   context,
      // ).push(MaterialPageRoute(builder: (context) => Interests()));
      ref.read(signUpProvider.notifier).signup(context);

      // context.pushReplacementNamed(Interests.routeName);
    } else {
      return;
    }
  }

  String _birthday = "";

  void _onDateChanged(DateTime date) {
    _birthday = date.toString().split(" ").first;
    _controller.value = TextEditingValue(text: _birthday);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _onDateChanged(_dateTime);
    _controller.addListener(() {
      setState(() {
        _birthday = _controller.text;
      });
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Sign up",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: Sizes.size24),
        ),
      ),
      body: GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: () => onBackgroundTap(context),
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: Sizes.size20,
            vertical: Sizes.size16,
          ),
          child: Column(
            children: [
              Row(
                children: [
                  /// start of birthday column
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "birthday",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: Sizes.size24,
                        ),
                      ),
                      Text(
                        maxLines: 2,
                        "You can always change this later.",
                        style: TextStyle(
                          fontWeight: FontWeight.normal,
                          fontSize: Sizes.size16,
                        ),
                      ),
                    ],
                  ),
                  Gaps.h36,
                ],
              ),
              TextField(
                decoration: InputDecoration(
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey),
                  ),
                  labelText: "Birthday",
                  hintText: "input your birthday",
                ),
                controller: _controller,
              ),
              Gaps.v28,
              GestureDetector(
                onTap: ref.watch(signUpProvider).isLoading
                    ? null
                    : () => onNextTap(),
                child: FormButton(
                  isInput: _birthday.isNotEmpty,
                  disabled: ref.watch(signUpProvider).isLoading,
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        height: 300,
        child: CupertinoDatePicker(
          dateOrder: DatePickerDateOrder.ymd,
          minimumDate: DateTime(1925),
          maximumDate: DateTime(2000),
          onDateTimeChanged: _onDateChanged,
          initialDateTime: _dateTime,
          mode: CupertinoDatePickerMode.date,
          use24hFormat: true,
        ),
      ),
    );
  }
}
