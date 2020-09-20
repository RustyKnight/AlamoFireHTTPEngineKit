//
//  Promise+Dispatch.swift
//  iOS
//
//  Created by Shane Whitehead on 20/9/20.
//  Copyright © 2020 Shane Whitehead. All rights reserved.
//

import Foundation
import PromiseKit

func firstly<U>(on dispatch: DispatchQueue, execute body: (_ resolver: Resolver<U>) -> Void) -> Promise<U> {
	return Promise<U> { seal in
		body(seal)
	}
}
