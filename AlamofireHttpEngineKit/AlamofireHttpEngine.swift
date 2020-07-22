//
//  HttpEngine.swift
//  ShoutOutAPI
//
//  Created by Shane Whitehead on 10/10/18.
//  Copyright © 2018 KaiZen. All rights reserved.
//

import Foundation
import Alamofire
import Hydra
import Cadmus
import HttpEngineCore

public struct AlamofireHttpEngineConfiguration {
	public static var isDebugMode = false
}

public enum HTTPEngineError: Error {
	case invalidURL(url: String)
	case unsuccessful(code: Int, description: String)
	case missingExpectedPayload
}

public typealias ProgressMonitor = (Double) -> Void

extension Alamofire.Request {
	public func debugLog() -> Self {
		if AlamofireHttpEngineConfiguration.isDebugMode {
			debugPrint(self)
		}
		return self
	}
}

struct DefaultRequestResponse: RequestResponse {
	var statusCode: Int
	var statusDescription: String
	var data: Data?
	var responseHeaders: [AnyHashable : Any]?
}

public extension RequestResponse {
	
	// Checks the Http response for the request and fails if it's not 200
	func requestSuccessOrFail() throws {
		guard statusCode == 200 else {
			throw HTTPEngineError.unsuccessful(code: statusCode, description: statusDescription)
		}
	}
	
	// Checks the Http response for the request and fails if it's not 200 or if there
	// is no data associated with the response
	func requestSuccessWithDataOrFail() throws -> Data {
		guard statusCode == 200 else {
			throw HTTPEngineError.unsuccessful(code: statusCode, description: statusDescription)
		}
		guard let data = data else {
			throw HTTPEngineError.missingExpectedPayload
		}
		return data
	}
}

class AlamofireHttpEngine: HttpEngine {
	
	static let processQueue: DispatchQueue = DispatchQueue.global(qos: .userInitiated)

	let url: URL
	var parameters: [String: String]?
	var headers: [String: String]?
	var credentials: HttpEngineCore.Credentials?
	var progressMonitor: ProgressMonitor?
	var timeout: TimeInterval = 30
	
	internal lazy var session: SessionManager = {
		let sessionConfig = URLSessionConfiguration.default
		sessionConfig.timeoutIntervalForRequest = timeout
		sessionConfig.timeoutIntervalForResource = timeout * 10
		sessionConfig.requestCachePolicy = .reloadIgnoringLocalCacheData
		
		let sessionManager = SessionManager(configuration: sessionConfig)
		return sessionManager
	}()
	
	init(url: URL,
			 parameters: [String: String]? = nil,
			 headers: [String: String]? = nil,
			 credentials: HttpEngineCore.Credentials? = nil,
			 timeout: TimeInterval? = nil,
			 progressMonitor: ProgressMonitor?) {
		self.url = url
		self.headers = headers
		self.parameters = parameters
		self.credentials = credentials
		if let requestTimeout = timeout {
			self.timeout = requestTimeout
		}
		self.progressMonitor = progressMonitor
	}
	
	func process(_ response: DataResponse<Data>, then fulfill: (RequestResponse) -> Void, fail: (Error) -> Void) {
		var statusCode = -1
		var description = "Unknown"
		if let httpResponse = response.response {
			statusCode = httpResponse.statusCode
			description = HTTPURLResponse.localizedString(forStatusCode: httpResponse.statusCode)
			log(debug: """
				
				\tServer responded to request made to \(url)
				\t\twith: \(statusCode)
				\(description)
				""")
		} else {
			log(warning: "Unable to determine server response to request made to \(url)")
		}
		
		switch response.result {
		case .success(let data):
			let headers = response.response?.allHeaderFields
			
			fulfill(DefaultRequestResponse(statusCode: statusCode, statusDescription: description, data: data, responseHeaders: headers))
		case .failure(let error):
			log(error: "Request to \(url) failed with \(error)")
			fail(error)
		}
	}

  func execute(method: HTTPMethod) -> Promise<RequestResponse> {
    log(debug: "\(method) - \(url)")
    return Promise<RequestResponse>(in: .userInitiated, { (fulfill, fail, _) in
			log(debug: """

				\trequest to: \(self.url)
				""")
			self.session.request(self.url,
													 method: method,
													 parameters: nil,
													 encoding: URLEncoding.default,
													 headers: self.headers)
				.authenticate(with: self.credentials)
				.debugLog()
				//.validate()
				.downloadProgress { progress in
					self.progressMonitor?(progress.fractionCompleted)
			}.responseData(queue: AlamofireHttpEngine.processQueue,
										 completionHandler: { (response) in
											self.process(response, then: fulfill, fail: fail)
			})
		})
  }
  
