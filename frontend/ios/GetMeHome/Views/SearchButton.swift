//
//  SearchButton.swift
//  GetMeHome
//
//  Created by Ronald Jabouin on 1/8/24.
//

import SwiftUI

struct SearchButton: View {
    
    @Binding var trips: [Trip]?
    @Binding var discountCodes: [Discount]?
    
    @Binding var selectedDate: Date
    @Binding var earliestDepartureTime: Date?
    @Binding var latestArrivalTime: Date?
    
    @Binding var selectedService: String
    @Binding var selectedDeparture: String
    @Binding var selectedArrival: String

    @Binding var selectServiceToggle: Bool
    @Binding var earliestDepartureTimeToggle: Bool
    @Binding var isLoading: Bool
    @Binding var removeTransfersToggle: Bool
    @Binding var latestArrivalTimeToggle: Bool
    @Binding var clickedSearch: Bool
    
    var viewModel = ViewModel()

    var body: some View {
        Button {
            //           Converting Date From:  2023-11-24 21:51:35 +0000
            //           To: 11-24-2023
            let formatter = DateFormatter()
            formatter.dateFormat = "MM-dd-yyyy"
            let newDateString = formatter.string(from: selectedDate)
            
            Task {
                isLoading = true
                do {
                    
                    if !selectServiceToggle {
                        selectedService = "All"
                    }
                    
                    (trips, discountCodes) = try await viewModel.getTripsAndDiscounts(
                        from: viewModel.locationQueryMap[selectedDeparture] ?? "new_york",
                        to: viewModel.locationQueryMap[selectedArrival] ?? "ithaca",
                        on: newDateString,
                        bus: viewModel.convertForQuery(value: selectedService))
                    
                    if earliestDepartureTimeToggle {
                        trips = viewModel.filterMinDepartureTime(tripsArray: trips ?? [], minTime: earliestDepartureTime!)
                    }
                    
                    if latestArrivalTimeToggle {
                        trips = viewModel.filterLatestArrivalTime(tripsArray: trips ?? [], latestArrival: latestArrivalTime!)
                    }
                    
                    if removeTransfersToggle {
                        trips = viewModel.filterTransfer(tripsArray: trips ?? [], includeTransfers: false)
                    }
                    
                    isLoading = false
                    clickedSearch = true
                } catch TripError.invalidURL {
                    print("invalid url")
                    isLoading = false
                } catch TripError.invalidReponse {
                    print("invalid response")
                    isLoading = false
                } catch TripError.invalidData {
                    print("invalid data")
                    isLoading = false
                } catch {
                    print("unexpected erorr")
                    isLoading = false
                }
            }
        } label: {
            Text("Search")
                .frame(maxWidth: .infinity)
        }
        .buttonStyle(.bordered)
        .padding(.horizontal)
        .tint(.indigo)
        .disabled(selectedDeparture == selectedArrival || selectedService == "" || isLoading)
    }
}
