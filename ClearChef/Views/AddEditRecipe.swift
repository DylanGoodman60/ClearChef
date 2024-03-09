//
//  AddEditRecipe.swift
//  ClearChef
//
//  Created by Taylor Newman on 2024-03-08.
//

import Foundation
import SwiftUI


enum Flavor: String, CaseIterable, Identifiable {
    case chocolate, vanilla, strawberry
    var id: Self { self }
}

struct AddEditRecipe: View {
    var recipe: Recipe // recipe as param
    //Probably include a function argument here to call when done editing with new state.
    @State private var description = "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book."
    @State private var prepTime: Date?
    @State private var cookTime: Date?
    @State private var selectedFlavor: Flavor = .chocolate
    @State private var title = ""
    @State private var showAddIngredient = false

    
    let data: [(String, [String])] = [
        ("One", Array(0...24).map { "\($0) h" }),
        ("Two", Array(0...60).map { "\($0) m" }),
    ]
    
    @State private var prepTimeSelection: [String] = ["0 h", "20 m"]
    @State private var prepTimeOpenMenu: Bool = false
    
    @State private var cookTimeSelection: [String] = ["0 h", "20 m"]
    @State private var cookTimeOpenMenu: Bool = false
    
    @State private var ingredients: [Ingredient] = [Ingredient(title:"1 cup oil"), Ingredient(title:"3 tbsp peanuts"), Ingredient(title:"Boof")]
    @State private var directions: [Direction] = [
        Direction(title: "Add thing to thing"),
        Direction(title: "Make the sauce")
    ]
    
    
    @State private var directionsMap: [UUID: [UUID]] = [:]
    
    @State private var newItem = ""
    
    func fakeInit() {
        for direction in directions {
            directionsMap[direction.id] = []
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
            for direction_index in directionsMap {
                if let index = directionsMap[direction_index.key]?.firstIndex(of: id) {
                    directionsMap[direction_index.key]?.remove(at: index)
                }
            }
            ingredients.remove(at: index)
        }
        
        return removeIndex
    }
    
