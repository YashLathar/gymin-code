import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gym_in/constants.dart';
import 'package:gym_in/services/storage_service.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class PrivacyPolicyPage extends HookWidget {
  const PrivacyPolicyPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final downloadedUrl = useState("");
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
                        color: Theme.of(context).backgroundColor,
                      ),
                    ),
                    child: Center(
                      child: IconButton(
                        onPressed: () async {
                          final url = await context
                              .read(storageServiceProvider)
                              .getPrivacyUrl();

                          downloadedUrl.value = url!;
                        },
                        icon: Icon(
                          Icons.download,
                          color: Theme.of(context).backgroundColor,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              child: SfPdfViewer.network(downloadedUrl.value ?? 'https://cdn.syncfusion.com/content/PDFViewer/flutter-succinctly.pdf'),
            ),
          ],
        ),
      ),
    );
  }
}