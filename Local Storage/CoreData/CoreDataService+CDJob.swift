//
//  CoreDataService+CDJob.swift
//  Job Hub
//
//  Created by Luis Ligunas on 12/30/20.
//

import Foundation

extension CoreDataService {
	func fetchJobs() -> [Job] {
		let results = fetch(entityType: .job)
		return results.compactMap { object in
			guard let job = object as? CDJob else { return nil }
			return Job(id: job.id ?? "",
					   jobType: JobType(rawValue: job.jobType ?? "") ?? .fullTime,
					   url: job.url ?? "",
					   createdAt: job.createdAt ?? .init(),
					   company: job.company ?? "",
					   companyURL: job.companyURL,
					   location: job.location ?? "",
					   title: job.title ?? "",
					   description: job.jobDescription ?? "",
					   howToApply: job.howToApply ?? "",
					   companyLogo: job.companyLogo)
		}
	}
	
	func saveJobs(_ jobs: [Job]) {
		let savedJobs = fetchJobs()
		
		jobs.forEach { job in
			guard !savedJobs.contains(where: { $0.id == job.id }) else { return }
			
			let managedObject = getNewManagedObject(entityType: .job)
			managedObject?.setValue(job.company, forKey: "company")
			managedObject?.setValue(job.companyLogo, forKey: "companyLogo")
			managedObject?.setValue(job.companyURL, forKey: "companyURL")
			managedObject?.setValue(job.createdAt, forKey: "createdAt")
			managedObject?.setValue(job.howToApply, forKey: "howToApply")
			managedObject?.setValue(job.id, forKey: "id")
			managedObject?.setValue(job.description, forKey: "jobDescription")
			managedObject?.setValue(job.jobType.rawValue, forKey: "jobType")
			managedObject?.setValue(job.location, forKey: "location")
			managedObject?.setValue(job.title, forKey: "title")
			managedObject?.setValue(job.url, forKey: "url")
			
			try? mainContext.save()
		}
	}
}
