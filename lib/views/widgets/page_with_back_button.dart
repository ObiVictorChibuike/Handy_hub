import 'package:esolink/views/constants/colors.dart';
import 'package:esolink/views/constants/text_decoration.dart';
import 'package:esolink/views/widgets/back_button.dart';
import 'package:flutter/material.dart';

class PageWithBackButton extends StatelessWidget {
  const PageWithBackButton(
      {Key? key,
      this.body,
      this.action,
      this.title,
      this.padding,
      this.automaticallyImplyLeading,
      this.onDispose,
      this.globalKey})
      : super(key: key);

  final Widget? body;
  final Widget? action;
  final String? title;
  final EdgeInsetsGeometry? padding;
  final bool? automaticallyImplyLeading;
  final VoidCallback? onDispose;
  final GlobalKey<ScaffoldState>? globalKey;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: globalKey,
      body: Container(
        color: null,
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Container(
            height: 100,
            color: white,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 52, 22, 22),
              child: Row(
                // crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  automaticallyImplyLeading ?? true
                      ? InkWell(
                          onTap: () {
                            Navigator.pop(context);
                            onDispose != null ? onDispose!() : debugPrint('');
                          },
                          child: const EsolinkBackButton())
                      : const SizedBox(),
                  const Spacer(),
                  Visibility(
                      visible: title != null,
                      child: Text("$title",
                          textAlign: TextAlign.center,
                          style: subHeaderText.copyWith(
                              color: Colors.black,
                              fontSize: 18,
                          
                              fontWeight: FontWeight.bold))),
                  const Spacer(),
                  Visibility(
                    visible: action != null,
                    child: action ?? const SizedBox(),
                  )
                ],
              ),
            ),
          ),
         
          body!,
        ]),
      ),
    );
  }
}
