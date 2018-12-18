//
//  Khala
//
//  Copyright (c) 2018 linhay - https://github.com/linhay
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in all
//  copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE

#if canImport(AppKit)
public typealias KhalaViewController = NSViewController
public typealias KhalaView = NSView
#endif

#if canImport(UIKit)
public typealias KhalaViewController = UIViewController
public typealias KhalaView = UIView
#endif


/// 路由类协议
@objc
public protocol KhalaProtocol: NSObjectProtocol { }


// MARK: - 辅助函数
public extension Khala {
  
  /// 全量注册 KhalaProtocol 路由类
  public static func registWithKhalaProtocol() {
    let typeCount = Int(objc_getClassList(nil, 0))
    let types = UnsafeMutablePointer<AnyClass?>.allocate(capacity: typeCount)
    let autoreleasingTypes = AutoreleasingUnsafeMutablePointer<AnyClass>(types)
    objc_getClassList(autoreleasingTypes, Int32(typeCount))
    for index in 0..<typeCount {
      if class_conformsToProtocol(types[index], KhalaProtocol.self) {
        let name = String(cString: class_getName(types[index]))
        _ = PseudoClass(name: name)
      }
    }
    types.deinitialize(count: typeCount)
    types.deallocate()
  }
  
}

// MARK: - 快捷函数
public extension Khala {
  
  
  /// 获取 viewController
  ///
  /// - Returns: viewController
  @objc var viewController: KhalaViewController? {
    return call() as? KhalaViewController
  }
  
  /// 获取 view
  ///
  /// - Returns: view
  @objc var view: KhalaView? {
    return call() as? KhalaView
  }
  
}
