import 'package:flutter/material.dart';
import 'package:ticktokclone/screen/onboarding.dart';
import 'package:ticktokclone/setting/gaps.dart';
import 'package:ticktokclone/sourcefile/interestssource.dart';
import 'package:ticktokclone/widgets/button/formbutton.dart';
import 'package:ticktokclone/widgets/button/interestsbutton.dart';

class Interests extends StatefulWidget {
  const Interests({super.key});

  static const String routeUrl = "/interests";
  static const String routeName = "interests";

  @override
  State<Interests> createState() => _InterestsState();
}

class _InterestsState extends State<Interests> {
  List<String> interests = InterestsSource.iinterests;
  final ScrollController _scrollController = ScrollController();
  bool _showtitle = false;

  void onNextpage() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => Onboarding()),
    );
  }

  void _onScroll() {
    if (_scrollController.offset > 100) {
      if (_showtitle == true) return;
      setState(() {
        _showtitle = true;
        // Update UI or perform actions based on scroll position
      });
    } else {
      setState(() {
        _showtitle = false;
        // Update UI or perform actions based on scroll position
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _scrollController.addListener(() {
      _onScroll();
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: AnimatedOpacity(
          duration: Duration(milliseconds: 300),
          opacity: _showtitle ? 1.0 : 0.0,
          child: Text(
            "Choose your interests",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
          ),
        ),
        centerTitle: true,
      ),
      body: Scrollbar(
        thickness: 10,
        controller: _scrollController,
        child: SingleChildScrollView(
          controller: _scrollController,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      maxLines: 2,
                      "Choose your interests",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 40,
                      ),
                    ),
                    Gaps.v24,
                    Text(
                      "Get better video recommendations",
                      style: TextStyle(
                        fontWeight: FontWeight.normal,
                        fontSize: 20,
                      ),
                    ),
                    Wrap(
                      runSpacing: 10,
                      spacing: 10,
                      children: [
                        for (var interst in interests)
                          interestsbutton(interst: interst),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: GestureDetector(
        onTap: onNextpage,
        child: BottomAppBar(child: FormButton(isInput: true, disabled: false)),
      ),
    );
  }
}
