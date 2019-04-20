//
//  FetchRequest.swift
//  dopravaBrno
//
//  Created by Thành Đỗ Long on 20/03/2019.
//  Copyright © 2019 Thành Đỗ Long. All rights reserved.
//

import Foundation

import Foundation
import RealmSwift

struct FetchRequest<Model, RealmObject: Object> {
    let predicate: NSPredicate?
    let sortDescriptors: [SortDescriptor]
    let transformer: (Results<RealmObject>) -> Model
}

extension VendingMachine {
    static let all = FetchRequest<[VendingMachine],VendingMachineObject>(predicate: nil, sortDescriptors: [], transformer: {$0.map(VendingMachine.init)})
}

extension Vehicle {
    static let all = FetchRequest<[Vehicle], VehicleObject>(predicate: nil, sortDescriptors: [], transformer: { $0.map(Vehicle.init) })
}

extension Stop {
    static let all = FetchRequest<[Stop], StopObject>(predicate: nil, sortDescriptors: [], transformer: { $0.map(Stop.init) })
}