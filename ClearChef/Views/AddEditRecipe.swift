//
//  AddEditRecipe.swift
//  ClearChef
//
//  Created by Taylor Newman on 2024-03-08.
//

import Foundation
import SwiftUI

struct AddEditRecipe: View {
    var recipe: Recipe // recipe as param
    //Probably include a function argument here to call when done editing with new state.
    @State private var description = "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book."
    @State private var prepTime: Date = Date()
    @State private var cookTime: Date = Date()
    
    @State var data: [(String, [String])] = [
        ("One", Array(0...24).map { "\($0) h" }),
        ("Two", Array(0...60).map { "\($0) m" }),
    ]
    @State var selection: [String] = [0, 20].map { "\($0)" }
    @State private var openMenu: Bool = false

    
    var body: some View {
        Form {
            Image(systemName: "birthday.cake")
                .resizable()
            Text(description)
            HStack {
                Text("Category")
                Spacer()
                Text("PlaceHolder")
            }
            HStack {
                //if let date = cookTime {
                //    Text(date.formatted())
                //} else {
                Text("Test")
                Spacer()
                Text("Pick Time").onTapGesture {
                    openMenu.toggle()
                }.IOSPopover(isPresented: $openMenu, arrowDirection: .down, content: {
                    HStack{
                        MultiPicker(data: data, selection: $selection).frame(height: 300).frame(width: 300)
                    }
                })
                //}
                
            }
            HStack {
                Text("Cook Time")
                Spacer()
                Text("1 Hour and 30 Minutes")
            }
            Section("Ingredients") {
                Text("1 cup oil")
                Text("3 tbsp peanuts")
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
