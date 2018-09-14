//
//  DHUtility.swift
//  DAILYHOTEL
//
//  Created by Den Jo on 12/16/15.
//  Copyright © 2015 Den Jo. All rights reserved.
//

import Foundation
import UIKit
import MapKit
import UserNotifications


// MARK: - Util
struct DHUtil {
    
    static func resizeImage(_ image: UIImage, width: CGFloat, height: CGFloat) -> UIImage {
        UIGraphicsBeginImageContext(CGSize(width: width, height: height))
        image.draw(in: CGRect(x: 0, y: 0, width: width, height: height))
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage!
    }
}


// MARK: - Extension
// MARK: UIImage
struct GradientPoint {
    var location: CGFloat
    var color: UIColor
}


extension UIImage {
    
     var grayscale: UIImage? {
        let imageRect  = CGRect(x: 0, y: 0, width: size.width, height: size.height * scale)                     // Create image rectangle with current image width/height
        let colorSpace = CGColorSpaceCreateDeviceGray()
        
        // Create bitmap content with current image size and grayscale colorspace
        guard let context = CGContext(data: nil, width: Int(size.width * scale), height: Int(size.height * scale), bitsPerComponent: 8, bytesPerRow: 0, space: colorSpace, bitmapInfo: 0) else { return nil }
        guard let cgImage = cgImage else { return nil }
        
        context.draw(cgImage, in: imageRect)        // Draw image into current context, with specified rectangle using previously defined context (with grayscale colorspace)
        
        // Create bitmap image info from pixel data in current context
        guard let imageReference = context.makeImage() else { return nil }
        return  UIImage(cgImage: imageReference)
    }

    
    convenience init?(size: CGSize, gradientPoints: [GradientPoint]) {
        UIGraphicsBeginImageContextWithOptions(size, false, UIScreen.main.scale)
        
        guard let context = UIGraphicsGetCurrentContext() else { return nil }       // If the size is zero, the context will be nil.
        guard let gradient = CGGradient(colorSpace: CGColorSpaceCreateDeviceRGB(), colorComponents: gradientPoints.compactMap { $0.color.cgColor.components }.flatMap { $0 }, locations: gradientPoints.map { $0.location }, count: gradientPoints.count) else {
            return nil
        }
        
        context.drawLinearGradient(gradient, start: CGPoint.zero, end: CGPoint(x: 0, y: size.height), options: CGGradientDrawingOptions())
        guard let image = UIGraphicsGetImageFromCurrentImageContext()?.cgImage else { return nil }
        self.init(cgImage: image)
        defer { UIGraphicsEndImageContext() }
    }
    
     func resizedImage(size: CGSize, scale: CGFloat) -> UIImage? {
        let renderer = UIGraphicsImageRenderer(size: CGSize(width: size.width*scale, height: size.height*scale))
        return renderer.image { rendererContext in
            self.draw(in: CGRect(x: 0, y: 0, width: size.width*scale, height: size.height*scale))
        }
    }
    
     func rounded(cornerRadius: CGFloat) -> UIImage? {
        let imageFrame = CGRect(x: 0, y: 0, width: self.size.width, height: self.size.height)
        
        UIGraphicsBeginImageContextWithOptions(self.size, false, 1.0)
        
        // Set bezierPath and cliping
        UIBezierPath(roundedRect: imageFrame, cornerRadius: cornerRadius).addClip()
        self.draw(in: imageFrame)
        
        // Get rounded image
        let image = UIGraphicsGetImageFromCurrentImageContext()
        
        UIGraphicsEndImageContext()
        return image
    }
    
     func crop(to size: CGSize) -> UIImage {
        guard let cgImage = self.cgImage else { return self }
        
        let rect = CGRect(x: (self.size.width - size.width) * self.scale/2.0, y: (self.size.height - size.height) * self.scale/2.0, width: size.width * self.scale, height: size.height * self.scale)
        
        // Create bitmap image from context using the rect
        guard let imageRef = cgImage.cropping(to: rect) else { return self }
        
        // Create a new image based on the imageRef and rotate back to the original orientation
        return UIImage(cgImage: imageRef, scale: self.scale, orientation: self.imageOrientation)
    }

    static func image(_ view: UIView, scale: CGFloat) -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(view.frame.size, false, scale)
        
        // Get context
        guard let context = UIGraphicsGetCurrentContext() else {
            log(.error, "Failed to get context.")
            UIGraphicsEndImageContext()
            return nil
        }
        
        // Get screen shot
        view.layer.render(in: context)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
       
        return image
    }
}


// MARK: UIImageView
extension UIImageView {
    
    @discardableResult
    func gradated(gradientPoints: [GradientPoint]) -> CAGradientLayer {
        let gradientMaskLayer       = CAGradientLayer()
        gradientMaskLayer.frame     = bounds
        gradientMaskLayer.colors    = gradientPoints.map { $0.color.cgColor }
        gradientMaskLayer.locations = gradientPoints.map { $0.location as NSNumber }
        layer.insertSublayer(gradientMaskLayer, at: 0)
        return gradientMaskLayer
    }
}


// MARK: UIColor
extension UIColor {
     func isEqual(color: UIColor?) -> Bool {
        guard let color = color else { return false }
        
        var red:CGFloat   = 0
        var green:CGFloat = 0
        var blue:CGFloat  = 0
        var alpha:CGFloat = 0
        getRed(&red, green: &green, blue: &blue, alpha: &alpha)
        
        var targetRed:CGFloat   = 0
        var targetGreen:CGFloat = 0
        var targetBlue:CGFloat  = 0
        var targetAlpha:CGFloat = 0
        color.getRed(&targetRed, green: &targetGreen, blue: &targetBlue, alpha: &targetAlpha)
        
        return (Int(red*255.0) == Int(targetRed*255.0) && Int(green*255.0) == Int(targetGreen*255.0) && Int(blue*255.0) == Int(targetBlue*255.0) && alpha == targetAlpha)
    }
}



// MARK: MKMap
extension MKMapRect {
    
    func intersects(_ rect2: MKMapRect) -> Bool {
        return CGRect(x: origin.x, y: origin.y, width: size.width, height: size.height).intersects(CGRect(x: rect2.origin.x, y: rect2.origin.y, width: rect2.size.width, height: rect2.size.height))
    }
}

extension MKMapSize {
    
    func equalTo(_ size2: MKMapSize) -> Bool {
        return CGSize(width: width, height: height).equalTo(CGSize(width: size2.width, height: size2.height))
    }
}


// MARK: - Segue
public protocol SegueHandlerType {
    associatedtype SegueIdentifier: RawRepresentable
}

extension SegueHandlerType where Self: UIViewController, SegueIdentifier.RawValue == String {
    /**
     An overload of `UIViewController`'s `performSegueWithIdentifier(_:sender:)`
     method that takes in a `SegueIdentifier` enum parameter rather than a `String`.
     */
    public func performSegue(with segueIdentifier: SegueIdentifier, sender: Any?) {
        performSegue(withIdentifier: segueIdentifier.rawValue, sender: sender)
    }
    
    /**
     A convenience method to map a `StoryboardSegue` to the  segue identifier
     enum that it represents.
     */
    
    public func segueIdentifier(with segue: UIStoryboardSegue) -> SegueIdentifier? {
        guard let identifier = segue.identifier, let segueIdentifier = SegueIdentifier(rawValue: identifier) else {
            debugPrint("Couldn't handle segue identifier \(String(describing: segue.identifier)) for view controller of type \(type(of: self)).")
            return nil
        }
        return segueIdentifier
    }
}

