//
//  AlamofireHttpRequestBuilder.swift
//  ShoutOutAPI
//
//  Created by Shane Whitehead on 11/10/18.
//  Copyright © 2018 KaiZen. All rights reserved.
//

import Foundation
import HttpEngineCore
import Alamofire
import Cadmus
//
//class AlamofireHttpRequestBuilderFactory: HttpRequestBuilderFactory {
//	func request(to: URL) -> HttpRequestBuilder {
//		return AlamofireHttpRequestBuilder(to: to)
//	}
//}

open class AlamofireHttpRequestBuilder: BaseHttpRequestBuilder {

	override open func build() throws -> HttpEngine {
		return AlamofireHttpEngine(url: url,
															 parameters: parameters,
															 headers: headers,
															 credentials: credentials,
															 timeout: timeout,
															 progressMonitor: progressMonitor)
	}
}
