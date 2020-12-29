//
//  Theme.swift
//  Job Hub
//
//  Created by Luis Ligunas on 12/27/20.
//

import Foundation
import UIKit

protocol Theme {
	var backgroundColor: UIColor { get }
	var tintColor: UIColor { get }
	
	var textColorTheme: TextColorTheme { get }
	var textFontTheme: TextFontTheme { get }
	
	var navigationBarTintColor: UIColor { get }
	var navigationBarTitleTextAttributes: [NSAttributedString.Key : Any] { get }
	
	var barButtonItemTintColor: UIColor { get }
	
	var preferredStatusBarStyle: UIStatusBarStyle { get }
	var activityIndicatorViewStyle: UIActivityIndicatorView.Style { get }
}

extension Theme {
	var backgroundColor: UIColor { .primaryColor }
	var tintColor: UIColor { .white }
	
	var textColorTheme: TextColorTheme { DefaultTextColorTheme() }
	var textFontTheme: TextFontTheme { DefaultTextFontTheme() }
	
	var navigationBarTintColor: UIColor { .primaryColor }
	var navigationBarTitleTextAttributes: [NSAttributedString.Key : Any] { [.foregroundColor: UIColor.tertiaryColor] }
	
	var barButtonItemTintColor: UIColor { .tertiaryColor }
	
	var preferredStatusBarStyle: UIStatusBarStyle { .lightContent }
	var activityIndicatorViewStyle: UIActivityIndicatorView.Style { .white }
}

struct DefaultTheme: Theme {}
