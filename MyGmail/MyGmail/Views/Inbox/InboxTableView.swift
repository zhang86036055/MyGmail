/* * Copyright 2023 Simon Zhang. All rights reserved. */

import SwiftUI

struct InboxTableView: View {
    // MARK: Static values

    private let composeButtonOffsetX = 320.0
    private let composeButtonOffsetY = 640.0

    @EnvironmentObject private var slideInMenuService: SlideInMenuService
    @EnvironmentObject private var filterService: FilterService

    @EnvironmentObject var viewModel: InboxMailsViewModel
    @State var searchString = ""

    private var searchResults: [InboxMailsViewModel.Mail] {
        let filtedMails = viewModel.mails.filter(filterService.currentFilter)
        guard !searchString.isEmpty else {
            return filtedMails
        }
        return filtedMails.filter { $0.sender.contains(searchString) }
    }

    var body: some View {
        NavigationView {
            ZStack {
                List {
                    ForEach(searchResults) { mail in
                        createInboxMailCell(for: mail)
                            .swipeActions(edge: .trailing, allowsFullSwipe: false) {
                                Button(
                                    action: {
                                        withAnimation(.easeInOut) {
                                            viewModel.archive(mail)
                                            viewModel.read(mail)
                                        }
                                    }, label: { GmailIcons.swipeDownIcon })
                                    .tint(.green)
                            }
                    }
                }
                .listStyle(.inset)

                // MARK: swipping gesture for side bar menu

                .gesture(
                    swipeToDisplayMenu()
                )
                .searchable(
                    text: $searchString,
                    prompt: GmailStrings.searchbarPlaceHolder)

                composeButton()
            }
        }
    }
}

extension InboxTableView {
    @ViewBuilder
    func composeButton() -> some View {
        CustomNavigationLink(destination: NewEmailView()) {
            Capsule()
                .foregroundColor(.white)
                .shadow(radius: 4, x: 3, y: 3)
                .frame(width: GmailSize.defaultSingle * 15, height: GmailSize.defaultSingle * 5)
                .overlay(alignment: .center) {
                    HStack {
                        GmailIcons.composeButtonIcon
                            .resizable()
                            .scaledToFit()
                            .frame(
                                width: GmailSize.defaultDouble,
                                height: GmailSize.defaultTripple)

                        Text(GmailStrings.composeButton).bold()
                    }
                    .foregroundColor(GmailColor.red)
                    .font(.caption)
                }
        }
        .position(
            x: composeButtonOffsetX,
            y: composeButtonOffsetY)
    }

    // MARK: Inbox Mail Cell

    @ViewBuilder
    func createInboxMailCell(for cell: InboxMailsViewModel.Mail) -> some View {
        ZStack {
            // Hide chevron visibility
            CustomNavigationLink(
                destination: ReadEmailView(mail: cell, viewModel: viewModel),
                label: { EmptyView() })
                .opacity(0.0)

            InboxTableItemView(
                mail: cell,
                starOnTapped: { viewModel.star(cell) },
                chevronOnTapped: { viewModel.important(cell) })
                .frame(height: 50)
        }
    }

    private func swipeToDisplayMenu() -> _EndedGesture<DragGesture> {
        DragGesture(
            minimumDistance: 20,
            coordinateSpace: .global)
            .onEnded { value in
                let horizontalAmount = value.translation.width as CGFloat
                let verticalAmount = value.translation.height as CGFloat

                if abs(horizontalAmount) > abs(verticalAmount), horizontalAmount > 0 {
                    slideInMenuService.isPresented.toggle()
                }
            }
    }
}

struct InboxTableView_Previews: PreviewProvider {
    static var previews: some View {
        InboxTableView()
    }
}
