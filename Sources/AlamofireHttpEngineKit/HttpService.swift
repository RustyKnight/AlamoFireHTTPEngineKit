//
//  APIService.swift
//  ShoutOutAPI
//
//  Created by Shane Whitehead on 24/9/18.
//  Copyright © 2018 KaiZen. All rights reserved.
//

import Foundation
import Hydra
import Cadmus
import HttpEngineCore
import Alamofire

//public enum APIServiceError: Error {
//	case invalidResponse(code: Int, message: String?)
//	case noDataReturned
//	case unableToDecodeResponse
//	case invalidURLForRequest(request: String)
//	case missingExpectedPayload
//  
//  case unauthorised
//}
//
//internal class APIResponse {
//	public let data: Data?
//	public let error: Error?
//	
//	init(data: Data?, error: Error?) {
//		self.data = data
//		self.error = error
//	}
//}
//
//internal class RequestHandler {
//	let fulfill: (APIResponse) -> Void
//	
//	var data: Data?
//	var error: Error?
//	
//	init(fulfill: @escaping (APIResponse) -> Void) {
//		self.fulfill = fulfill
//	}
//}
//
//public class HttpService: NSObject {
//	
//	public static let shared: HttpService = HttpService()
//	
////	let baseHeaders: [String: String] = [
////		"accept": "application/json"
////	]
//	
//	fileprivate override init() {}
//	
//	func requestBuilder(for builder: HttpURLRequestBuilder, progressMonitor: ProgressMonitor? = nil) -> HttpRequestBuilder {
//		let requestBuilder = builder.build()
//		if let monitor = progressMonitor {
//			_ = requestBuilder.with(progressMonitor: monitor)
//		}
//		return requestBuilder
//	}
//	
//	func engine(for builder: HttpURLRequestBuilder, progressMonitor: ProgressMonitor? = nil) -> Promise<HttpEngine> {
//		return Promise<HttpEngine>({ (fulfill, fail, _) in
//			let engineBuilder = self.requestBuilder(for: builder,
//																							progressMonitor: progressMonitor)
//			fulfill(try engineBuilder.build())
//		})
//	}
//
//	public func get(from request: HttpURLRequestBuilder, progressMonitor: ProgressMonitor? = nil) -> Promise<RequestResponse> {
//    return engine(for: request, progressMonitor: progressMonitor)
//			.then { (engine) -> Promise<RequestResponse> in
//				return engine.get()
//		}
//	}
//
//	public func get(from request: HttpURLRequestBuilder, passing data: Data, progressMonitor: ProgressMonitor? = nil) -> Promise<RequestResponse> {
//		return engine(for: request, progressMonitor: progressMonitor)
//			.then { (engine) -> Promise<RequestResponse> in
//				return engine.get(data: data)
//		}
//	}
//
//	public func post(data: Data, to request: HttpURLRequestBuilder, progressMonitor: ProgressMonitor? = nil) -> Promise<RequestResponse> {
//		return engine(for: request, progressMonitor: progressMonitor)
//			.then { (engine) -> Promise<RequestResponse> in
//				return engine.post(data: data)
//		}
//	}
//
//	public func post(to request: HttpURLRequestBuilder, progressMonitor: ProgressMonitor? = nil) -> Promise<RequestResponse> {
//		return engine(for: request, progressMonitor: progressMonitor)
//			.then { (engine) -> Promise<RequestResponse> in
//				return engine.post()
//		}
//	}
//
//	public func put(data: Data, to request: HttpURLRequestBuilder, progressMonitor: ProgressMonitor? = nil) -> Promise<RequestResponse> {
//		return engine(for: request, progressMonitor: progressMonitor)
//			.then { (engine) -> Promise<RequestResponse> in
//				return engine.put(data: data)
//		}
//	}
//
//	public func put(to request: HttpURLRequestBuilder, progressMonitor: ProgressMonitor? = nil) -> Promise<RequestResponse> {
//		return engine(for: request, progressMonitor: progressMonitor)
//			.then { (engine) -> Promise<RequestResponse> in
//				return engine.put()
//		}
//	}
//
//	public func post(to request: HttpURLRequestBuilder, formData: [MultipartFormItem], progressMonitor: ProgressMonitor? = nil) -> Promise<RequestResponse> {
//		return engine(for: request, progressMonitor: progressMonitor)
//			.then { (engine) -> Promise<RequestResponse> in
//				return engine.post(formData: formData)
//		}
//	}
//
//	public func delete(from request: HttpURLRequestBuilder, progressMonitor: ProgressMonitor? = nil) -> Promise<RequestResponse> {
//		return engine(for: request, progressMonitor: progressMonitor)
//			.then { (engine) -> Promise<RequestResponse> in
//				return engine.delete()
//		}
//	}
//
//}
