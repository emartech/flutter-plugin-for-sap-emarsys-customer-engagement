protocol EmarsysCommandProtocol {
    
    func execute(arguments: [String: Any]?, resultCallback: @escaping ResultCallback)
    
}
