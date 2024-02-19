//
//  Extensions+UIView.swift
//  AI Image
//
//  Created by Kerem Demir on 19.02.2024.
//

import Foundation
import UIKit

extension UIView {
    func addSubViews(_ views: UIView...){
        views.forEach({
            addSubview($0)
        })
    }
}
