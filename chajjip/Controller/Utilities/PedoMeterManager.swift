//
//  PedoMeterManager.swift
//  chajjip
//
//  Created by JunHwan Kim on 2022/05/09.
//

import Foundation
import HealthKit

class PedoMeterManager{
    let healthStore = HKHealthStore()
    
    let read = Set([HKObjectType.quantityType(forIdentifier: .stepCount)!, HKQuantityType.quantityType(forIdentifier: .distanceWalkingRunning)!])
    let share = Set([HKObjectType.quantityType(forIdentifier: .stepCount)!, HKQuantityType.quantityType(forIdentifier: .distanceWalkingRunning)!])
    
    func requestAuthorization(){
        self.healthStore.requestAuthorization(toShare: share, read: read) { success, error in
            if error != nil{
                print(error.debugDescription)
            }else{
                if success{
                    print("access HealthStore")
                }else{
                    print("not access HealthStore")
                }
            }
        }
    }
    
    //MARK: - get step count
    func getStepCount(completion : @escaping (Double) -> Void){
        guard let stepQuantityType = HKQuantityType.quantityType(forIdentifier: .stepCount) else {return}
        let now = Date()
        let startDate = Calendar.current.startOfDay(for: now)
        let predicate = HKQuery.predicateForSamples(withStart: startDate, end: now, options: .strictStartDate)
        let query = HKStatisticsQuery(quantityType: stepQuantityType, quantitySamplePredicate: predicate, options: .cumulativeSum) { _, result, error in
            guard let result = result, let sum = result.sumQuantity() else{
                print("Fail")
                return
            }
            DispatchQueue.main.async {
                completion(sum.doubleValue(for: HKUnit.count()))
            }
        }
        healthStore.execute(query)
    }
    //MARK: - get walkingRunning Distance
    func getDistanceWalkingRunning(completion : @escaping (Double) -> Void){
        guard let distanceWalkingRunningType = HKSampleType.quantityType(forIdentifier: .distanceWalkingRunning) else {return}
        let now = Date()
        let startDate = Calendar.current.startOfDay(for: now)
        let predicate = HKQuery.predicateForSamples(withStart: startDate, end: now, options: .strictStartDate)
        let query = HKStatisticsQuery(quantityType: distanceWalkingRunningType, quantitySamplePredicate: predicate, options: .cumulativeSum) { _, result, error in
            var distance = 0.0
            guard let result = result, let sum = result.sumQuantity() else{
                print("Fail")
                return
            }
            distance = sum.doubleValue(for: HKUnit.mile())
            DispatchQueue.main.async {
                completion(self.convertMileToKM(mile: distance))
            }
        }
        healthStore.execute(query)
    }
    
    private func convertMileToKM(mile : Double)->Double{
        return mile * 1.609344
    }
}
