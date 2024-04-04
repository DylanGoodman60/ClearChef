//
//  AddEditRecipe.swift
//  ClearChef
//
//  Created by Taylor Newman on 2024-03-08.
//

import Foundation
import SwiftUI
import PhotosUI

struct AddEditRecipe: View {
    @Binding var recipe: Recipe // recipe as param
    //Probably include a function argument here to call when done editing with new state.
    @State private var showAddIngredient = false
    @State private var showAddDirection = false
    @EnvironmentObject private var dataStore: DataStore
    
    let data: [(String, [String])] = [
        ("One", Array(0...24).map { "\($0) h" }),
        ("Two", Array(0...60).map { "\($0) m" }),
    ]
    
    @State private var prepTimeOpenMenu: Bool = false
    @State private var cookTimeOpenMenu: Bool = false
    @State private var newItem = ""
    @State private var displayItem: PhotosPickerItem?
    
    func fakeInit() {
        for direction in recipe.directions {
            if recipe.directionsMap[direction.id] == nil {
                recipe.directionsMap[direction.id] = []
            }
        }
    }
    
    func durationString(selection: [String]) -> Text {
        var a: String = selection[1]
        if selection[0] != "0 h" {
            a = selection[0] + " " + a
        }
        return Text(a)
    }
    
    
    func removeIndexFromIngredientsCallback() -> (Int, UUID) -> Void{
        func removeIndex(index: Int, id: UUID) {
            for direction_index in recipe.directionsMap {
                if let index = recipe.directionsMap[direction_index.key]?.firstIndex(of: id) {
                    recipe.directionsMap[direction_index.key]?.remove(at: index)
                }
            }
            recipe.ingredients.remove(at: index)
        }
        
        return removeIndex
    }
    
    func removeIndexFromDirectionsCallback() -> (Int, UUID) -> Void{
        func removeIndex(index: Int, id: UUID) {
            recipe.directionsMap.removeValue(forKey: id)
            recipe.directions.remove(at: index)
        }
        
        return removeIndex
    }
    
