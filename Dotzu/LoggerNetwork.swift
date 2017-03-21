//
//  LoggerNetwork.swift
//  exampleWindow
//
//  Created by Remi Robert on 24/01/2017.
//  Copyright © 2017 Remi Robert. All rights reserved.
//

import Foundation

fileprivate var bodyValues = [String:Data]()

extension NSMutableURLRequest {

    @objc class func httpBodyHackSwizzle() {
        let setHttpBody = class_getInstanceMethod(self, #selector(setter: NSMutableURLRequest.httpBody))
        let httpBodyHackSetHttpBody = class_getInstanceMethod(self, #selector(self.httpBodyHackSetHttpBody(body:)))
        method_exchangeImplementations(setHttpBody, httpBodyHackSetHttpBody)
    }

    @objc func httpBodyHackSetHttpBody(body: NSData?) {
        defer {
            httpBodyHackSetHttpBody(body: body)
        }
        let keyRequest = "\(hashValue)"
        guard let body = body, bodyValues[keyRequest] == nil else { return }
        bodyValues[keyRequest] = body as Data
    }
}

class LoggerNetwork: URLProtocol, LogGenerator {

    var connection: NSURLConnection?
    var sessionTask: URLSessionTask?
    var responseData: NSMutableData?
    var response: URLResponse?
    var newRequest: NSMutableURLRequest?
    var currentLog: LogRequest?
    let store = StoreManager<LogRequest>(store: .network)

    var enable: Bool = true {
        didSet {
            if enable {
                LoggerNetwork.register()
            } else {
                LoggerNetwork.unregister()
            }
        }
    }

    static let shared = LoggerNetwork()

    lazy var queue: OperationQueue = {
        var queue = OperationQueue()
        queue.name = "request.logger.queue"
        queue.maxConcurrentOperationCount = 1
        return queue
    }()

    var session: URLSession?

    open class func register() {
        NSMutableURLRequest.httpBodyHackSwizzle()
        URLProtocol.registerClass(LoggerNetwork.classForCoder())
    }

    open class func unregister() {
        URLProtocol.unregisterClass(LoggerNetwork.classForCoder())
    }

    open override class func canInit(with request: URLRequest) -> Bool {
        if !LogsSettings.shared.network ||
            !LoggerNetwork.shared.enable ||
            self.property(forKey: "MyURLProtocolHandledKey", in: request) != nil {
            return false
        }
        return true
    }

    open override class func canonicalRequest(for request: URLRequest) -> URLRequest {
        return request
    }

    open override class func requestIsCacheEquivalent(_ reqA: URLRequest, to reqB: URLRequest) -> Bool {
        return super.requestIsCacheEquivalent(reqA, to: reqB)
    }

    open override func startLoading() {
        guard let req = (request as NSURLRequest).mutableCopy() as? NSMutableURLRequest,
            newRequest == nil else { return }

        LoggerNetwork.setProperty(true, forKey: "MyURLProtocolHandledKey", in: req)
        LoggerNetwork.setProperty(Date(), forKey: "MyURLProtocolDateKey", in: req)
        self.newRequest = req
        session = URLSession(configuration: URLSessionConfiguration.default, delegate: self, delegateQueue: queue)
        sessionTask = session?.dataTask(with: req as URLRequest)
        sessionTask?.resume()

        responseData = NSMutableData()
        currentLog = LogRequest(request: req)
        LogNotificationApp.newRequest.post(Void())
    }

    open override func stopLoading() {
        sessionTask?.cancel()
        guard let log = currentLog else {return}

        let keyRequest = "\(newRequest?.hashValue ?? 0)"
        log.httpBody = bodyValues["\(keyRequest)"]
        bodyValues.removeValue(forKey: keyRequest)

        if let startDate = LoggerNetwork.property(forKey: "MyURLProtocolDateKey",
                                                  in: newRequest! as URLRequest) as? Date {
            let difference = fabs(startDate.timeIntervalSinceNow)
            log.duration = difference
        }
        store.add(log: log)
        LogNotificationApp.stopRequest.post(Void())
    }
}

extension LoggerNetwork: URLSessionDataDelegate, URLSessionTaskDelegate {
    public func urlSession(_ session: URLSession, task: URLSessionTask, didCompleteWithError error: Error?) {
        if let error = error {
            client?.urlProtocol(self, didFailWithError: error)
            let reason = (error as NSError).localizedDescription
            currentLog?.errorClientDescription = reason
            return
        }
        client?.urlProtocolDidFinishLoading(self)
    }

    public func urlSession(_ session: URLSession, didBecomeInvalidWithError error: Error?) {
        if let error = error {
            let error = (error as NSError).localizedDescription
            currentLog?.errorClientDescription = error
            return
        }
    }

    public func urlSession(_ session: URLSession, dataTask: URLSessionDataTask,
                           didReceive response: URLResponse,
                           completionHandler: @escaping (URLSession.ResponseDisposition) -> Void) {
        client?.urlProtocol(self, didReceive: response, cacheStoragePolicy: .notAllowed)
        completionHandler(.allow)

        currentLog?.initResponse(response: response)
        if let data = responseData {
            currentLog?.dataResponse = data as NSData
        }
    }

    public func urlSession(_ session: URLSession, dataTask: URLSessionDataTask, didReceive data: Data) {
        client?.urlProtocol(self, didLoad: data)
        responseData?.append(data)
    }
}
