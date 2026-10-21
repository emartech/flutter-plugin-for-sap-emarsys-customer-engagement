typealias ResultCallback = (_ result: [String: Any]) -> ()

protocol EmarsysCommandProtocol {
    
    func execute(arguments: [String: Any]?, resultCallback: @escaping ResultCallback)
    
}
