//
//  MainTeslaView.swift
//  TeslaApp
//
//  Created by Anastasiya Omak on 14/05/2024.
//

import SwiftUI

var headerView: some View {
    HStack {
        VStack(alignment: .leading){
            Text("Tesla")
                .font(.system(size: 28))
                .fontWeight(.bold)
                .foregroundColor(.white)
            Text("187 km")
                .font(.system(size: 17))
                .fontWeight(.semibold)
                .opacity(0.4)
        }
        Spacer()
    }
    .padding(.all, 25)
    
}


struct MainTeslaView: View {

    func backgroundStackView<Content: View>(content: () -> Content) -> some View {
        ZStack {
            Rectangle()
                .fill(Color.background)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .edgesIgnoringSafeArea(.all)
            content()
        }
    }
    var body: some View {
        ZStack {
            backgroundStackView {
                VStack {
                    headerView
                    carView
                    controlPanelView
                        .padding(.bottom, 50)
                        .frame(height: 40)
                    if tagSelected == 1 {
                        closeCarControlView
                    }
                    navigationView
//                        .padding(.bottom, 50)

                }
                .padding(.bottom, 300)
            }
            .navigationBarBackButtonHidden(true)
      
                        }
                    }
    
    @Environment(\.presentationMode) var presentationMode
    @State private var isShowingMainTesla = false
    @State var isCarClose = false
    @State var tagSelected = 0
    @State private var shouldNavigateToTabView = false
    @State private var shouldNavigateToClimateView = false
    @Environment(\.dismiss) private var dismiss
    @State private var shouldNavigateToEnergyView = false
    @State private var shoulNavigateToCharacteristicsView = false
    
    @State private var selectedTab = 0
    
    var carView: some View {
        Image(isCarClose ? "closeCar" : "car")
            .resizable()
            .frame(height: 200)
            .padding(.horizontal)
            .padding(.bottom, 40)
            .shadow(color: .white.opacity(0.6), radius: 15, x: 10, y: 10)
    }
    
    var gradient: LinearGradient {
        LinearGradient(colors: [.topDradient, .botomGradient], startPoint: .bottom, endPoint: .top)
    }

    var controlPanelView: some View {
        HStack(spacing: 30) {
            ForEach(1..<5) { index in
                Button {
                    withAnimation {
                        tagSelected = index
                        navigateToViews()
                    }
                } label: {
                    Image("\(index)")
                        .resizable()
                        .frame(width: 20, height: 20)
                        .neumorphismUNSelectedCircle()
                        .overlay(Circle()
                            .stroke(gradient, lineWidth: 2)
                            .opacity(tagSelected == index ? 1 : 0)
                        )
                }
            }
            
        }
        .padding()
        .background(RoundedRectangle(cornerRadius: 50).fill(Color("background")))
        .neumorphismUnSelectedStyle()
    }
    
    var closeCarControlView: some View {
        Button {
            withAnimation {
                isCarClose.toggle()
            }
        } label: {
            HStack{
                Label {
                    Text(isCarClose ? "Закрыть" : "Открыть")
                            .foregroundColor(.white)
                    }
            icon: { if #available(iOS 16.0, *) {
                Image(systemName: isCarClose ? "lock.open.fill" : "lock.fill")
                    .renderingMode(.template)
                    .tint(gradient)
                    .neumorphismUNSelectedCircle()
                    .neumorphismSelectedStyle()
            } else {
            }
                    }
            }
            .padding()
            .background(RoundedRectangle(cornerRadius: 50).fill(Color("background")))
            .neumorphismSelectedStyle()
        }
        .frame(width: 300)
    }
    private func navigateToViews() {
        switch tagSelected {
            case 1:
            closeCarControlView
        case 2:
            shouldNavigateToClimateView.toggle()
        case 3:
            shouldNavigateToEnergyView.toggle()
        case 4:
            shoulNavigateToCharacteristicsView.toggle()
        default:
            break
        }
    }
    private var navigationView: some View {
        VStack {
            NavigationLink(
                destination: ClimateView(),
                isActive: $shouldNavigateToClimateView,
                label: {})
            NavigationLink(
                destination: Text("Screen under development"),
                isActive: $shouldNavigateToEnergyView,
                label: {})
            NavigationLink(
                destination: Text("Screen under development"),
                isActive: $shoulNavigateToCharacteristicsView,
                label: {})
        }
    }
}

#Preview {
    MainTeslaView()
        .environment(\.colorScheme, .dark)
}
