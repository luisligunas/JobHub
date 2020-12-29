//
//  UIImage+Extensions.swift
//  Job Hub
//
//  Created by Luis Ligunas on 12/29/20.
//

import Foundation
import UIKit

public extension UIImage {
	static func download(from url: URL, completion: @escaping (_ image: UIImage?) -> Void) {
		URLSession.shared.dataTask(with: url) { data, response, error in
			guard
				let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
				let mimeType = response?.mimeType,
				mimeType.hasPrefix("image"),
				let data = data, error == nil,
				let image = UIImage(data: data)
			else {
				completion(nil)
				return
			}
			completion(image)
		}.resume()
	}
	
	static func download(from link: String, completion: @escaping (_ image: UIImage?) -> Void) {
		guard let url = URL(string: link) else { return }
		download(from: url, completion: completion)
	}
}
