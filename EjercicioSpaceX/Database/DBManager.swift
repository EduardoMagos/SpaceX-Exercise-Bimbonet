//
//  DBManager.swift
//  EjercicioSpaceX
//
//  Created by Luis Eduardo Magos Moreno on 23/08/23.
//

import Foundation
import SQLite

class DBManager {
	
	var database: Connection!
	let launchesTable = Table("launches")
	let id = Expression<Int>("id")
	let flight_number = Expression<Int>("flight_number")
	let mission_name = Expression<String>("mission_name")
	let launch_date_utc = Expression<String>("launch_date_utc")
	let launch_date_local = Expression<String>("launch_date_local")
	let details = Expression<String>("details")
	let rocket_id = Expression<String>("rocket_id")
	let rocket_name = Expression<String>("rocket_name")
	let rocket_type = Expression<String>("rocket_type")
	let site_id = Expression<String>("site_id")
	let site_name = Expression<String>("site_name")
	let site_name_long = Expression<String>("site_name_long")
	let mission_patch = Expression<String>("mission_patch")
	let mission_patch_small = Expression<String>("mission_patch_small")
	let presskit = Expression<String>("presskit")
	let article_link = Expression<String>("article_link")
	let wikipedia = Expression<String>("wikipedia")
	let video_link = Expression<String>("video_link")
	let youtube_id = Expression<String>("youtube_id")
	let flickr_images = Expression<String>("flickr_images")
	
	func createLocation() {
		
		do {
			
			let documentDirectory = try FileManager.default.url(
				for: .documentDirectory,
				in: .userDomainMask,
				appropriateFor: nil,
				create: true)
			
			let fileURL = documentDirectory.appendingPathComponent("launches").appendingPathExtension("sqlite3")
			UserDefaults.standard.set(fileURL, forKey: "databaseURL")
			let database = try Connection(fileURL.path)
			print("Debug | Base de datos creada")
			self.database = database
			self.createTable()
			
		} catch  {
			print(error)
		}
		
	}
	
	func createTable() {
		
		let createTable = self.launchesTable.create { (table) in
			table.column(self.id, primaryKey: true)
			table.column(self.flight_number)
			table.column(self.mission_name)
			table.column(self.launch_date_utc)
			table.column(self.launch_date_local)
			table.column(self.details)
			table.column(self.rocket_id)
			table.column(self.rocket_name)
			table.column(self.rocket_type)
			table.column(self.site_id)
			table.column(self.site_name)
			table.column(self.site_name_long)
			table.column(self.mission_patch)
			table.column(self.mission_patch_small)
			table.column(self.presskit)
			table.column(self.article_link)
			table.column(self.wikipedia)
			table.column(self.video_link)
			table.column(self.youtube_id)
			table.column(self.flickr_images)
		}
		do {
			try self.database.run(createTable)
			print("Debug | Tabla creada")
		} catch  {
			print(error)
		}
	}
	
	func makeConnection() {
		if let savedDatabaseURL = UserDefaults.standard.url(forKey: "databaseURL") {
			do {
				self.database = try Connection(savedDatabaseURL.path)
			} catch {
				print("Debug | No se puedo realizar la conexión: \(error)")
			}
		} else {
			print("Debug | No existe la URL de la base de datos")
		}
	}
	
	func insertLaunch(launchPlaim: LaunchPlain) {
		
		self.makeConnection()
		
		do {
			
			let launchInsert = self.launchesTable.insert(
				self.id <- launchPlaim.flight_number,
				self.flight_number <- launchPlaim.flight_number,
				self.mission_name <- launchPlaim.mission_name,
				self.launch_date_utc <- launchPlaim.launch_date_utc,
				self.launch_date_local <- launchPlaim.launch_date_local,
				self.details <- launchPlaim.details,
				self.rocket_id <- launchPlaim.rocket_id,
				self.rocket_name <- launchPlaim.rocket_name,
				self.rocket_type <- launchPlaim.rocket_type,
				self.site_id <- launchPlaim.rocket_type,
				self.site_name <- launchPlaim.site_name,
				self.site_name_long <- launchPlaim.site_name_long,
				self.mission_patch <- launchPlaim.mission_patch,
				self.mission_patch_small <- launchPlaim.mission_patch_small,
				self.presskit <- launchPlaim.presskit,
				self.article_link <- launchPlaim.article_link,
				self.wikipedia <- launchPlaim.wikipedia,
				self.video_link <- launchPlaim.video_link,
				self.youtube_id <- launchPlaim.youtube_id,
				self.flickr_images <- launchPlaim.flickr_images.joined(separator: ",")
			)
			
			try self.database.run(launchInsert)
			print("Debug | Registro guardado")
		} catch  {
			print("Debug | Error al regsitrar:", error)
		}
	}
	
	func listLaunches() -> [LaunchPlain] {
		
		var arrayLaunchPlain: [LaunchPlain] = []
		self.makeConnection()
		
		do {
			let launches = try self.database.prepare(self.launchesTable)
			for launchDB in launches {
				let launchPlain = LaunchPlain(
					flight_number: launchDB[self.flight_number],
					mission_name: launchDB[self.mission_name],
					launch_date_utc: launchDB[self.launch_date_utc],
					launch_date_local: launchDB[self.launch_date_local],
					details: launchDB[self.details],
					rocket_id: launchDB[self.rocket_id],
					rocket_name: launchDB[self.rocket_name],
					rocket_type: launchDB[self.rocket_type],
					site_id: launchDB[self.site_id],
					site_name: launchDB[self.site_name],
					site_name_long: launchDB[self.site_name_long],
					mission_patch: launchDB[self.mission_patch],
					mission_patch_small: launchDB[self.mission_patch_small],
					presskit: launchDB[self.presskit],
					article_link: launchDB[self.article_link],
					wikipedia: launchDB[self.wikipedia],
					video_link: launchDB[self.video_link],
					youtube_id: launchDB[self.youtube_id],
					flickr_images: launchDB[self.flickr_images].components(separatedBy: ",")
				)
				arrayLaunchPlain.append(launchPlain)
			}
			print("Debug | Registros recuperados")
			return arrayLaunchPlain
		} catch {
			print("Debug | Error en el listado: ", error)
			return arrayLaunchPlain
		}
	}
	
	func deleteTable() {
		self.makeConnection()
		let launches = self.launchesTable
		let deleteLaunches = launches.delete()
		do {
			try self.database.run(deleteLaunches)
			print("Debug | Base de datos borrada")
		} catch  {
			print("Debug | Error al borrar los registros de la tabla: ", error)
		}
	}
	
}
