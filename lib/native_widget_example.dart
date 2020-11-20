import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';


class NativeWidgetExample extends State<StatefulWidget> {
  final Map<String, dynamic> creationParams = <String, dynamic>{};

  @override
  Widget build(BuildContext context) {
    creationParams["offset_x"] = 500;
    creationParams["offset_y"] = 0;
    creationParams["width"] = 300;
    creationParams["height"] = 300;

    var gestureRecognizers = <Factory<OneSequenceGestureRecognizer>>[
          new Factory<OneSequenceGestureRecognizer>(
            () => new EagerGestureRecognizer(),
          )].toSet();

            /// Creates the controller and kicks off its initialization.
  MacOSPVController createMacOSPVController(PlatformViewCreationParams params) {
    final MacOSPVController controller = MacOSPVController(1, "idk");
    controller._initialize().then((_) { params.onPlatformViewCreated(params.id); });
    return controller;
  }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Hello!'),
      ),
      // We're using a Builder here so we have a context that is below the Scaffold
      // to allow calling Scaffold.of(context) so we can show a snackbar.
      body: Builder(builder: (BuildContext context) {

        return PlatformViewLink(
       viewType: '<platform-view-type>',
       onCreatePlatformView: createMacOSPVController, // need a controller.
       surfaceFactory: (BuildContext context, PlatformViewController controller) {
        return PlatformViewSurface(
        gestureRecognizers: gestureRecognizers,            
        controller: controller,
            hitTestBehavior: PlatformViewHitTestBehavior.opaque,
        );
       },
    );
    }),
    floatingActionButton: FloatingActionButton(
      onPressed: () {
        print("hello world");
      }
    ),
    );
  }
  
}     

class MacOSPVController extends PlatformViewController {
  MacOSPVController(
    this.viewId,
    this.viewType,
  );

  @override
  final int viewId;

  /// The unique identifier for the HTML view type to be embedded by this widget.
  ///
  /// A PlatformViewFactory for this type must have been registered.
  final String viewType;

  bool _initialized = false;

  Future<void> _initialize() async {
    final Map<String, dynamic> args = <String, dynamic>{
      'id': viewId,
      'viewType': viewType,
    };
    await SystemChannels.platform_views.invokeMethod<void>('create', args);
    _initialized = true;
  }

  @override
  Future<void> clearFocus() async {
  }

  @override
  Future<void> dispatchPointerEvent(PointerEvent event) async {
  }

  @override
  Future<void> dispose() async {
    if (_initialized) {
      await SystemChannels.platform_views.invokeMethod<void>('dispose', viewId);
    }
  }
}