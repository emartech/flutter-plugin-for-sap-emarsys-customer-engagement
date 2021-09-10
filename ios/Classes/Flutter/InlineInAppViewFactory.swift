//
//  Created by Emarsys
//

import Foundation
import Flutter
import UIKit
import EmarsysSDK

class InlineInAppViewFactory: NSObject, FlutterPlatformViewFactory {
    private var messenger: FlutterBinaryMessenger

    init(messenger: FlutterBinaryMessenger) {
        self.messenger = messenger
        super.init()
    }
    
    public func createArgsCodec() -> FlutterMessageCodec & NSObjectProtocol {
          return FlutterStandardMessageCodec.sharedInstance()
    }
    
    func create(
        withFrame frame: CGRect,
        viewIdentifier viewId: Int64,
        arguments args: Any?
    ) -> FlutterPlatformView {
        return InlineInAppView(
            frame: frame,
            viewIdentifier: viewId,
            arguments: args as? Dictionary<String, String> ?? Dictionary(),
            binaryMessenger: messenger)
    }
}


