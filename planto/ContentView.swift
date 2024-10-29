import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = PlantViewModel()
    @State private var newPlantSheet = false
    
    @State private var plantName: String = ""
    @State private var room: String = "Bedroom"
    @State private var light: String = "Full sun"
    @State private var wateringDays: String = "Every day"
    @State private var waterAmount: String = "20-50 ml"
    
    let roomOptions = ["Living Room", "Bedroom", "Kitchen", "Office"]
    let lightOptions = ["Full sun", "Partial Sun", "Low light"]
    let wateringOptions = ["Every day", "Every 2 days", "Every 3 days", "Once a week", "Every 10 days", "Every 2 weeks"]
    let waterAmountOptions = ["20-50 ml", "50-100 ml", "100-200 ml", "200-300 ml"]
    
    // Computed property to check if all plants are checked
    private var allRemindersCompleted: Bool {
        viewModel.plants.allSatisfy { $0.isChecked }
    }
    
    var body: some View {
        NavigationStack {
            VStack {
                if viewModel.plants.isEmpty {
                    // Display when no reminders exist
                    VStack {
                        Spacer()
                        Image("img0")
                            .padding(.bottom, 25)
                        
                        Text("Start your plant journey!")
                            .font(.system(size: 25, weight: .semibold))
                            .foregroundColor(.white)
                            .padding(.bottom, 25)
                        
                        Text("Now all your plants will be in one place and \nwe will help you take care of them :) 🪴")
                            .font(.system(size: 16))
                            .foregroundColor(.gray)
                            .multilineTextAlignment(.center)
                            .padding(.bottom, 25)
                        
                        Button(action: {
                            newPlantSheet.toggle()
                        }) {
                            Text("Set a plant Reminder")
                                .font(.system(size: 14, weight: .bold))
                                .foregroundColor(Color.black)
                                .frame(width: 280, height: 40)
                                .background(Color.mygreen)
                                .cornerRadius(10)
                                .padding(.bottom, 200)
                        }
                        .sheet(isPresented: $newPlantSheet) {
                            AddPlantSheetView(
                                plantName: $plantName,
                                room: $room,
                                light: $light,
                                wateringDays: $wateringDays,
                                waterAmount: $waterAmount,
                                isPresented: $newPlantSheet,
                                roomOptions: roomOptions,
                                lightOptions: lightOptions,
                                wateringOptions: wateringOptions,
                                waterAmountOptions: waterAmountOptions
                            ) {
                                viewModel.savePlant(
                                    name: plantName,
                                    room: room,
                                    light: light,
                                    wateringDays: wateringDays,
                                    waterAmount: waterAmount
                                )
                                plantName = ""
                                room = "Bedroom"
                                light = "Full sun"
                                wateringDays = "Every day"
                                waterAmount = "20-50 ml"
                            }
                        }
                    }
                } else if allRemindersCompleted {
                    // Display when all reminders are completed
                    VStack {
                        Spacer()
                            .padding(.bottom,150)
                        Image("alldone")
                            .padding(.bottom,25)
                        Text("All Done! 🎉")
                            .bold()
                            .font(.title)
                            .foregroundColor(.white)
                        Text("All Reminders Completed")
                            .font(.body)
                            .foregroundColor(.gray)
                            .multilineTextAlignment(.center)
                            .padding(.horizontal, 15)
                    }
                    
                    VStack {
                        Spacer()
                        
                        HStack {
                            Button(action: {
                                newPlantSheet.toggle()
                            }) {
                                Image(systemName: "plus.circle.fill")
                                    .foregroundColor(Color.mygreen)
                                    .font(.system(size: 25))
                                    .padding(.bottom,60)
                                Text("New Reminder")
                                    .font(.title3)
                                    .foregroundColor(Color.mygreen)
                                    .font(.system(size: 25))
                                    .padding(.bottom,60)
                            }
                            .sheet(isPresented: $newPlantSheet) {
                                AddPlantSheetView(
                                    plantName: $plantName,
                                    room: $room,
                                    light: $light,
                                    wateringDays: $wateringDays,
                                    waterAmount: $waterAmount,
                                    isPresented: $newPlantSheet,
                                    roomOptions: roomOptions,
                                    lightOptions: lightOptions,
                                    wateringOptions: wateringOptions,
                                    waterAmountOptions: waterAmountOptions
                                ) {
                                    viewModel.savePlant(
                                        name: plantName,
                                        room: room,
                                        light: light,
                                        wateringDays: wateringDays,
                                        waterAmount: waterAmount
                                    )
                                    plantName = ""
                                    room = "Bedroom"
                                    light = "Full sun"
                                    wateringDays = "Every day"
                                    waterAmount = "20-50 ml"
                                }
                            }
                        }
                        .padding(.leading)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    }
                } else {
                    // Display reminders when they exist
                    VStack(alignment: .leading) {
                        Text("My Plants 🌱")
                            .font(.system(size: 34, weight: .bold))
                            .foregroundColor(.white)
                            .padding()
                            .padding(.leading, 10.0)
                        
                        if viewModel.plants.contains(where: { $0.hasReminderForToday }) {
                            Text("Today")
                                .font(.system(size: 28, weight: .bold))
                                .foregroundColor(.white)
                                .padding(.leading, 40)
                        }
                        
                        Divider()
                            .background(Color.gray)
                    }
                    .padding(.top, 10)
                    .padding(.bottom, 80)
                    
                    VStack {
                        List {
                            ForEach($viewModel.plants) { $plant in
                                VStack(alignment: .leading) {
                                    HStack(spacing: 14) {
                                        Button(action: {
                                            plant.isChecked.toggle()
                                        }) {
                                            Image(systemName: plant.isChecked ? "checkmark.circle.fill" : "circle")
                                                .foregroundColor(plant.isChecked ? .mygreen : .white)
                                                .font(.system(size: 23))
                                        }
                                        VStack(alignment: .leading, spacing: 6) {
                                            HStack {
                                                Image(systemName: "location.fill")
                                                    .foregroundColor(.mygray2)
                                                    .font(.system(size: 12))
                                                Text(plant.room)
                                                    .font(.subheadline)
                                                    .foregroundColor(.gray)
                                            }
                                            Text(plant.name)
                                                .font(.system(.largeTitle))
                                                .foregroundColor(.white)
                                                .multilineTextAlignment(.center)
                                            HStack(spacing: 12) {
                                                HStack {
                                                    Image(systemName: "sun.max")
                                                        .foregroundColor(.myyellow)
                                                        .font(.system(size: 14))
                                                    Text(plant.light)
                                                        .font(.subheadline)
                                                        .foregroundColor(.myyellow)
                                                }
                                                HStack {
                                                    Image(systemName: "drop")
                                                        .foregroundColor(.myblue)
                                                        .font(.system(size: 14))
                                                    Text(plant.waterAmount)
                                                        .font(.subheadline)
                                                        .foregroundColor(.myblue)
                                                }
                                            }
                                            
                                        }
                                    }
                                    Divider()
                                        .background(Color.gray)
                                }
                                .background(Color.black)
                                .listRowBackground(Color.black)
                            }
                            .onDelete(perform: viewModel.deletePlant)
                        }
                        .listStyle(PlainListStyle())
                        .scrollContentBackground(.hidden)
                        .background(Color.black)
                        
                        HStack {
                            Button(action: {
                                newPlantSheet.toggle()
                            }) {
                                HStack {
                                    Image(systemName: "plus.circle.fill")
                                    Text("New Reminder")
                                        .font(.system(size: 18))
                                }
                                .font(.title2)
                                .foregroundColor(.mygreen)
                                .padding()
                            }
                            .sheet(isPresented: $newPlantSheet) {
                                AddPlantSheetView(
                                    plantName: $plantName,
                                    room: $room,
                                    light: $light,
                                    wateringDays: $wateringDays,
                                    waterAmount: $waterAmount,
                                    isPresented: $newPlantSheet,
                                    roomOptions: roomOptions,
                                    lightOptions: lightOptions,
                                    wateringOptions: wateringOptions,
                                    waterAmountOptions: waterAmountOptions
                                ) {
                                    viewModel.savePlant(
                                        name: plantName,
                                        room: room,
                                        light: light,
                                        wateringDays: wateringDays,
                                        waterAmount: waterAmount
                                    )
                                    plantName = ""
                                    room = "Bedroom"
                                    light = "Full sun"
                                    wateringDays = "Every day"
                                    waterAmount = "20-50 ml"
                                }
                            }
                            Spacer()
                        }
                        .padding(.bottom, 60)
                    }
                }
            }
            .background(Color.black.edgesIgnoringSafeArea(.all))
        }
    }
}

#Preview {
    ContentView()
}
