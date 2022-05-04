//
//  Created by Emarsys
//

import Foundation
import EmarsysSDK

class InlineInAppView: NSObject, FlutterPlatformView {
    let inlineInAppView : EMSInlineInAppView
    var messenger: FlutterBinaryMessenger?
    
    init(
        frame: CGRect,
        viewIdentifier viewId: Int64,
        arguments args: Dictionary<String, String>,
        binaryMessenger messenger: FlutterBinaryMessenger?) {
            self.inlineInAppView = EMSInlineInAppView()
            self.messenger = messenger
            super.init()
            registerCloseBlock(viewId: viewId)
            registerCompletionBlock(viewId: viewId)
            registerEventHandler(viewId: viewId)
            self.inlineInAppView.loadInApp(viewId: args["viewId"])
        }
    
    func view() -> UIView {
        return inlineInAppView
    }
    
    func registerCloseBlock(viewId: Int64) {
        let streamHandler = createStreamHandler(viewId: viewId, channelName: "inlineInAppViewOnClose")
        self.inlineInAppView.closeBlock = streamHandler!.voidHandler
    }
    
    func registerCompletionBlock(viewId: Int64) {
        let streamHandler = createStreamHandler(viewId: viewId, channelName: "inlineInAppViewOnCompleted")
        self.inlineInAppView.completionBlock = streamHandler!.completionHandler
    }
    
    func registerEventHandler(viewId: Int64) {
        let streamHandler = createStreamHandler(viewId: viewId, channelName: "inlineInAppViewOnAppEvent")
        self.inlineInAppView.eventHandler = streamHandler!.eventHandler
    }
    
    func createStreamHandler(viewId: Int64, channelName: String) -> EmarsysStreamHandler? {
        let streamHandler = EmarsysStreamHandler()
        guard let messenger = self.messenger else {
            return nil
        }
        let channel = FlutterEventChannel(name: "\(channelName)\(viewId)", binaryMessenger: messenger)
        channel.setStreamHandler(streamHandler)
        return streamHandler
    }
}
