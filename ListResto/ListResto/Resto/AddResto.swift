//
//  AddResto.swift
//  ListResto
//
//  Created by Syamsuddin Putra Riefli on 03/06/22.
//
// Credit : https://www.youtube.com/watch?v=0LrP6dv8tHY
//          https://www.youtube.com/watch?v=DOmHg-pDv9U

import SwiftUI
import MapKit
import CoreImage
import CoreImage.CIFilterBuiltins

struct AddResto: View {
    @EnvironmentObject var modelData: ModelData
    @State var nama_resto : String = ""
    @State var rating : String = ""
    @State var detail : String = ""
    @State var latitude : String = ""
    @State var longitude : String = ""
    @State var fav: String = ""
    @State var expand = false
    @State var choice = ["true", "false"]
    @State var showImgPick = false
    @State var selectImg: Image?
    @State var isKosong = false
    @State var encodedImg = ""
    
    @ObservedObject var location = MapManage()
    
    var body: some View {
        ScrollView {
            VStack {
                Text("Add New Resto")
                    .bold()
                    .padding(.bottom,20)
                TextField("Nama Resto", text: $nama_resto)
                    .disableAutocorrection(true)
                    .padding()
                    .cornerRadius(5)
                    .shadow(radius: 5)
                    .frame(width: 250, height: 40)
                    .overlay(
                        RoundedRectangle(cornerRadius: 20)
                            .stroke(.brown, lineWidth: 2)
                    )
                    .padding(.bottom,10)
                
                TextField("Rating", text: $rating)
                    .keyboardType(.numberPad)
                    .disableAutocorrection(true)
                    .autocapitalization(.none)
                    .padding()
                    .cornerRadius(5)
                    .shadow(radius: 5)
                    .frame(width: 250, height: 40)
                    .overlay(
                        RoundedRectangle(cornerRadius: 20)
                            .stroke(.brown, lineWidth: 2)
                    )
                    .padding(.bottom, 10)
                
                TextField("Detail", text: $detail)
                    .autocapitalization(.none)
                    .disableAutocorrection(true)
                    .padding()
                    .cornerRadius(5)
                    .shadow(radius: 5)
                    .frame(width: 250, height: 40)
                    .overlay(
                        RoundedRectangle(cornerRadius: 20)
                            .stroke(.brown, lineWidth: 2)
                    )
                    .padding(.bottom, 10)
                
                HStack {
                    VStack{
                        TextField("Latitude", text: $latitude)
                            .autocapitalization(.none)
                            .disableAutocorrection(true)
                            .padding()
                            .cornerRadius(5)
                            .shadow(radius: 5)
                            .frame(width: 150, height: 40)
                            .overlay(
                                RoundedRectangle(cornerRadius: 20)
                                    .stroke(.brown, lineWidth: 2)
                            )
                            .padding(.bottom, 10)
                        TextField("Longitude", text: $longitude)
                            .autocapitalization(.none)
                            .disableAutocorrection(true)
                            .padding()
                            .cornerRadius(5)
                            .shadow(radius: 5)
                            .frame(width: 150, height: 40)
                            .overlay(
                                RoundedRectangle(cornerRadius: 20)
                                    .stroke(.brown, lineWidth: 2)
                            )
                            .padding(.bottom, 10)
                    }
                    Button(action: {
                        self.location.startUpdating()
                        var tempLat: String {
                            return "\(location.lastKnownLocation?.coordinate.latitude ?? 0.0)"
                        }
                        var tempLong: String {
                            return "\(location.lastKnownLocation?.coordinate.longitude ?? 0.0)"
                        }
                        self.latitude = tempLat
                        self.longitude = tempLong
                    }){
                        Text("Get Location")
                            .font(.system(size: 13))
                            .foregroundColor(.white)
                            .frame(width: 100, height: 50)
                            .background(.brown)
                            .cornerRadius(20)
                            .shadow(radius: 5)
                    }
                }
                
                DisclosureGroup("Favorite? \(fav)", isExpanded: $expand){
                    VStack (alignment: .leading){
                        ForEach(choice, id: \.self) { selected in
                            Text("\(selected)")
                                .font(.title3)
                                .padding()
                                .onTapGesture {
                                    self.fav = selected
                                    withAnimation {
                                        self.expand.toggle()
                                    }
                                }
                        }
                    }
                }
                .accentColor(.white)
                .foregroundColor(.white)
                .padding()
                .background(.brown)
                .cornerRadius(20)
                
                VStack {
                    Button(action: {
                        self.showImgPick.toggle()
                    }, label: {
                        Text("Select Image")
                    })
                    
                    selectImg?
                        .resizable()
                        .scaledToFit()
                    
                }
                .padding()
                .sheet(isPresented: $showImgPick, content: {
                    ImagePicker(image: self.$selectImg)
                })
                
                Spacer()
                
                if(self.isKosong) {
                    Text("Harap diisi semua").foregroundColor(.red)
                }
                
                Button (action: {
                    var tempImg: UIImage = self.selectImg.asUIImage()
                    var imageCompr: Data = tempImg.jpegData(compressionQuality: 0.5) ?? Data ()
                    
                    self.encodedImg = imageCompr.base64EncodedString()
                    
                    self.modelData.received = false
                    self.isKosong = false
                    if (self.nama_resto.isEmpty || self.rating.isEmpty || self.detail.isEmpty || self.latitude.isEmpty || self.longitude.isEmpty || self.fav.isEmpty || self.encodedImg.isEmpty) {
                        self.isKosong = true
                    }else{
                        self.isKosong = false
                        modelData.addResto(id: String(modelData.userData.id), nama_resto: self.nama_resto, img: self.encodedImg, rating: self.rating, detail: self.detail, latitude: self.latitude, longitude: self.longitude, favorite: self.fav)
                    }
                }){
                    Text("Add Resto")
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding(50)
                        .frame(width: .infinity, height: 50)
                        .background(.brown)
                        .cornerRadius(20)
                        .shadow(radius: 5)
                }
            }
            .padding()
            .navigationTitle("")
            .navigationBarTitleDisplayMode(.inline)
            
        }
    }
}


struct AddResto_Previews: PreviewProvider {
    static var previews: some View {
        AddResto()
            .environmentObject(ModelData())
    }
}
