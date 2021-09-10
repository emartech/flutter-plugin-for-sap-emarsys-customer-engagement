//
//  Created by Emarsys
//

import Foundation
import EmarsysSDK

class InlineInAppView: NSObject, FlutterPlatformView {
    let inlineInAppView : EMSInlineInAppView
    
    init(
        frame: CGRect,
        viewIdentifier viewId: Int64,
        arguments args: Dictionary<String, String>,
        binaryMessenger messenger: FlutterBinaryMessenger?
    ) {
        self.inlineInAppView = EMSInlineInAppView()
        self.inlineInAppView.loadInApp(viewId: args["viewId"])
        super.init()
    }

    func view() -> UIView {
        return inlineInAppView
    }
}
