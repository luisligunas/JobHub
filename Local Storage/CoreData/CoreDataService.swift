//
//  CoreDataService.swift
//  Job Hub
//
//  Created by Luis Ligunas on 12/30/20.
//

import Foundation
import CoreData

class CoreDataService {
	
	static let shared = CoreDataService()
	
	private init() {}
	
	private lazy var persistentContainer: NSPersistentContainer = {
		let container = NSPersistentContainer(name: "Job_Hub")
		container.loadPersistentStores { _, _ in }
		return container
	}()
	
	var mainContext: NSManagedObjectContext {
		return persistentContainer.viewContext
	}
	
	func backgroundContext() -> NSManagedObjectContext {
		return persistentContainer.newBackgroundContext()
	}
	
	func fetch(entityType: CoreDataEntityType) -> [NSManagedObject] {
		let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: entityType.rawValue)
		let results = try? mainContext.fetch(fetchRequest)
		return results ?? []
	}
	
	func getEntity(entityType: CoreDataEntityType) -> NSEntityDescription? {
		let entity = NSEntityDescription.entity(forEntityName: entityType.rawValue, in: mainContext)
		return entity
	}
	
	func getNewManagedObject(entityType: CoreDataEntityType) -> NSManagedObject? {
		guard let entity = getEntity(entityType: entityType) else { return nil }
		let managedObject = NSManagedObject(entity: entity, insertInto: mainContext)
		return managedObject
	}
}
