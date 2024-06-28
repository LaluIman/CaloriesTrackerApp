//
//  AddFoodView.swift
//  CaloriesApp
//
//  Created by Lalu Iman Abdullah on 28/06/24.
//

import SwiftUI

struct AddFoodView: View {
    @Environment(\.managedObjectContext) var managedObjectContext
    @Environment(\.dismiss) var dismiss
    
    @State private var name = ""
    @State private var calories: Double = 0
    
    var body: some View {
        Form{
            Section{
                TextField("Food Name", text: $name)
                
                VStack{
                    Text("Calories: \(Int(calories))")
                    Slider(value: $calories, in: 0...1000, step: 10)
                }
                .padding()
                HStack{
                    Spacer()
                    Button {
                        DataController().addFood(name: name, calories: calories, context: managedObjectContext)
                        dismiss()
                    } label: {
                        Text("Add food!")
                            .font(.title3).bold()
                            .foregroundStyle(.white)
                            .padding()
                            .background(.blue)
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                    }

                    Spacer()
                }
            }
        }
    }
}

#Preview {
    AddFoodView()
}
