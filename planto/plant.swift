//
//  plant.swift
//  planto
//
//  Created by Joud Alhatim on 4/24/46.
//
// Define the plant data structure
import Foundation

struct PlantData: Identifiable, Codable {
    var id = UUID() // unique identifier for each plant
    var name: String
    var room: String
    var light: String
    var wateringDays: String
    var waterAmount: String
    var isChecked: Bool = false
    var hasReminderForToday: Bool = false // example field for today’s reminder
}
