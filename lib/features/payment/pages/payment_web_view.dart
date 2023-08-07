import 'dart:collection';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import '../../../app/core/utils/styles.dart';
import '../../../app/localization/localization/language_constant.dart';
import '../../../components/custom_app_bar.dart';
import '../../../data/api/end_points.dart';
import '../../../navigation/custom_navigation.dart';
import '../../../navigation/routes.dart';

class PaymentWebView extends StatefulWidget {
  final int id;

  const PaymentWebView({super.key, required this.id});

  @override
  State<PaymentWebView> createState() => _PaymentWebViewState();
}

class _PaymentWebViewState extends State<PaymentWebView> {
  double value = 0.0;
  InAppWebViewController? webViewController;
  PullToRefreshController? pullToRefreshController;
  ContextMenu? contextMenu;

  double progress = 0;
  late MyInAppBrowser browser;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: CustomAppBar(
        title: getTranslated("payment", context),
      ),
      body: Center(
        child: SizedBox(
          width: 1170,
          child: Stack(
            children: [
              InAppWebView(
                initialUrlRequest: URLRequest(
                  url: WebUri.uri(
                    Uri.parse(EndPoints.baseUrl + EndPoints.payment(widget.id)),
                  ),
                ),
                pullToRefreshController: pullToRefreshController,
                initialOptions: InAppWebViewGroupOptions(
                    crossPlatform: InAppWebViewOptions(

                        // //
                        // ios: IOSInAppWebViewOptions(applePayAPIEnabled: true),
                        // crossPlatform: InAppWebViewOptions(
                        //     useShouldOverrideUrlLoading: true, useOnLoadResource: true),
                        //
                        //
                        // javaScriptEnabled: true,
                        // userAgent:
                        //     'Mozilla/5.0 (iPhone; CPU iPhone OS 9_3 like Mac OS X) AppleWebKit/601.1.46 (KHTML, like Gecko) Version/9.0 Mobile/13E233 Safari/601.1',
                        ),
                    android: AndroidInAppWebViewOptions(
                      useHybridComposition: true,
                    ),
                    ios: IOSInAppWebViewOptions(
                      allowsInlineMediaPlayback: true,
                    )),
                onProgressChanged: (controller, progress) {
                  if (progress == 100) {
                    pullToRefreshController!.endRefreshing();
                  }
                  setState(() {
                    this.progress = progress / 100;
                  });
                },
                onWebViewCreated: (controller) {
                  setState(() {
                    webViewController = controller;
                  });
                },
                contextMenu: contextMenu,
                onUpdateVisitedHistory: (controller, url, androidIsReload) {
                  log("PATH${url!.path}");
                  log("query${url.query}");
                  bool isSuccess = url.query.contains('success');
                  bool isFailed = url.query.contains('fail');
                  bool isCancel = url.query.contains('cancel');

                  if (isSuccess) {
                    CustomNavigator.push(Routes.SUCCESS,
                        replace: true,
                        arguments: {"isDone": true, "date": DateTime.now()});
                  } else if (isFailed || isCancel) {
                    CustomNavigator.push(Routes.SUCCESS,
                        replace: true,
                        arguments: {
                          "isDone": false,
                        });
                  }
                },
                onConsoleMessage: (controller, consoleMessage) {
                  log("$consoleMessage");
                },
                onCloseWindow: (c) {},
              ),
              progress < 1.0
                  ? LinearProgressIndicator(
                      value: progress,
                      color: Styles.PRIMARY_COLOR,
                      backgroundColor: Colors.red.shade50,
                    )
                  : const SizedBox.shrink(),
            ],
          ),
        ),
      ),
    );
  }
}

class MyInAppBrowser extends InAppBrowser {
  final BuildContext context;

  MyInAppBrowser(
    this.context, {
    int? windowId,
    UnmodifiableListView<UserScript>? initialUserScripts,
  }) : super(windowId: windowId, initialUserScripts: initialUserScripts);

  bool _canRedirect = true;

  @override
  Future onBrowserCreated() async {
    print("\n\nBrowser Created!\n\n");
  }

  @override
  Future onLoadStart(url) async {
    print("\n\nStarted: $url\n\n");
    _pageRedirect(url.toString());
  }

  @override
  Future onLoadStop(url) async {
    pullToRefreshController?.endRefreshing();
    print("\n\nStopped: $url\n\n");
    _pageRedirect(url.toString());
  }

  @override
  void onLoadError(url, code, message) {
    pullToRefreshController?.endRefreshing();
    print("Can't load [$url] Error: $message");
  }

  @override
  void onProgressChanged(progress) {
    if (progress == 100) {
      pullToRefreshController?.endRefreshing();
    }
    log("Progress: $progress");
  }

  @override
  void onExit() {
    if (_canRedirect) {
      CustomNavigator.pop();
    }
    log("\n\nBrowser closed!\n\n");
  }

  @override
  Future<NavigationActionPolicy> shouldOverrideUrlLoading(
      navigationAction) async {
    log("\n\nOverride ${navigationAction.request.url}\n\n");
    return NavigationActionPolicy.ALLOW;
  }

  @override
  void onLoadResource(LoadedResource resource) {
    // print("Started at: " + response.startTime.toString() + "ms ---> duration: " + response.duration.toString() + "ms " + (response.url ?? '').toString());
  }

  @override
  void onConsoleMessage(consoleMessage) {
    log("""
    console output:
      message: ${consoleMessage.message}
      messageLevel: ${consoleMessage.messageLevel.toValue()}
   """);
  }

  void _pageRedirect(String url) {
    if (_canRedirect) {
      log("PATH$url");
      log("query$url");
      bool isSuccess = url.contains('success');
      bool isFailed = url.contains('fail');
      bool isCancel = url.contains('cancel');

      if (isSuccess) {
        CustomNavigator.push(Routes.SUCCESS,
            replace: true, arguments: {"isDone": true, "date": DateTime.now()});
      } else if (isFailed || isCancel) {
        CustomNavigator.push(Routes.SUCCESS,
            replace: true, arguments: {"isDone": false});
      }
    }
  }
}
