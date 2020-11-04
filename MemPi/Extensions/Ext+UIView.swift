//
//  Ext+UIView.swift
//  MemPi
//
//  Created by Batuhan Karababa on 1.11.2020.
//

import Foundation
import UIKit

struct AnchorConstraints{
    var leading:NSLayoutConstraint?
    var trailing:NSLayoutConstraint?
    var top:NSLayoutConstraint?
    var bottom:NSLayoutConstraint?
    var width:NSLayoutConstraint?
    var height:NSLayoutConstraint?
    
    
}
extension UIView{
    
    func setCenter(size:CGSize?){
        guard let superview = superview else {return}
        translatesAutoresizingMaskIntoConstraints = false
        self.centerXAnchor.constraint(equalTo: superview.centerXAnchor).isActive = true
        self.centerYAnchor.constraint(equalTo: superview.centerYAnchor).isActive = true
        if let size = size{
            self.heightAnchor.constraint(equalToConstant: size.height).isActive = true
            self.widthAnchor.constraint(equalToConstant: size.width).isActive = true
        }
    }
    
    func setCenterX(anchor:NSLayoutXAxisAnchor){
        translatesAutoresizingMaskIntoConstraints = false
        centerXAnchor.constraint(equalTo: anchor).isActive = true
    }
    
    func setCenterY(anchor:NSLayoutYAxisAnchor){
        translatesAutoresizingMaskIntoConstraints = false
        centerYAnchor.constraint(equalTo: anchor).isActive = true
    }
    
    func setDimension(size:CGSize){
        translatesAutoresizingMaskIntoConstraints = false
        self.heightAnchor.constraint(equalToConstant: size.height).isActive = true
        self.widthAnchor.constraint(equalToConstant: size.width).isActive = true
    }
    
    func setWidth(number:CGFloat){
        translatesAutoresizingMaskIntoConstraints = false
        self.widthAnchor.constraint(equalToConstant: number).isActive = true
    }
    
    func setHeight(number:CGFloat){
        translatesAutoresizingMaskIntoConstraints = false
        self.heightAnchor.constraint(equalToConstant: number).isActive = true
    }
    
    func makeRound(number:CGFloat){
        translatesAutoresizingMaskIntoConstraints = false
        setDimension(size: .init(width: number, height: number))
        layer.cornerRadius = number/2
    }
    
    func fillSuperView(padding:UIEdgeInsets = .zero){
        if let superView = superview{
            self.topAnchor.constraint(equalTo: superView.topAnchor,constant: padding.top).isActive = true
            self.bottomAnchor.constraint(equalTo: superView.bottomAnchor,constant: padding.bottom).isActive = true
            self.leadingAnchor.constraint(equalTo: superView.leadingAnchor,constant: padding.left).isActive = true
            self.trailingAnchor.constraint(equalTo: superView.trailingAnchor,constant: padding.right).isActive = true
        }
    }
    
    @discardableResult
    func anchor(top:NSLayoutYAxisAnchor?,leading:NSLayoutXAxisAnchor?,bottom:NSLayoutYAxisAnchor?,trailing:NSLayoutXAxisAnchor?,padding:UIEdgeInsets = .zero, size: CGSize = .zero) -> AnchorConstraints{
        
        translatesAutoresizingMaskIntoConstraints = false
        
        var ac = AnchorConstraints()
        
        if let top = top{
            ac.top =  self.topAnchor.constraint(equalTo: top,constant: padding.top)
        }
        
        if let leading = leading{
            ac.leading =  self.leadingAnchor.constraint(equalTo: leading,constant: padding.left)
        }
        
        if let bottom = bottom{
            ac.bottom =  self.bottomAnchor.constraint(equalTo: bottom,constant: -padding.bottom)
        }
        
        if let trailing = trailing{
            ac.trailing =  self.trailingAnchor.constraint(equalTo: trailing,constant: -padding.right)
        }
        
        if size.width != 0{
            ac.width =  self.widthAnchor.constraint(equalToConstant: size.width)
        }
        
        if size.height != 0{
            ac.height =  self.heightAnchor.constraint(equalToConstant: size.height)
        }
        
        [ac.top,ac.leading,ac.bottom,ac.trailing,ac.height,ac.width].forEach({$0?.isActive = true})
        
        return ac
    }
}
