# Demo for embedding WKWebView in MacOS Flutter Application

![image](https://user-images.githubusercontent.com/25163644/101827751-ad634380-3afe-11eb-94a9-c8ac7ecccb07.png)

## Instructions
Checkout my Flutter/engine branch with MacOS Platform view support
The WKWebView platform view is hardcoded and registered in FlutterEngine.mm
https://github.com/RichardJCai/engine/tree/webview_demo_12082020

Compile the engine and run this app for macOS.

To run the app using the compiled version of the engine

Compile the engine for macOS (on my branch of the engine webview_demo_12082020) following these steps
https://github.com/flutter/flutter/wiki/Compiling-the-engine

Run the webview_demo flutter application:
`flutter run -d macos --local-engine-src-path /your/path/to/engine/src --local-engine host_debug_unopt`

