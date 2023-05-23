//
//  ComposeMailView.swift
//  MyGmail
//
//  Created by Shuai Zhang on 5/13/23.
//

import SwiftUI
import AVKit

struct ComposeMailView: View {
    
    @Environment(\.colorScheme) var colorScheme
    @StateObject var vm = ViewModel(api: ChatGPTAPI(apiKey: "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"))
    @FocusState var isTextFieldFocused: Bool
    let composeContent = ComposeMailInfo(sender: "You", receiver: "Susan", content: "How are you doing?")
    
    var body: some View {
        VStack {
            Text(composeContent.sender)
            Text(composeContent.receiver)
            Text(composeContent.content)
            chatListView
                .navigationTitle("XCA ChatGPT")
        }
    }
    
    var chatListView: some View {
        ScrollViewReader { proxy in
            VStack(spacing: 0) {
                ScrollView {
                    LazyVStack(spacing: 0) {
                        ForEach(vm.messages) { message in
                            MessageRowView(message: message) { message in
                                Task { @MainActor in
                                    await vm.retry(message: message)
                                }
                            }
                        }
                    }
                    .onTapGesture {
                        isTextFieldFocused = false
                    }
                }
                #if os(iOS) || os(macOS)
                Divider()
                bottomView(image: "profile", proxy: proxy)
                Spacer()
                #endif
            }
            .onChange(of: vm.messages.last?.responseText) { _ in  scrollToBottom(proxy: proxy)
            }
        }
        .background(colorScheme == .light ? .white : Color(red: 52/255, green: 53/255, blue: 65/255, opacity: 0.5))
    }
    
    func bottomView(image: String, proxy: ScrollViewProxy) -> some View {
        HStack(alignment: .top, spacing: 8) {
            if image.hasPrefix("http"), let url = URL(string: image) {
                AsyncImage(url: url) { image in
                    image
                        .resizable()
                        .frame(width: 30, height: 30)
                } placeholder: {
                    ProgressView()
                }

            } else {
                Image(image)
                    .resizable()
                    .frame(width: 30, height: 30)
            }
            
            TextField("Send message", text: $vm.inputMessage, axis: .vertical)
                #if os(iOS) || os(macOS)
                .textFieldStyle(.roundedBorder)
                #endif
                .focused($isTextFieldFocused)
                .disabled(vm.isInteractingWithChatGPT)
            
            if vm.isInteractingWithChatGPT {
                #if os(iOS)
                Button {
                    vm.cancelStreamingResponse()
                } label: {
                    Image(systemName: "stop.circle.fill")
                        .font(.system(size: 30))
                        .symbolRenderingMode(.multicolor)
                        .foregroundColor(.red)
                }
                #else
                DotLoadingView().frame(width: 60, height: 30)
                #endif
            } else {
                Button {
                    Task { @MainActor in
                        isTextFieldFocused = false
                        scrollToBottom(proxy: proxy)
                        await vm.sendTapped()
                    }
                } label: {
                    Image(systemName: "paperplane.circle.fill")
                        .rotationEffect(.degrees(45))
                        .font(.system(size: 30))
                }
                #if os(macOS)
                .buttonStyle(.borderless)
                .keyboardShortcut(.defaultAction)
                .foregroundColor(.accentColor)
                #endif
                .disabled(vm.inputMessage.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty)
            }
        }
        .padding(.horizontal, 16)
        .padding(.top, 12)
    }
    
     func presetMessage() -> String {
        return "create a email which sender is \(composeContent.sender), receiver is \(composeContent.receiver), rewrite email content,\(composeContent.content) with below comments: \($vm.inputMessage)"
    }
    
    private func scrollToBottom(proxy: ScrollViewProxy) {
        guard let id = vm.messages.last?.id else { return }
        proxy.scrollTo(id, anchor: .bottomTrailing)
    }
}

struct ComposeMailInfo {
    var sender: String
    var receiver: String
    var content: String
}

struct ComposeMailView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            ContentView(vm: ViewModel(api: ChatGPTAPI(apiKey: "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")))
        }
    }
}
