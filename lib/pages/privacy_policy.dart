import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gym_in/constants.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class PrivacyPolicyPage extends HookWidget {
  const PrivacyPolicyPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Container(
              color: Theme.of(context).scaffoldBackgroundColor,
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 3),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(35),
                      border: Border.all(
                          width: 2.0, color: Theme.of(context).backgroundColor),
                    ),
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 6.0),
                        child: IconButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon: Icon(
                            Icons.arrow_back_ios,
                            color: Theme.of(context).backgroundColor,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Center(
                      child: Text(
                        "Privacy Policy",
                        style: kSubHeadingStyle.copyWith(
                            color:
                                Theme.of(context).textTheme.bodyText2!.color),
                      ),
                    ),
                  ),
                  Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(35),
                      border: Border.all(
                        width: 2.0,
                        color: Theme.of(context).scaffoldBackgroundColor,
                      ),
                    ),
                    child: Center(
                      child: IconButton(
                        onPressed: () {},
                        icon: Icon(
                          Icons.download,
                          color: Theme.of(context).scaffoldBackgroundColor,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Container(
                child: SfPdfViewer.network(
                    "https://firebasestorage.googleapis.com/v0/b/gym-in-14938.appspot.com/o/privacypolicy%2FPrivacy_Policy.pdf?alt=media&token=c4a99e1e-c54c-4169-ac08-4cb8b063c2a7"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
