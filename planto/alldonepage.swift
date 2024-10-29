import SwiftUI

struct PlantReminderView: View {
    @StateObject private var viewModel = PlantViewModel() // ViewModel to manage plants
    @State private var showAddPlantSheet = false
    
    // State variables for data to pass to AddPlantSheetView
    @State private var plantName = ""
    @State private var room = "Bedroom"
    @State private var light = "Full sun"
    @State private var wateringDays = "Every day"
    @State private var waterAmount = "20-50 ml"
    
    let roomOptions = ["Living Room", "Bedroom", "Kitchen", "Office"]
    let lightOptions = ["Full sun", "Partial Sun", "Low light"]
    let wateringOptions = ["Every day", "Every 2 days", "Every 3 days", "Once a week", "Every 10 days", "Every 2 weeks"]
    let waterAmountOptions = ["20-50 ml", "50-100 ml", "100-200 ml", "200-300 ml"]
    
    var body: some View {
        VStack {
            // Title aligned to the left
            HStack {
                Text("My Plants 🌱")
                    .font(.system(size: 34, weight: .bold))
                    .foregroundColor(.white)
                    .padding()
                    .padding(.leading, -10.0)
                Spacer()
            }
            .padding(.top, 50)
            .padding(.leading, 20)
            
            Divider()
                .background(Color.gray)
            
            // Centered image and completion message
            VStack {
                Image("alldone")
                    .resizable()
                    .frame(width: 164, height: 200)
                    .foregroundColor(.green)
                    .padding(.top, 80)
                
                Text("All Done! 🎉")
                    .font(.system(size: 25, weight: .semibold))
                    .foregroundColor(.white)
                    .padding(.top, 27)
                
                Text("All Reminders Completed")
                    .font(.system(size: 16))
                    .foregroundColor(.mygray2)
                    .padding([.top, .leading, .trailing], -4.0)
            }
            .multilineTextAlignment(.center)
            
            Spacer()
            
            // Bottom aligned "New Reminder" button on the left
            HStack {
                Button(action: {
                    showAddPlantSheet = true // Toggle sheet presentation
                }) {
                    HStack {
                        Image(systemName: "plus.circle.fill")
                        Text("New Reminder")
                    }
                    .font(.title2)
                    .foregroundColor(.mygreen)
                }
                Spacer()
            }
            .padding(.bottom, 40)
            .padding(.leading, 20)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.black.edgesIgnoringSafeArea(.all))
        .sheet(isPresented: $showAddPlantSheet) {
            // Present the AddPlantSheetView here
            AddPlantSheetView(
                plantName: $plantName,
                room: $room,
                light: $light,
                wateringDays: $wateringDays,
                waterAmount: $waterAmount,
                isPresented: $showAddPlantSheet,
                roomOptions: roomOptions,
                lightOptions: lightOptions,
                wateringOptions: wateringOptions,
                waterAmountOptions: waterAmountOptions
            ) {
                // Closure to save the plant to the viewModel
                viewModel.savePlant(
                    name: plantName,
                    room: room,
                    light: light,
                    wateringDays: wateringDays,
                    waterAmount: waterAmount
                )
                
                // Clear the inputs after saving
                resetInputs()
            }
        }
    }
    
    // Function to reset input fields after saving
    private func resetInputs() {
        plantName = ""
        room = "Bedroom"
        light = "Full sun"
        wateringDays = "Every day"
        waterAmount = "20-50 ml"
    }
}

struct PlantReminderView_Previews: PreviewProvider {
    static var previews: some View {
        PlantReminderView()
    }
}
