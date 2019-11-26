//
//  MapViewController.swift
//  MacTemplet
//
//  Created by Bin Shang on 2019/11/26.
//  Copyright © 2019 Bin Shang. All rights reserved.
//

import Cocoa
import MapKit
import CoreLocation
import SnapKit
import SnapKitExtend

@available(OSX 10.14, *)
class MapViewController: NSViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
                
        view.addSubview(leftView)
        view.addSubview(mapView)
        mapView.zoomLevel = 15

        
//        view.getViewLayer()
    }
    
    override func viewDidLayout() {
        super.viewDidLayout()
                                
//        let list = [leftView, mapView]
//        list.snp.distributeViewsAlong(axisType: .horizontal, fixedSpacing: 5, leadSpacing: 0, tailSpacing: 0)
//        list.snp.makeConstraints { (make) in
//            make.top.equalToSuperview().offset(0);
//            make.bottom.equalToSuperview().offset(0);
//        }
        
        leftView.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(0);
            make.left.equalToSuperview().offset(0);
            make.bottom.equalToSuperview().offset(0);
            make.width.equalToSuperview().multipliedBy(0.2);
        }
        
        searchField.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(10);
            make.left.equalToSuperview().offset(10);
            make.right.equalToSuperview().offset(-10);
            make.height.equalTo(30);
        }
        
        let height = titles.count * 20 + (titles.count - 1) * 5
        stackViewSwitchs.snp.makeConstraints { (make) in
            make.top.equalTo(stackViewTitles);
            make.right.equalToSuperview().offset(-10);
            make.width.equalTo(50);
            make.height.equalTo(height);
         }
        
        stackViewTitles.snp.makeConstraints { (make) in
            make.top.equalTo(searchField.snp.bottom).offset(10);
            make.left.equalToSuperview().offset(10);
            make.right.equalTo(stackViewSwitchs.snp.left);
            make.height.equalTo(height);
         }
        
        segmentCtl.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(10);
            make.right.equalToSuperview().offset(-10);
            make.bottom.equalToSuperview().offset(-10);
            make.height.equalTo(30);
        }
        
        mapView.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(0);
            make.left.equalTo(leftView.snp.right).offset(0);
            make.right.equalToSuperview().offset(-10);
            make.bottom.equalToSuperview().offset(0);
        }
        
        if stackViewTitles.subviews.count > 0 {
            return;
        }
        
        for e in titles.enumerated() {
            let label: NSTextField = {
                let view = NSTextField(frame: .zero)
                view.isBordered = false;  ///是否显示边框
                view.wantsLayer = true;
                view.isEditable = false;
                view.drawsBackground = true;
                view.backgroundColor = NSColor.clear

                view.tag = e.offset

                return view;
            }()
            label.stringValue = e.element;
            stackViewTitles.addArrangedSubview(label)

            let switchCtl: NNSwitch = {
                let view = NNSwitch(frame: CGRectMake(0, 0, 50, 20))
                view.tag = e.offset
                view.addTarget(self, action: #selector(toggleSwitch(_:)))
                return view;
            }()
            switchCtl.setOn(on: true, animated: true)
            stackViewSwitchs.addArrangedSubview(switchCtl)
        }
    }
    
    @objc func searchFieldChanged(_ sender: NSSearchField) {
        let query = sender.stringValue
        mapView.search(query) { (response, error) in
            guard let coordinate = response?.mapItems.first?.placemark.coordinate else { return }
            self.mapView.updateRegion(center: coordinate)
        }
    }
    
    @objc func toggleSwitch(_ sender: NNSwitch) {
        DDLog(sender.tag)
        switch sender.tag {
        case 0:
            mapView.showsCompass = sender.on
            
        case 1:
            mapView.showsBuildings = sender.on
            
        case 2:
            mapView.showsPointsOfInterest = sender.on
            
        case 3:
            mapView.showsTraffic = sender.on
            
        case 4:
            mapView.showsZoomControls = sender.on
            
        case 5:
            mapView.showsScale = sender.on
                
        default:
            break;
        }
    }
    // MARK: - lazy
    lazy var titles = ["Compass", "Buildings", "PointsOfInterest", "Traffic", "ZoomControls", "ScaleControls"]
    lazy var leftView: NSVisualEffectView = {
        let view = NSVisualEffectView.create()
        
        view.addSubview(searchField);
        view.addSubview(stackViewTitles);
        view.addSubview(stackViewSwitchs);
        view.addSubview(segmentCtl)
        return view
    }()
    
    lazy var searchField: NSSearchField = {
        let view = NSSearchField(frame: .zero)
        view.searchMenuTemplate = NSSearchField.createRecentMenu()
        view.placeholderString = "地址/城市"
        view.addTarget(self, action: #selector(searchFieldChanged(_:)))
        return view
    }()
    
    lazy var stackViewTitles: NSStackView = {
        //创建StackView
        let stackView = NSStackView(frame: .zero)
        //设置子视图间隔
        stackView.spacing = 5
        //子视图的高度或宽度保持一致
        stackView.distribution = .fillEqually
        stackView.orientation = .vertical
        stackView.alignment = .left

        return stackView;
    }()

    lazy var stackViewSwitchs: NSStackView = {
        //创建StackView
        let stackView = NSStackView(frame: .zero)
        //设置子视图间隔
        stackView.spacing = 5
        //子视图的高度或宽度保持一致
        stackView.distribution = .fillEqually
        stackView.orientation = .vertical
        stackView.alignment = .right

        return stackView;
    }()
    
    lazy var segmentCtl: NSSegmentedControl = {
        let view = NSSegmentedControl(frame: .zero)
        view.items = ["标准视图", "卫星视图"];
        view.addActionHandler({ (control) in
            guard let sender = control as? NSSegmentedControl else { return }
//            DDLog(sender.selectedSegment);
            self.mapView.mapType = sender.selectedSegment == 0 ? .standard : .hybrid;

        }, trackingMode: .selectOne)
   
        return view
    }()
    
    lazy var mapView: MKMapView = {
        let mapView = MKMapView(frame: view.bounds)
        mapView.showsCompass = true
        mapView.showsBuildings = true
        mapView.showsPointsOfInterest = true
        mapView.showsTraffic = true
        mapView.showsZoomControls = true;
        
        mapView.showsUserLocation = true;
        mapView.showsScale = true;
        mapView.delegate = self;
                
        return mapView
    }()
    
}

@available(OSX 10.14, *)
extension MapViewController: MKMapViewDelegate {
    
    func mapView(_ mapView: MKMapView, didUpdate userLocation: MKUserLocation) {
        print(userLocation.coordinate)
        mapView.centerCoordinate = userLocation.coordinate

    }
    
    func mapView(_ mapView: MKMapView, didFailToLocateUserWithError error: Error) {
        print(error.localizedDescription)

    }
    
}
