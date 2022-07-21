//
//  AvoidKeyboardOverlapping.swift
//  GitHubFollowers
//
//  Created by JC on 20/7/22.
//

import Foundation

protocol NonoverlappingKeyboard {
    func createDismissKeyboardTapGesture()
    func addKeyboardObservers()
    /*@objc*/ func keyboardWillShow(notification: NSNotification)
    func keyboardWillHide(notification: NSNotification)
}