    var body: some View {
            Form {
                VStack{
                    if #available(iOS 17.0, *) {
                        PhotosPicker("Select Display Image", selection: $displayItem, matching: .images).onChange(of: displayItem) {
                            Task {
                                if let loaded = try? await displayItem?.loadTransferable(type: Image.self) {
                                    recipe.image = loaded
                                } else {
                                    print("Failed")
                                }
                            }
                        }
                    } else {
                        // Fallback on earlier versions
                    }
                    recipe.image.resizable().scaledToFit().frame(height: 200)
                }
                HStack {
                    Text("Title").padding(.trailing)
                    Spacer()
                    TextField("Title", text: $recipe.title).onAppear {
                        UITextField.appearance().clearButtonMode = .whileEditing
                    }
                }
                
                VStack(alignment: .leading) {
                    Text("Description").font(.headline)
                    Spacer()
                    TextField("Description", text: $recipe.description, axis: .vertical)
                }
                HStack {
                    Text("Prep Time")
                    Spacer()
                    
                    ZStack{
                        durationString(selection: recipe.prepTime).onTapGesture {
                                            prepTimeOpenMenu.toggle()
                                        }.IOSPopover(isPresented: $prepTimeOpenMenu, arrowDirection: .down, content: {
                                            HStack{
                                                MultiPicker(data: data, selection: $recipe.prepTime).frame(height: 300).frame(width: 300)
                                            }
                                        }).padding(7.0)
                                            .background(prepTimeOpenMenu ? .picker : .gray.opacity(0.2))
                                            .cornerRadius(6.0)
                                            .foregroundStyle(.blue)
                                            .animation(.spring())

                    }
                                    
                }
                Picker("Category", selection: $recipe.category) {
                    ForEach(dataStore.categories, id: \.self) { category in
                        Text(category.capitalized)
                    }
                }.pickerStyle(.menu)
                HStack {
                    Text("Difficulty")
                    Spacer()
                    RatingView(rating: $recipe.difficulty)
                }
                
                HStack {
                    Text("Cook Time")
                    Spacer()
                    ZStack{
                        durationString(selection: recipe.cookTime).onTapGesture {
                                            cookTimeOpenMenu.toggle()
                                        }.IOSPopover(isPresented: $cookTimeOpenMenu, arrowDirection: .down, content: {
                                            HStack{
                                                MultiPicker(data: data, selection: $recipe.cookTime).frame(height: 300).frame(width: 300)
                                            }
                                        }).padding(7.0)
                                            .background(cookTimeOpenMenu ? .picker : .gray.opacity(0.2))
                                            .cornerRadius(6.0)
                                            .foregroundStyle(.blue)
                                            .animation(.spring())

                    }
                }

                
                
                
                Section("Ingredients") {
                    ForEach(0..<recipe.ingredients.count, id: \.self) { ingredient_index in
                        IngredientsRow(ingredient: $recipe.ingredients[ingredient_index], index: ingredient_index, removeFromList: removeIndexFromIngredientsCallback())
                    }
                    HStack {
                        Spacer()
                        Image(systemName: "plus.circle").foregroundStyle(.blue)
                        Button("Add Ingredient") {  
                            showAddIngredient = true
                        }.alert("Add Ingredient", isPresented: $showAddIngredient) {
                            TextField("Ingredient", text: $newItem)
                            Button("Cancel", role: .cancel) {
                                newItem = ""
                            }
                            Button("OK") {
                                recipe.ingredients.append(Ingredient(title: newItem))
                                newItem = ""
                            }
                        }
                        Spacer()
                    }

                }
                
                Section("Directions") {
                    
                    List {
                        ForEach(0..<recipe.directions.count, id: \.self) { direction_index in
                            DirectionRow(direction: $recipe.directions[direction_index],
                                         index: direction_index,
                                         removeFromList: removeIndexFromDirectionsCallback(),
                                         directionMap: $recipe.directionsMap,
                                         ingredients: recipe.ingredients)
                        }
                    }

                    HStack {
                        Spacer()
                        Image(systemName: "plus.circle").foregroundStyle(.blue)
                        Button("Add Direction") {
                            showAddDirection = true
                        }.alert("Add Direction", isPresented: $showAddDirection) {
                            TextField("Direction", text: $newItem)
                            Button("Cancel", role: .cancel) {
                                newItem = ""
                            }
                            Button("OK") {
                                let newDirection = Direction(title: newItem)
                                recipe.directionsMap[newDirection.id] = []
                                recipe.directions.append(newDirection)
                                newItem = ""
                            }
                        }
                        Spacer()
                    }

                }.onAppear(perform: {
                    fakeInit()
                })
                

                
            }
        }
}

struct IngredientsRow: View {

    @Binding var ingredient: Ingredient
    var index: Int
    var removeFromList: (Int, UUID) -> Void
    
    var body: some View {
        HStack {
            ZStack {
                Image(systemName: "circle.fill").foregroundStyle(.blue)
                Text((index + 1).formatted()).font(.caption).fontWeight(.bold).foregroundStyle(.white)
            }.padding(.trailing)
            TextField("Ingredient", text: $ingredient.title).onAppear {
                UITextField.appearance().clearButtonMode = .whileEditing
            }
            Spacer()
            Image(systemName: "minus.circle.fill").foregroundStyle(.red).onTapGesture {
                removeFromList(index, ingredient.id)
            }

        }
    }
}

struct DirectionRow: View {

