//
//  AddPlantSheetView.swift
//  planto
//
//  Created by Joud Alhatim on 4/24/46.
//


import SwiftUI

struct AddPlantSheetView: View {
    @Binding var plantName: String
    @Binding var room: String
    @Binding var light: String
    @Binding var wateringDays: String
    @Binding var waterAmount: String
    @Binding var isPresented: Bool

    let roomOptions: [String]
    let lightOptions: [String]
    let wateringOptions: [String]
    let waterAmountOptions: [String]
    let saveAction: () -> Void

    var body: some View {
        NavigationView {
            VStack(spacing: 16) {
                ZStack {
                    RoundedRectangle(cornerRadius: 10)
                        .fill(Color.mygray)
                        .frame(height: 59)
                    HStack {
                        Text("Name").foregroundColor(.white).padding(.leading, 10)
                        Spacer()
                        TextField("", text: $plantName).foregroundColor(.white).padding(.trailing, 10)
                    }
                }
                .padding(.horizontal)

                VStack(spacing: 20) {
                    ZStack {
                        RoundedRectangle(cornerRadius: 10).fill(Color.mygray).frame(height: 95)
                        VStack(spacing: 0) {
                            HStack {
                                Image(systemName: "location").foregroundColor(.white)
                                Text("Room").foregroundColor(.white)
                                Spacer()
                                Picker("Room", selection: $room) {
                                    ForEach(roomOptions, id: \.self) { Text($0).foregroundColor(.mygray2) }
                                }
                                .pickerStyle(MenuPickerStyle())
                                .tint(Color.tintgray)
                            }
                            .padding(.horizontal)
                            Divider().background(Color.white)
                            HStack {
                                Image(systemName: "sun.max").foregroundColor(.white)
                                Text("Light").foregroundColor(.white)
                                Spacer()
                                Picker("Light", selection: $light) {
                                    ForEach(lightOptions, id: \.self) { Text($0).foregroundColor(.mygray2) }
                                }
                                .pickerStyle(MenuPickerStyle())
                                .tint(Color.tintgray)
                            }
                            .padding(.horizontal)
                        }
                    }
                    ZStack {
                        RoundedRectangle(cornerRadius: 10).fill(Color.mygray).frame(height: 95)
                        VStack(spacing: 0) {
                            HStack {
                                Image(systemName: "drop").foregroundColor(.white)
                                Text("Watering days").foregroundColor(.white)
                                Spacer()
                                Picker("Watering days", selection: $wateringDays) {
                                    ForEach(wateringOptions, id: \.self) { Text($0).foregroundColor(.mygray2) }
                                }
                                .pickerStyle(MenuPickerStyle())
                                .tint(Color.tintgray)
                            }
                            .padding(.horizontal)
                            Divider().background(Color.white)
                            HStack {
                                Image(systemName: "drop").foregroundColor(.white)
                                Text("Water").foregroundColor(.white)
                                Spacer()
                                Picker("Water", selection: $waterAmount) {
                                    ForEach(waterAmountOptions, id: \.self) { Text($0).foregroundColor(.mygray2) }
                                }
                                .pickerStyle(MenuPickerStyle())
                                .tint(Color.tintgray)
                            }
                            .padding(.horizontal)
                        }
                    }
                }
                .padding(.horizontal)

                Spacer()
            }
            .background(Color.mygray3.edgesIgnoringSafeArea(.all))
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancel", action: { isPresented = false })
                }
                ToolbarItem(placement: .principal) {
                    Text("Set Reminder").foregroundColor(.white).font(.headline)
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Save", action: {
                        saveAction()
                        isPresented = false
                    })
                }
            }
            .foregroundColor(.mygreen)
        }
    }
}
