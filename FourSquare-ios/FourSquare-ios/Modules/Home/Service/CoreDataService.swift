//
//  CoreDataService.swift
//  FourSquare-ios
//
//  Created by mohammadSaadat on 5/30/1399 AP.
//  Copyright © 1399 mohammad. All rights reserved.
//

import Foundation
import CoreData

protocol CoreDataServiceDelegate: class {
    func fetchedDataAfterSaved(places: [Venue])
}

class CoreDataService {
    // MARK: - Object lifecycle
    init(context: NSManagedObjectContext) {
        self.context = context
        debugPrint("LifeCycle ->" + String(describing: CoreDataService.self) + "init")
        NotificationCenter.default.addObserver(self, selector: #selector(managedObjectContextDidSave), name: NSNotification.Name.NSManagedObjectContextDidSave, object: nil)

    }
    
    // MARK: - Deinit
    deinit {
        debugPrint("LifeCycle ->" + String(describing: CoreDataService.self) + "deinit")
    }
    
    // MARK: - Properties
    weak private var delegate: CoreDataServiceDelegate?
    
    // MARK: Private
    private let context: NSManagedObjectContext
}

// MARK: Public
extension CoreDataService {
    func save(with venueRemotes: [VenueRemote]) throws {
        self.configure(with: venueRemotes)
        if context.hasChanges {
            try context.save()
        }
    }
    
    func deleteAllRecords() throws {
        let deleteFetch: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest<NSFetchRequestResult>(entityName: "Venue")
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: deleteFetch)
        try context.execute(deleteRequest)
    }
    
    func fetchAllData() throws -> [Venue] {
        let fetchRequest: NSFetchRequest<Venue> = Venue.fetchRequest()
        return try context.fetch(fetchRequest)
    }
    
    func setDelegate(with delegate: CoreDataServiceDelegate) {
        self.delegate = delegate
    }
}

private extension CoreDataService {
    func configure(with venueRemotes: [VenueRemote]) {
        for venueRemote in venueRemotes {
            let place = Venue(context: self.context)
            place.name = venueRemote.name
            place.id = venueRemote.id
            place.address = venueRemote.address
            let category = venueRemote.categories?.first
            place.categoryName = category?.name
            place.categoryURL = category?.icon?.resourceString
        }
    }
    
    @objc func managedObjectContextDidSave()  {
        debugPrint("managedObjectContextDidSave")
        let fetchRequest: NSFetchRequest<Venue> = Venue.fetchRequest()
        if let places = try? context.fetch(fetchRequest) {
            delegate?.fetchedDataAfterSaved(places: places)
        }
    }
}
