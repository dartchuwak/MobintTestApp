//
//  Cell.swift
//  MobintTestApp
//
//  Created by Evgenii Mikhailov on 14.04.2023.
//

import SwiftUI

struct Cell: View {
    
    @ObservedObject var cellViewModel: CellViewModel
    @State var showAlert: MyAlert? = nil
    @State var isAlert = false
    var onTap: (MyAlert) -> Void
    
    var body: some View {
        VStack(alignment: .center, spacing: 0) {
            HStack( alignment: .center) {
                Text(cellViewModel.item.mobileAppDashboard.companyName)
                    .foregroundColor(Color(UIColor(hex: cellViewModel.item.mobileAppDashboard.highlightTextColor) ?? .white))
                    .font(.system(size: 24))
                    .fontWeight(.light)
                    .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
                Spacer()
                AsyncImage(url: URL(string: cellViewModel.item.mobileAppDashboard.logo), content: { image in
                    image.resizable()
                }, placeholder: {
                    ProgressView()
                        .frame(width: 50, height: 50)
                    
                })
                .frame(width: 50, height: 50)
                .cornerRadius(25)
                .clipShape(Circle())
                .padding(EdgeInsets(top: 16, leading: 0, bottom: 8, trailing: 0))
            }
            Divider()
            HStack(alignment: .lastTextBaseline, spacing: 8) {
                Text(cellViewModel.item.customerMarkParameters.loyaltyLevel.requiredSum.description)
                    .foregroundColor(cellViewModel.highlightTextColor)
                    .font(.system(size: 28))
                    .fontWeight(.regular)
                Text("баллов")
                    .foregroundColor(cellViewModel.textColor)
                    .font(.subheadline)
                
                Spacer()
            }
            .padding(EdgeInsets(top: 16, leading: 0, bottom: 16, trailing: 0))
            HStack(spacing: 64) {
                VStack(alignment: .leading, spacing: 8) {
                    Text("Кэшбек")
                        .foregroundColor(cellViewModel.textColor)
                        .font(.subheadline)
                    Text("1 %")
                }
                VStack(alignment: .leading, spacing: 8) {
                    Text("Уровень")
                        .foregroundColor(cellViewModel.textColor)
                        .font(.subheadline)
                    
                    Text("Базовый уровень")
                }
                Spacer()
            }
            .padding(EdgeInsets(top: 0, leading: 0, bottom: 8, trailing: 0))
            Divider()
            HStack {
                HStack(spacing: 64) {
                    Image(systemName: "eye")
                        .foregroundColor(cellViewModel.mainColor)
                        .padding(EdgeInsets(top: 0, leading: 8, bottom: 0, trailing: 0))
                        .onTapGesture {
                            onTap(MyAlert(message: "ID компании - \(cellViewModel.item.company.companyId)", title: "Нажата кнопка \"Глаз\""))
                           
                        }
                    Image(systemName: "xmark.bin")
                        .foregroundColor(cellViewModel.accentColor)
                        .onTapGesture {
                            onTap(MyAlert(message: "ID компании - \(cellViewModel.item.company.companyId)", title: "Нажата кнопка \"Корзина\""))
                        }
                }.padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
                Spacer(minLength: 8)
                Button(action: {
                    onTap(MyAlert(message: "ID компании - \(cellViewModel.item.company.companyId)", title: "Нажата кнопка \"Подробнее\""))
                }) {
                    Text("Подробнее")
                        .foregroundColor(cellViewModel.mainColor)
                }
                .padding(EdgeInsets(top: 8, leading: 24, bottom: 8, trailing: 24))
                .background(cellViewModel.backgroundColor)
                .cornerRadius(10)
            }.padding(EdgeInsets(top: 8, leading: 8, bottom: 16, trailing: 0))
        }
        .padding(.horizontal)
        .background(cellViewModel.cardBackgroundColor)
        .cornerRadius(25)
    }
}

struct MyAlert: Identifiable {
    let id = UUID()
    let message: String
    let title: String
}

struct Cell_Previews: PreviewProvider {
    
    static var previews: some View {
        Cell(cellViewModel: CellViewModel(item: Item(company: Company(companyId: "id"), customerMarkParameters: CustomerMarkParameters(loyaltyLevel: LoyaltyLevel(number: 2, name: "Bonus Money", requiredSum: 200, markToCash: 200, cashToMark: 200), mark: 2), mobileAppDashboard: MobileAppDashboard(companyName: "Bonus Money", logo: "http://bonusmoney.info/image/mail/logo1.png", backgroundColor: "#A80923", mainColor: "#8164D7", cardBackgroundColor: "#5AD970", textColor: "#1CC2A4", highlightTextColor: "#104E37", accentColor: "#0E75B6"))), onTap: { alert in
            
        })
            .onAppear {
            }
    }
}
