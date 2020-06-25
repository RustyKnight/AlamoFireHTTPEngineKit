//
//  MultipartFormItem.swift
//  iOS
//
//  Created by Shane Whitehead on 1/12/19.
//  Copyright © 2019 Shane Whitehead. All rights reserved.
//

import Foundation
import Alamofire
import HttpEngineCore
import Cadmus

extension MultipartFormData {

	func append(_ item: MultipartFormItem) {
		switch item {
		case .data(let data, let name, let mimeType, let fileName):
			if let fileName = fileName, let mimeType = mimeType {
				append(data, withName: name, fileName: fileName, mimeType: mimeType)
			} else if let mimeType = mimeType {
				append(data, withName: name, mimeType: mimeType)
			} else {
				append(data, withName: name)
			}
		case .file(let url, let name, let mimeType, let fileName):
			log(debug: """

				\tAppend file:
				\t\t\(url)
				\t\t\(name)
				""")
			if let fileName = fileName, let mimeType = mimeType {
				append(url, withName: name, fileName: fileName, mimeType: mimeType)
			} else {
				append(url, withName: name)
			}
		}
	}
}

//public class MultipartFormItem {
//	let name: String
//	let mimeType: String?
//
//	init(name: String, mimeType: String? = nil) {
//		self.name = name
//		self.mimeType = mimeType
//	}
//}
//
//public class DataMultipartFormItem: MultipartFormItem {
//	let data: Data
//	let fileName: String?
//
//	init(name: String, mimeType: String? = nil, data: Data, fileName: String? = nil) {
//		self.data = data
//		self.fileName = fileName
//		super.init(name: name, mimeType: mimeType)
//	}
//}
//
//public class URLMultipartFormItem: MultipartFormItem {
//	let url: URL
//	let fileName: String?
//
//	init(name: String, mimeType: String? = nil, url: URL, fileName: String? = nil) {
//		self.url = url
//		self.fileName = fileName
//		super.init(name: name, mimeType: mimeType)
//	}
//}
//
//extension MultipartFormData {
//
//	func append(_ item: MultipartFormItem) {
//
//	}
//
//	func append(_ item: DataMultipartFormItem) {
//		if let fileName = item.fileName, let mimeType = item.mimeType {
//			append(item.data, withName: item.name, fileName: fileName, mimeType: mimeType)
//		} else if let mimeType = item.mimeType {
//			append(item.data, withName: item.name, mimeType: mimeType)
//		} else {
//			append(item.data, withName: item.name)
//		}
//	}
//
//	func append(_ item: URLMultipartFormItem) {
//		if let fileName = item.fileName, let mimeType = item.mimeType {
//			append(item.url, withName: item.name, fileName: fileName, mimeType: mimeType)
//		} else {
//			append(item.url, withName: item.name)
//		}
//	}
//
//}
