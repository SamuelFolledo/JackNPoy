//
//  UIImageView+extension.swift
//  HawkHackProject2019S
//
//  Created by Samuel Folledo on 3/30/19.
//  Copyright © 2019 Samuel Folledo. All rights reserved.
//

import UIKit
import FirebaseStorage

extension UIImageView {
	func downloaded(fromURL url: URL, contentMode mode: UIView.ContentMode = .scaleAspectFit) {  // for swift 4.2 syntax just use ===> mode: UIView.ContentMode
        
        let storageRef = Storage.storage().
        storageRef.downloadURL(completion: { (url, error) in
            let data = Data(contentsOf: url!)
            let image = UIImage(data: data! as Data)
            self.image = image
        })
        
        
		contentMode = mode
//		URLSession.shared.dataTask(with: url) { data, response, error in
//			guard
//				let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
//				let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
//				let data = data, error == nil,
//				let image = UIImage(data: data)
//				else { return }
//			DispatchQueue.main.async() {
//				self.image = image
//			}
//			}.resume()
	}
	func downloaded(fromLink link: String, contentMode mode: UIView.ContentMode = .scaleAspectFit) {  // for swift 4.2 syntax just use ===> mode: UIView.ContentMode
		guard let url = URL(string: link) else { return }
		downloaded(fromURL: url, contentMode: mode)
	}
}
