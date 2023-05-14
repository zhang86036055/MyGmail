//
//  EmailBodyView.swift
//  MyGmail
//
//  Created by Shuai Zhang on 5/8/23.
//

import SwiftUI

struct EmailBodyView: View {
    let mail: InboxMails.Mail
    
    // Sizes
    let defaultIconFont = Font.custom( "default", size: 14)
    let defaultTextFont = Font.custom( "default", size: 14)
    let defaultIconColor = Color("gmailGray")
    var profilePictureFrameWidth = 40.0
    var defaultSpacing = 20.0
    
    // Static Strings
    let toMe = "to me"
    let replyText = "Reply"
    let forwardText = "Forward"
    // Icon 
    let returnIcon = "return"
    let ellipsisIcon = "ellipsis"
    let starIcon = "star"
    let reply = "return.left"
    let forward = "return.right"
    
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                titleSection
                Spacer().frame(height: defaultSpacing)
                senderSection
                Spacer().frame(height: defaultSpacing * 2)
                Text(mail.content)
                    .font(16)
                    .lineSpacing(8)
                    .opacity(0.6)
                Spacer().frame(height: 50)
                HStack {
                    Button(action: {
                        
                    }, label: {
                        RoundedRectangle(cornerRadius: 5)
                            .stroke()
                            .foregroundColor(.gray)
                            .opacity(0.5)
                            .frame(width: 168, height: 32)
                            .overlay(  
                                HStack {
                                    Image(systemName: reply)
                                    Text(replyText)
                                }
                                    .font(defaultIconFont)
                                    .fontWeight(.bold)
                                    .foregroundColor(defaultIconColor)
                            ) .fontWeight(.bold)
                        
                    })
                    Spacer()
                    
                    Button(action: {
                        
                    }, label: {
                        RoundedRectangle(cornerRadius: 5)
                            .stroke()
                            .foregroundColor(.gray)
                            .opacity(0.5)
                            .frame(width: 168, height: 32)
                            .overlay(
                                HStack {
                                    Image(systemName: forward)
                                    Text(forwardText)
                                }
                                    .font(defaultIconFont)
                                    .foregroundColor(defaultIconColor)
                            ).fontWeight(.bold)
                        
                    })
                }.padding(.horizontal, 10)
            }
        }
        .scrollIndicators(.hidden)
        .padding()
    }
}
extension EmailBodyView {

    private var senderSection: some View {
        HStack {
            profilePictureThumbnail(with: mail)
            VStack(alignment: .leading) {
                HStack(alignment: .center) {
                    Text("\(mail.sender)").font(defaultTextFont)
                    Text("\(mail.time)").font(defaultTextFont)
                }
                HStack() {
                    Text(toMe)
                    Spacer().frame(width: 4)
                    Image(systemName: "chevron.down").resizable().frame(width: 8, height: 5)
                }.font(.caption2)
            }
            Spacer()
            Button(action: {} ,label: {Image(systemName: returnIcon)})
                .font(defaultIconFont)
            Spacer().frame(width: defaultSpacing)
            Button(action: {} ,label: {Image(systemName: ellipsisIcon)})
                .font(defaultIconFont)

        }.foregroundColor(defaultIconColor)
    }
    
    private var titleSection: some View {
        HStack() {
            HStack(alignment: .center) {
                Text(mail.subject)
                    .font(.title2)
                    .lineLimit(1)
                RoundedRectangle(cornerRadius: 2)
                    .foregroundColor(.gray.opacity(0.3))
                    .frame(width: 36, height: 16)
                    .overlay(  
                        Text("Inbox")
                        .font(12)
                    )
            }
            Spacer()
            Button(action: {} ,label: {Image(systemName: starIcon)})
                .font(defaultIconFont)
                .foregroundColor(defaultIconColor)
        }.opacity(0.7)
    }
    
    @ViewBuilder func profilePictureThumbnail(with mail: InboxMails.Mail?)  -> some View {
        if let profilePictureName = mail?.profilePicture  {
            Image(profilePictureName)
                .resizable()
                .scaledToFill()
                .cornerRadius(profilePictureFrameWidth)
                .frame(width: profilePictureFrameWidth, height: profilePictureFrameWidth)
                .cornerRadius(profilePictureFrameWidth)
                .frame(width: profilePictureFrameWidth)
        } else {
            let placeHolder = String(mail?.sender.first ?? Character(""))
            Circle()
                .fill(mail?.defaultColor ?? .white)
                .frame(width: profilePictureFrameWidth, height: profilePictureFrameWidth)
                .overlay() {
                    Text("\(placeHolder)").font(24).foregroundColor(.white)
                }.frame(width: profilePictureFrameWidth)
        }
    }
    
}

extension Text {
    func font(_ width: CGFloat) -> Text {
        return self.font(.custom( "default", size: width))
    }
}

struct EmailBodyView_Previews: PreviewProvider {
    static var previews: some View {
        EmailBodyView(mail: InboxMailsViewModel().mails[0])
    }
}
