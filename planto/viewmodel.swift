import SwiftUI

class PlantViewModel: ObservableObject {
    @Published var plants: [PlantData] = [] // Array to hold plant data
    
    init() {
        loadPlants() // Load plants from storage on initialization
    }
    
    // Save a new plant to the list
    func savePlant(name: String, room: String = "Bedroom", light: String = "Full sun", wateringDays: String = "Every day", waterAmount: String = "20-50 ml") {
        let newPlant = PlantData(name: name, room: room, light: light, wateringDays: wateringDays, waterAmount: waterAmount)
        plants.append(newPlant)
        savePlants() // Save the updated list to UserDefaults
    }
    
    // Delete a plant from the list
    func deletePlant(at offsets: IndexSet) {
        plants.remove(atOffsets: offsets)
        savePlants() // Save the updated list to UserDefaults
    }
    
    // Save the plant list to UserDefaults
    private func savePlants() {
        if let encodedData = try? JSONEncoder().encode(plants) {
            UserDefaults.standard.set(encodedData, forKey: "savedPlants")
        }
    }
    
    // Load the plant list from UserDefaults
    private func loadPlants() {
        if let savedData = UserDefaults.standard.data(forKey: "savedPlants"),
           let decodedPlants = try? JSONDecoder().decode([PlantData].self, from: savedData) {
            plants = decodedPlants
        }
    }
    
    // Update plant
    func updatePlant(plant: PlantData, name: String, room: String, light: String, wateringDays: String, waterAmount: String) {
        if let index = plants.firstIndex(where: { $0.id == plant.id }) {
            plants[index] = PlantData(id: plant.id, name: name, room: room, light: light, wateringDays: wateringDays, waterAmount: waterAmount, isChecked: plant.isChecked, hasReminderForToday: plant.hasReminderForToday)
            savePlants()
        }
    }
}
