//
//  Model.swift
//  catalogo
//
//  Created by Francisco on 28/12/14.
//  Copyright (c) 2014 Cuatroo. All rights reserved.
//

import UIKit
import CoreData

@objc(Model)

class Model: NSManagedObject {

    //properties must match entity atributes
    @NSManaged var item: String
    @NSManaged var quantity: String
    @NSManaged var details: String
}
