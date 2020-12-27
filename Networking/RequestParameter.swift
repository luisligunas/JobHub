//
//  RequestParameter.swift
//  Job Hub
//
//  Created by Luis Ligunas on 12/27/20.
//

import Foundation

protocol RequestParameter {
	var urlParameters: [String: Any] { get }
	var bodyParameters: [String: Any] { get }
}

extension RequestParameter {
	var urlParameters: [String: Any] {
		return [String: Any]()
	}
	var bodyParameters: [String: Any] {
		return [String: String]()
	}
}
