//
//  URLBuilder.swift
//  AlamoFireHTTPEngineKit
//
//  Created by Shane Whitehead on 16/11/19.
//  Copyright © 2019 Shane Whitehead. All rights reserved.
//

import Foundation
import HttpEngineCore
//
//// This just provides a point of customisation
//
//public protocol HttpURLRequestBuilder {
//	//var header: [String: String] { get }
//	func build() -> HttpRequestBuilder
//}
//
//open class DefaultHttpURLBuilder: HttpURLRequestBuilder {
//  
//  private var url: URL!
//	private var header: [String: String] = [:]
//	private var parameters: [String: String] = [:]
//	private var queryItems: [URLQueryItem] = []
//
//	public init() { }
//  
//	@discardableResult
//  public func with(url: URL) -> Self {
//    self.url = url
//    return self
//  }
//	
//	@discardableResult
//	public func withHeader(key: String, value: String) -> Self {
//		header[key] = value
//		return self
//	}
//	
//	@discardableResult
//	public func withParemter(named: String, value: String) -> Self {
//		parameters[named] = value
//		return self
//	}
//	
//	@discardableResult
//	public func with(queryNamed name: String, value: String) -> Self {
//		queryItems.append(URLQueryItem(name: name,
//																	 value: value.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)))
//		return self
//	}
//	
//  public func build() -> HttpRequestBuilder {
//		
//		var components = URLComponents(url: url, resolvingAgainstBaseURL: false)!
//		if !queryItems.isEmpty {
//			components.queryItems = queryItems
//		}
//		
//		let requestBuilder = HttpEngineConfiguration.shared.httpRequestBuilderFactory
//			.request(to: components.url!)
//			.with(headers: header)
//			.with(parameters: parameters)
//		
//		return requestBuilder
//  }
//}
