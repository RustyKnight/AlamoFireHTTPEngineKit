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

open class AlamofireHttpRequestBuilder: BaseHttpRequestBuilder {

	override open func build() throws -> HttpEngine {
    var components = URLComponents(url: url, resolvingAgainstBaseURL: false)!
    if !queryItems.isEmpty {
      components.queryItems = queryItems
    }

    
		return AlamofireHttpEngine(url: url,
															 //parameters: par,
															 headers: headers,
															 credentials: credentials,
															 timeout: timeout,
															 progressMonitor: progressMonitor)
	}
}
