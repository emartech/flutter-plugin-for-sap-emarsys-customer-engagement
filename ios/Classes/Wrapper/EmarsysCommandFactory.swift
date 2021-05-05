//
// Created by Emarsys on 2021. 04. 22..
//

class EmarsysCommandFactory {

    func create(name: String) -> EmarsysCommandProtocol? {
        var result: EmarsysCommandProtocol?
        switch name {
        case "setup":
            result = SetupCommand()
        case "setContact":
            result = SetContactCommand()
        case "clearContact":
            result = ClearContactCommand()
        case "push.enablePushSending":
            result = EnablePushSendingCommand()
        default:
            result = nil
        }
        return result
    }

}