  func execute(data: Data, method: HTTPMethod) -> Promise<RequestResponse> {
		return Promise<RequestResponse>(in: .userInitiated, { (fulfill, fail, _) in
			log(debug: """
				
				\trequest: \(method) to \(self.url)
				""")
			self.session.upload(data,
													to: self.url,
													method: method,
													headers: self.headers)
				.authenticate(with: self.credentials)
				//.validate()
				.debugLog()
				.uploadProgress(queue: AlamofireHttpEngine.processQueue,
												closure: { (progress) in
													self.progressMonitor?(progress.fractionCompleted)
				}).downloadProgress { progress in
					self.progressMonitor?(progress.fractionCompleted)
			}.responseData(queue: AlamofireHttpEngine.processQueue,
										 completionHandler: { (response) in
											self.process(response, then: fulfill, fail: fail)
			})
		})
  }
	
	func get() -> Promise<RequestResponse> {
    return execute(method: .get)
	}
	
	func get(data: Data) -> Promise<RequestResponse> {
    return execute(data: data, method: .get)
	}
	
  func put() -> Promise<RequestResponse> {
    return execute(method: .put)
  }
  
	func put(data: Data) -> Promise<RequestResponse> {
    return execute(data: data, method: .put)
	}
  
  func post() -> Promise<RequestResponse> {
    return execute(method: .post)
  }
	
	func post(data: Data) -> Promise<RequestResponse> {
    return execute(data: data, method: .post)
	}
	
	func post(formData: [MultipartFormItem]) -> Promise<RequestResponse> {
    return execute(using: .post, formData: formData)
  }

	func delete() -> Promise<RequestResponse> {
    return execute(method: .delete)
	}
	
	func delete(data: Data) -> Promise<RequestResponse> {
		return execute(data: data, method: .delete)
	}
	
	internal func execute(using method: HTTPMethod, formData: [MultipartFormItem]) -> Promise<RequestResponse> {
		log(debug: """
			
			\trequest: \(method) to \(self.url)
			""")
		return Promise<RequestResponse>(in: .userInitiated, { (fulfill, fail, _) in
			self.session.upload(multipartFormData: { (mfd) in
				for item in formData {
					mfd.append(item)
				}
			}, to: self.url,
				 method: method,
				 headers: self.headers) { (encodingResult) in
					switch encodingResult {
					case .success(let request, _, _):
						self.execute(request).then { (response) in
							fulfill(response)
						}.catch { (error) in
							fail(error)
						}
					case .failure(let error):
						fail(error)
					}
			}
		})
	}
		
	internal func execute(_ request: UploadRequest) -> Promise<RequestResponse> {
		return Promise<RequestResponse>(in: .userInitiated, { (fulfill, fail, _) in
			request.authenticate(with: self.credentials)
				//.validate()
				.debugLog()
				.uploadProgress(queue: AlamofireHttpEngine.processQueue,
												closure: { (progress) in
													self.progressMonitor?(progress.fractionCompleted)
				}).downloadProgress { progress in
					self.progressMonitor?(progress.fractionCompleted)
			}.responseData(queue: AlamofireHttpEngine.processQueue,
										 completionHandler: { (response) in
											self.process(response, then: fulfill, fail: fail)
			})
		})
	}
	
	internal func execute(_ request: DataRequest) -> Promise<RequestResponse> {
		return Promise<RequestResponse>(in: .userInitiated, { (fulfill, fail, _) in
			request.authenticate(with: self.credentials)
				.debugLog()
				//.validate()
				.downloadProgress { progress in
					self.progressMonitor?(progress.fractionCompleted)
			}.responseData(queue: AlamofireHttpEngine.processQueue,
										 completionHandler: { (response) in
											self.process(response, then: fulfill, fail: fail)
			})
		})
	}
}

extension Request {
	func authenticate(with credentials: HttpEngineCore.Credentials?) -> Self {
		guard let credentials = credentials else {
			return self
		}
		return authenticate(user: credentials.userName, password: credentials.password)
	}
}
