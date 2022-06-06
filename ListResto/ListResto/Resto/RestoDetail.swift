//
//  RestoDetail.swift
//  ListResto
//
//  Created by Syamsuddin Putra Riefli on 23/05/22.
//

import SwiftUI

struct RestoDetail: View {
    @EnvironmentObject var modelData: ModelData
    
    
    var body: some View {
        ScrollView {
            MapsResto(coordinate: modelData.restoData.mapResto)
                .ignoresSafeArea(edges: .top)
                .frame(height: 300)
            
            AsyncImage(url: URL(string: modelData.restoData.img))
                .aspectRatio(contentMode: .fit)
                .frame(width:200, height: 200)
                .clipShape(Circle())
                .overlay{
                    Circle().stroke(.brown, lineWidth: 4)
                }
                .shadow(radius: 30)
                .offset(y: -110)
                .padding(.bottom,-110)
            
            VStack (alignment: .leading){
                HStack {
                    Text(modelData.restoData.nama_resto)
                        .font(.title)
                    if (modelData.restoData.fav == "true") {
                        Image(systemName: "hand.thumbsup.fill")
                            .foregroundColor(.brown)
                            .imageScale(.medium)
                    } else {
                        Image(systemName: "hand.thumbsdown.fill")
                            .foregroundColor(.brown)
                            .imageScale(.medium)
                    }
                    
                    Spacer()
                    
                    Text("\(modelData.restoData.rating)/5")
                    Image(systemName: "star.fill")
                        .foregroundColor(.yellow)
                        .imageScale(.medium)
                }
                
                Divider()
                
                Text("About \(modelData.restoData.nama_resto)")
                    .font(.title3)
                Text(modelData.restoData.detail)
                    .font(.subheadline)
            }
            .padding()
        }
        .navigationTitle(modelData.restoData.nama_resto)
        .navigationBarTitleDisplayMode(.inline)
    }
}


struct RestoDetail_Previews: PreviewProvider {
    static var previews: some View {
        RestoDetail()
            .environmentObject(ModelData())
    }
}
