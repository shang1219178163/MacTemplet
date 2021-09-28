//
//  MKMapView+Helper.swift
//  NSSwitchDemo
//
//  Created by Bin Shang on 2019/11/25.
//  Copyright © 2019 Hayden Pennington. All rights reserved.
//

import Cocoa
import MapKit

@objc extension MKMapView {
    /// 缩放级别
    public var zoomLevel: Int {
        //获取缩放级别
        get {
            return Int(log2(360 * (Double(self.frame.size.width/256)
                / self.region.span.longitudeDelta)) + 1)
        }
        //设置缩放级别
        set (newZoomLevel){
            setCenterCoordinate(coordinate: self.centerCoordinate, zoomLevel: newZoomLevel,
                                animated: false)
        }
    }
     
    /// 设置缩放级别时调用
    private func setCenterCoordinate(coordinate: CLLocationCoordinate2D, zoomLevel: Int, animated: Bool){
        let span = MKCoordinateSpan(latitudeDelta: 0,
                                    longitudeDelta: 360 / pow(2, Double(zoomLevel)) * Double(self.frame.size.width) / 256)
        setRegion(MKCoordinateRegion(center: centerCoordinate, span: span), animated: animated)
    }
    
    /// 搜索地址名称
    public func search(_ naturalLanguageQuery: String, completionHandler: @escaping MKLocalSearch.CompletionHandler) {
        let request = MKLocalSearch.Request()
        request.naturalLanguageQuery = naturalLanguageQuery
        request.region = self.region
        let search = MKLocalSearch(request: request)
        search.start(completionHandler: completionHandler)
    }
    
    /// 根据经纬度调整地图显示区域
    public func updateRegion(center: CLLocationCoordinate2D, latDelta: CLLocationDegrees = 0.1, lonDelta: CLLocationDegrees = 0.1) {
        let span = MKCoordinateSpan(latitudeDelta: latDelta, longitudeDelta: lonDelta)//以某个点为中心的显示范围
        let region = MKCoordinateRegion(center: center, span: span)
        setRegion(region, animated: true)
    }
}

public extension MKMapView {

    /// 泛型复用cell - cellType: "类名.self" (默认identifier: 类名字符串)
    final func dequeueReusableAnnoView<T: MKAnnotationView>(for type: T.Type, annotation: MKAnnotation?, identifier: String) -> T{
        if let view = self.dequeueReusableAnnotationView(withIdentifier: identifier) as? T{
            return view
        }
        let view = T.init(annotation: annotation, reuseIdentifier: identifier)
        return view
    }
}

/// 大头针
public extension MKAnnotationView{
    static func dequeueReusableAnnoView(_ mapView: MKMapView, annotation: MKAnnotation?, identifier: String) -> MKAnnotationView{
        if let annoView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier){
            return annoView
        }
        let annoView = self.init(annotation: annotation, reuseIdentifier: identifier)
        annoView.canShowCallout = true
        return annoView
    }
}
