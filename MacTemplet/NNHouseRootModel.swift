//
//  NNHouseRootModel.swift
//  MacTemplet
//
//  Created by Bin Shang on 2020/1/11.
//  Copyright © 2020 Bin Shang. All rights reserved.
//

import Cocoa

@objcMembers class NNHouseRootModel: NSObject {

    var object: NNHouseObjectModel?

    var status: String = ""

//    required override init() {}
    
    static func modelContainerPropertyGenericClass() -> [String : Any]? {
        return ["object": NNHouseObjectModel.classForCoder()]
    }
    
    override var description: String {
        return yy_modelDescription()
    }
}

@objcMembers class NNHouseObjectModel: NSObject {
    var blocks: [NNBlocksModel]?

    var buildings: [NNBuildingsModel]?

    var floors: [NNFloorsModel]?

//    required override init() {}
    
    static func modelContainerPropertyGenericClass() -> [String : Any]? {
      return ["blocks"      : NNBlocksModel.classForCoder(),
              "buildings"   : NNBuildingsModel.classForCoder(),
              "floors"      : NNFloorsModel.classForCoder(),
        ]
    }
    
    override var description: String {
        return yy_modelDescription()
    }
}

@objcMembers class NNHouseBlocksModel: NSObject {
    
    var desc: String = ""

    var disabled: Bool = false

    var ID: Int = 0

    var level: Int = 0

    var name: String = ""

    var value: Int = 0

//    required override init() {}

    static func modelCustomPropertyMapper() -> [String : Any]? {
        return ["desc"  :   "description"
        ]
    }
    
    override var description: String {
        return yy_modelDescription()
    }
}

@objcMembers class NNHouseBuildingsModel: NSObject {
    var disabled: Bool = false

    var ID: Int = 0

    var level: Int = 0

    var name: String = ""

    var value: Int = 0

//    required override init() {}
    
    override var description: String {
        return yy_modelDescription()
    }
}

@objcMembers class NNHouseFloorsModel: NSObject {
    var disabled: Bool = false

    var ID: Int = 0

    var level: Int = 0

    var name: String = ""

    var value: Int = 0

//    required override init() {}
    
    override var description: String {
        return yy_modelDescription()
    }
}