    func removeIndexFromDirectionsCallback() -> (Int, UUID) -> Void{
        func removeIndex(index: Int, id: UUID) {
            directionsMap.removeValue(forKey: id)
            directions.remove(at: index)
        }
        
        return removeIndex
    }
    
    
    var body: some View {
        Form {
            HStack {
                Text("Title").padding(.trailing)
                Spacer()
                TextField("Title", text: $title).onAppear {
                    UITextField.appearance().clearButtonMode = .whileEditing
                }
            }
            
            VStack(alignment: .leading) {
                Text("Description").font(.headline)
                Spacer()
                TextField("Description", text: $description, axis: .vertical)
            }
            HStack {
                Text("Prep Time")
                Spacer()
                
                ZStack{
                    durationString(selection: self.prepTimeSelection).onTapGesture {
                                        prepTimeOpenMenu.toggle()
                                    }.IOSPopover(isPresented: $prepTimeOpenMenu, arrowDirection: .down, content: {
                                        HStack{
                                            MultiPicker(data: data, selection: $prepTimeSelection).frame(height: 300).frame(width: 300)
                                        }
                                    }).padding(7.0)
                                        .background(prepTimeOpenMenu ? .picker : .gray.opacity(0.2))
                                        .cornerRadius(6.0)
                                        .foregroundStyle(.blue)
                                        .animation(.spring())

                }
                                
            }
            Picker("Category", selection: $selectedFlavor) {
                ForEach(Flavor.allCases) { flavor in
                    Text(flavor.rawValue.capitalized)
                }
            }.pickerStyle(.menu)
            HStack {
                Text("Cook Time")
                Spacer()
                ZStack{
                    durationString(selection: self.cookTimeSelection).onTapGesture {
                                        cookTimeOpenMenu.toggle()
                                    }.IOSPopover(isPresented: $cookTimeOpenMenu, arrowDirection: .down, content: {
                                        HStack{
                                            MultiPicker(data: data, selection: $cookTimeSelection).frame(height: 300).frame(width: 300)
                                        }
                                    }).padding(7.0)
                                        .background(cookTimeOpenMenu ? .picker : .gray.opacity(0.2))
                                        .cornerRadius(6.0)
                                        .foregroundStyle(.blue)
                                        .animation(.spring())

                }
            }

            PhotosSelector()
            
            Section("Ingredients") {
                ForEach(0..<ingredients.count, id: \.self) { ingredient_index in
                    IngredientsRow(ingredient: $ingredients[ingredient_index], index: ingredient_index, removeFromList: removeIndexFromIngredientsCallback())
                }
                HStack {
                    Spacer()
                    Image(systemName: "plus.circle").foregroundStyle(.blue)
                    Button("Add Ingredient") {  
                        showAddIngredient = true
                        newItem = ""
                    }.alert("Add Ingredient", isPresented: $showAddIngredient) {
                        TextField("Ingredient", text: $newItem)
                        Button("Cancel", role: .cancel) {

                        }
                        Button("OK") {
                            ingredients.append(Ingredient(title: newItem))
                        }
                    }
                    Spacer()
                }

            }
            
            Section("Directions") {
                ForEach(0..<directions.count, id: \.self) { direction_index in
                    DirectionRow(direction: $directions[direction_index], index: direction_index, removeFromList: removeIndexFromDirectionsCallback())
                }

                HStack {
                    Spacer()
                    Image(systemName: "plus.circle").foregroundStyle(.blue)
                    Button("Add Ingredient") {
                        showAddIngredient = true
                        newItem = ""
                    }.alert("Add Ingredient", isPresented: $showAddIngredient) {
                        TextField("Ingredient", text: $newItem)
                        Button("Cancel", role: .cancel) {

                        }
                        Button("OK") {
                            directions.append(Direction(title: newItem))
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
    @State private var showEditAlert = false
    @State private var workingTitle: String = ""

    var body: some View {
        HStack {
            ZStack {
                Image(systemName: "circle.fill").foregroundStyle(.blue)
                Text((index + 1).formatted()).font(.caption).fontWeight(.bold).foregroundStyle(.white)
            }.padding(.trailing)
            Text(ingredient.title)
            Spacer()
            Image(systemName: "pencil.circle").foregroundStyle(.blue).onTapGesture {
                showEditAlert = true                
                self.workingTitle = ingredient.title
            }.alert("Edit Ingredient", isPresented: $showEditAlert) {
                TextField("Ingredient", text: $workingTitle)
                Button("Cancel", role: .cancel) {

                }
                Button("OK") {
                    ingredient.title = self.workingTitle
                }
            }
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
    @State private var showEditAlert = false
    @State private var showLinkAlert = false
    @State private var workingTitle: String = ""

    var body: some View {
        HStack {
            ZStack {
                Image(systemName: "circle.fill").foregroundStyle(.blue)
                Text((index + 1).formatted()).font(.caption).fontWeight(.bold).foregroundStyle(.white)
            }.padding(.trailing)
            Text(direction.title)
            Spacer()
            Image(systemName: "link.badge.plus").foregroundStyle(.blue)
            Image(systemName: "pencil.circle").foregroundStyle(.blue).onTapGesture {
                showEditAlert = true
                self.workingTitle = direction.title
            }.alert("Edit Ingredient", isPresented: $showEditAlert) {
                TextField("Ingredient", text: $workingTitle)
                Button("Cancel", role: .cancel) {

                }
                Button("OK") {
                    direction.title = self.workingTitle
                }
            }
            Image(systemName: "minus.circle.fill").foregroundStyle(.red).onTapGesture {
                removeFromList(index, direction.id)
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

#Preview {
    AddEditRecipe(recipe: Recipe(id: "test"))
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
