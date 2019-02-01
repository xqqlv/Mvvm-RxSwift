import Foundation
import Moya
import Alamofire

// MARK: - Provider setup

private let requestClosure = {
    (endpoint: Endpoint<OpenAPI>, done: @escaping MoyaProvider<OpenAPI>.RequestResultClosure) in
    
    do {
        var urlRequest = try endpoint.urlRequest()
        urlRequest.timeoutInterval = 15
        done(.success(urlRequest))
    } catch MoyaError.requestMapping(let url) {
        done(.failure(MoyaError.requestMapping(url)))
    } catch MoyaError.parameterEncoding(let error) {
        done(.failure(MoyaError.parameterEncoding(error)))
    } catch {
        done(.failure(MoyaError.underlying(error, nil)))
    }
}

private let stubClosure: (_ type: OpenAPI) -> Moya.StubBehavior  = { type in
    switch type {
        case .newList:
         return Moya.StubBehavior.delayed(seconds: 3)
    }
}

private let endpointClosure = { (target: OpenAPI) -> Endpoint<OpenAPI> in
    var url = target.baseURL.absoluteString+"\(target.path)"
    if target.method == .get {
        var appendStr = ""
        if let para = target.parameters {
            appendStr = para.count > 0 ? "?" : ""
            for (key, value) in para {
                appendStr.append(key + "=\(value)&")
            }
            if appendStr.count > 0 {
                appendStr.remove(at: appendStr.index(before: appendStr.endIndex))
            }
        }
        url.append(appendStr)
    }
    
    var parameters = target.parameters
    if target.method == .get {
        parameters = nil
    }
    
    let endpoint: Endpoint<OpenAPI> = Endpoint(url: url,
                                               sampleResponseClosure: {.networkResponse(200, target.sampleData)},
                                               method: target.method,
                                               task: target.task,
                                               httpHeaderFields: nil)
    
    return endpoint
}

private let manager = Manager(
    configuration: URLSessionConfiguration.default,
    serverTrustPolicyManager: ServerTrustPolicyManager(policies: ["mp.openapi.pre.com": .disableEvaluation])
)

private let networkActivityPlugin = NetworkActivityPlugin {
    (change, target) -> () in
    switch(change){
        
    case .ended:
        UIApplication.shared.isNetworkActivityIndicatorVisible = false
    case .began:
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
    }
}

let RxOpenAPIProvider = MoyaProvider<OpenAPI>(endpointClosure:endpointClosure,
                                              requestClosure:requestClosure,
                                              stubClosure:stubClosure,
                                              manager:manager,
                                              plugins: [networkActivityPlugin])

public enum OpenAPI {
    case newList
}

extension OpenAPI: TargetType {
    public var sampleData: Data {
        guard let path = Bundle.main.path(forResource: "hotList", ofType: "json"), let data = NSData(contentsOfFile: path) else {
            return Data()
        }
        return data as Data
    }
    
    
    public var baseURL: URL {
        return URL(string: "https://news-at.zhihu.com/")!
    }
    
    public var path: String {
        switch self {
        case .newList:
            return "api/4/news/latest"
        }
    }
    
    public var method: Moya.Method {
        switch self {
        case .newList:
            return .get
        }
    }
    
    public var task: Task {
        switch self {
        default:
            if self.method == .get {
                return .requestPlain
            }
            return .requestParameters(parameters: self.parameters!, encoding: self.parameterEncoding)
        }
    }
    
    public var validate: Bool {
        return true
    }
    
    public var headers: [String: String]? {
        return nil
    }
}

extension OpenAPI {
    
    public var parameters: [String: Any]? {
        switch self {
        default:
            return nil
        }
    }
    
    public var parameterEncoding: ParameterEncoding {
        return JSONEncoding.default
    }
    
}



