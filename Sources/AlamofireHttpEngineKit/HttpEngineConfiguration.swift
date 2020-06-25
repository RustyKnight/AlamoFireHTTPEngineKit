//
//  APIConfiguration.swift
//  SwannOneAPI
//
//  Created by Shane Whitehead on 8/1/19.
//  Copyright © 2019 Shane Whitehead. All rights reserved.
//

import Foundation
import Alamofire
import HttpEngineCore
import Hydra

//// I'm making this public so the baseURL can be configured outside of the API library
//// without needing to expose the APIService itself
//public class HttpEngineConfiguration {
//	public static let shared: HttpEngineConfiguration = HttpEngineConfiguration()
//
//	// The queue to be used by Alamofire to process requests
//	public var httpEngineProcessQueue: DispatchQueue = DispatchQueue.global(qos: .userInitiated)
//	public var httpRequestBuilderFactory: HttpRequestBuilderFactory = AlamofireHttpRequestBuilderFactory()
//
//	// The promise queue used by the engine
//	public lazy var requestQueue = DispatchQueue(label: "AlamorFireHttpEngineKit.requestQueue", qos: .userInitiated)
//	public lazy var requestContext = Context.custom(queue: requestQueue)
//
//	fileprivate init() {
//		let config = URLSessionConfiguration.default
//		config.requestCachePolicy = .reloadIgnoringLocalCacheData
//		config.timeoutIntervalForRequest = 60
//		config.timeoutIntervalForResource = 60
//		//config.httpMaximumConnectionsPerHost = 100
//		
//		_ = Alamofire.SessionManager(configuration: config)
//	}
//	
//	public var isDebugMode: Bool = false
//
//}