    @Binding var direction: Direction
    var index: Int
    var removeFromList: (Int, UUID) -> Void
    @Binding var directionMap: [UUID: [UUID]]
    let ingredients: [Ingredient]
    @State private var openLinkMenu = false
    
    
    var body: some View {
        ZStack {
            HStack {
                ZStack {
                    Image(systemName: "circle.fill").foregroundStyle(.blue)
                    Text((index + 1).formatted()).font(.caption).fontWeight(.bold).foregroundStyle(.white)
                }.padding(.trailing)
                TextField("Ingredient", text: $direction.title).onAppear {
                    UITextField.appearance().clearButtonMode = .whileEditing
                }

                Spacer()
                
                Image(systemName: "minus.circle.fill").foregroundStyle(.red).onTapGesture {
                    removeFromList(index, direction.id)
                }
                Image(systemName: "link.badge.plus").foregroundStyle(.blue).onTapGesture {
                    openLinkMenu.toggle()
                }.popover(isPresented: $openLinkMenu ) {
                    VStack {
                        Button("Close") {
                            openLinkMenu.toggle()
                        }
                        IngredientLinkPage(ingredients: ingredients, directionMapList: $directionMap, direction: direction.id).frame(height: 300).padding()
                    }
                }
                
            }
        }
    }
}

struct MultiPicker: View  {

    typealias Label = String
    typealias Entry = String

    let data: [ (Label, [Entry]) ]
    @Binding var selection: [Entry]

    var body: some View {
        GeometryReader { geometry in
            HStack {
                ForEach(0..<self.data.count) { column in
                    Picker(self.data[column].0, selection: self.$selection[column]) {
                        ForEach(0..<self.data[column].1.count) { row in
                            Text(verbatim: self.data[column].1[row])
                            .tag(self.data[column].1[row])
                        }
                    }
                    .pickerStyle(WheelPickerStyle())
                    .frame(width: geometry.size.width / CGFloat(self.data.count), height: geometry.size.height)
                    .clipped()
                }
            }
        }
    }
}




extension View {
  @ViewBuilder
  func IOSPopover<Content: View>(isPresented: Binding<Bool>, arrowDirection: UIPopoverArrowDirection, @ViewBuilder content: @escaping ()->Content)->some View {
    self
      .background {
          PopOverController(isPresented: isPresented, arrowDirection: arrowDirection, content: content())
      }
  }
}

struct PopOverController<Content: View>: UIViewControllerRepresentable {
  @Binding var isPresented: Bool
  var arrowDirection: UIPopoverArrowDirection
  var content: Content

  @State private var alreadyPresented: Bool = false

  func makeCoordinator() -> Coordinator {
    return Coordinator(parent: self)
  }

  func makeUIViewController(context: Context) -> some UIViewController {
    let controller = UIViewController()
    controller.view.backgroundColor = .clear
    return controller
  }

  func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
    if alreadyPresented {
      if !isPresented {
        uiViewController.dismiss(animated: true) {
          alreadyPresented = false
        }
      }
    } else {
      if isPresented {
        let controller = CustomHostingView(rootView: content)
        controller.view.backgroundColor = .systemBackground
        controller.modalPresentationStyle = .popover
        controller.popoverPresentationController?.permittedArrowDirections = arrowDirection
            
        controller.presentationController?.delegate = context.coordinator
            
        controller.popoverPresentationController?.sourceView = uiViewController.view
            
        uiViewController.present(controller, animated: true)
      }
    }
  }

  class Coordinator: NSObject,UIPopoverPresentationControllerDelegate{
    var parent: PopOverController
    init(parent: PopOverController) {
      self.parent = parent
    }
    
    func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
      return .none
    }
    
    func presentationControllerWillDismiss(_ presentationController: UIPresentationController) {
      parent.isPresented = false
    }
    
    func presentationController(_ presentationController: UIPresentationController, willPresentWithAdaptiveStyle style: UIModalPresentationStyle, transitionCoordinator: UIViewControllerTransitionCoordinator?) {
      DispatchQueue.main.async {
        self.parent.alreadyPresented = true
      }
    }
  }
}

class CustomHostingView<Content: View>: UIHostingController<Content>{
  override func viewDidLoad() {
    super.viewDidLoad()
    preferredContentSize = view.intrinsicContentSize
  }
}
