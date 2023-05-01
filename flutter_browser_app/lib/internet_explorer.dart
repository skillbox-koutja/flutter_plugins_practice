import 'package:flutter/material.dart';
import 'package:flutter_browser_app/internet_explorer/controls.dart';
import 'package:flutter_browser_app/internet_explorer/controls_status.dart';
import 'package:webview_flutter/webview_flutter.dart';

class InternetExplorer extends StatefulWidget {
  const InternetExplorer({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _InternetExplorerState();
}

class _InternetExplorerState extends State<InternetExplorer> {
  late final WebViewController _controller;
  final urlAddressFocusNode = FocusNode();
  final urlAddressController = TextEditingController(text: 'https://flutter.dev');
  final ValueNotifier<IEControlsStatus> _controlsStatus = ValueNotifier(IEControlsStatus.start());

  @override
  void initState() {
    super.initState();

    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
          },
          onPageStarted: (String url) {
            final status = _controlsStatus.value.start();
            _syncStatus(status);
          },
          onPageFinished: (String url) {
            final status = _controlsStatus.value.end();
            _syncStatus(status);
          },
          onWebResourceError: (WebResourceError error) {
            debugPrint('error ${error.errorCode}');
            openOops();
          },
          onNavigationRequest: (NavigationRequest request) {
            if (request.url.startsWith('https://www.youtube.com/')) {
              return NavigationDecision.prevent;
            }
            return NavigationDecision.navigate;
          },
        ),
      );

    _controller.loadRequest(Uri.parse(urlAddressController.text));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.white,
          title: const Text(
            'Internet Explorer',
            style: TextStyle(color: Colors.black),
          ),
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(56),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  ValueListenableBuilder(
                    key: const ValueKey('goBack'),
                    valueListenable: _controlsStatus,
                    builder: (_, status, __) {
                      if (!status.canBack) {
                        return const SizedBox();
                      }

                      return IEGoBackControl(
                        onTap: status.loading ? null : () async {
                          await _controller.goBack();
                        },
                      );
                    },
                  ),
                  ValueListenableBuilder(
                    key: const ValueKey('goForward'),
                    valueListenable: _controlsStatus,
                    builder: (_, status, __) {
                      if (!status.canForward) {
                        return const SizedBox();
                      }

                      return IEGoForwardControl(
                        onTap: status.loading ? null : () async {
                          await _controller.goForward();
                        },
                      );
                    },
                  ),
                  ValueListenableBuilder(
                    key: const ValueKey('loading'),
                    valueListenable: _controlsStatus,
                    builder: (_, status, __) {
                      if (status.loading) {
                        return const IconButton(
                          onPressed: null,
                          icon: Icon(Icons.stop),
                        );
                      }

                      return IEReloadControl(
                        onTap: () async {
                          await _controller.reload();
                        },
                      );
                    },
                  ),
                  Expanded(
                    child: TextField(
                      focusNode: urlAddressFocusNode,
                      controller: urlAddressController,
                      onSubmitted: (value) async {
                        urlAddressFocusNode.unfocus();
                        final url = Uri.tryParse(value);
                        if (url == null) {
                          await openOops();
                        } else {
                          await _controller.loadRequest(url);
                        }
                      },
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(20.0))),
                        suffixIcon: Icon(Icons.search),
                        labelText: 'Type url and GO!',
                        floatingLabelBehavior: FloatingLabelBehavior.never,
                        hintText: 'Type url and GO!',
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                ],
              ),
            ),
          )),
      body: Stack(
        children: [
          WebViewWidget(controller: _controller),
          ValueListenableBuilder(
            valueListenable: _controlsStatus,
            builder: (_, status, __) {
              if (status.loading) {
                return const Center(child: CircularProgressIndicator());
              }
              return const SizedBox();
            },
          ),
        ],
      ),
    );
  }

  Future<void> _syncStatus(IEControlsStatus status) async {
    final canForward = await _controller.canGoForward();
    final canBack = await _controller.canGoBack();
    _controlsStatus.value = status.sync(
      canBack: canBack,
      canForward: canForward,
    );
    var url = await _controller.currentUrl() ?? '';
    if (url == 'about:blank') {
      url = '';
    }

    urlAddressController.text = url;
  }

  Future<void> openOops() async {
    await _controller.loadHtmlString(_oopsHtml);
  }
}

const _oopsHtml = '<html><head></head><body>Oops</body></html>';
