//
//  HKWorkoutConfiguration+Symbol.swift
//  Planner
//
//  Created by Zied Mcharek on 10.01.24.
//

import HealthKit

/*
extension HKWorkoutActivityType: CaseIterable {
    public static var allCases: [HKWorkoutActivityType] {
        return [.americanFootball, .archery]
    }
}*/

extension HKWorkoutActivityType {

    var symbol: String {
        switch self {
        case .americanFootball:
            return "figure.american.football"
        case .archery:
            return "figure.archery"
        case .australianFootball:
            return "figure.australian.football"
        case .badminton:
            return "figure.badminton"
        case .baseball:
            return "figure.baseball"
        case .basketball:
            return "figure.basketball"
        case .bowling:
            return "figure.bowling"
        case .boxing:
            return "figure.boxing"
        case .climbing:
            return "figure.climbing"
        case .cricket:
            return "figure.cricket"
        case .crossTraining:
            return "figure.cross.training"
        case .curling:
            return "figure.curling"
        case .cycling:
            return "figure.indoor.cycle"
        case .elliptical:
            return "figure.elliptical"
        case .equestrianSports:
            return "figure.equestrian.sports"
        case .fencing:
            return "figure.fencing"
        case .fishing:
            return "figure.fishing"
        case .functionalStrengthTraining:
            return "figure.strengthtraining.functional"
        case .golf:
            return "figure.golf"
        case .gymnastics:
            return "figure.gymnastics"
        case .handball:
            return "figure.handball"
        case .hiking:
            return "figure.hiking"
        case .hockey:
            return "figure.hockey"
        case .hunting:
            return "figure.hunting"
        case .lacrosse:
            return "figure.lacrosse"
        case .martialArts:
            return "figure.martial.arts"
        case .mindAndBody:
            return "figure.mind.and.body"
        case .mixedMetabolicCardioTraining:
            return ""
        case .paddleSports:
            return ""
        case .play:
            return "figure.play"
        case .preparationAndRecovery:
            return "figure.cooldown"
        case .racquetball:
            return "figure.racquetball"
        case .rowing:
            return "figure.rower"
        case .rugby:
            return "figure.rugby"
        case .running:
            return "figure.run"
        case .sailing:
            return "figure.sailing"
        case .skatingSports:
            return "figure.skating"
        case .snowSports:
            return "figure.snowboarding"
        case .soccer:
            return "figure.soccer"
        case .softball:
            return "figure.softball"
        case .squash:
            return "figure.squash"
        case .stairClimbing:
            return "figure.stairs"
        case .surfingSports:
            return "figure.surfing"
        case .swimming:
            return "figure.pool.swim"
        case .tableTennis:
            return "figure.table.tennis"
        case .tennis:
            return "figure.tennis"
        case .trackAndField:
            return "figure.track.and.field"
        case .traditionalStrengthTraining:
            return "figure.strengthtraining.traditional"
        case .volleyball:
            return "figure.volleyball"
        case .walking:
            return "figure.walk"
        case .waterFitness:
            return "figure.water.fitness"
        case .waterPolo:
            return "figure.waterpolo"
        case .waterSports:
            return ""
        case .wrestling:
            return "figure.wrestling"
        case .yoga:
            return "figure.yoga"
        case .barre:
            return "figure.barre"
        case .coreTraining:
            return "figure.core.training"
        case .crossCountrySkiing:
            return "figure.skiing.crosscountry"
        case .downhillSkiing:
            return "figure.skiing.downhill"
        case .flexibility:
            return "figure.flexibility"
        case .highIntensityIntervalTraining:
            return "figure.highintensity.intervaltraining"
        case .jumpRope:
            return "figure.jumprope"
        case .kickboxing:
            return "figure.kickboxing"
        case .pilates:
            return "figure.pilates"
        case .snowboarding:
            return "figure.snowboarding"
        case .stairs:
            return "figure.stairs"
        case .stepTraining:
            return "figure.step.training"
        case .wheelchairWalkPace:
            return "Wheelchair Roll"
        case .wheelchairRunPace:
            return "Wheelchair Roll"
        case .taiChi:
            return "figure.taichi"
        case .mixedCardio:
            return "Mixed Cardio"
        case .handCycling:
            return "figure.hand.cycling"
        case .discSports:
            return "figure.disc.sports"
        case .fitnessGaming:
            return "Fitness Gaming"
        case .cardioDance:
            return "Cardio Dance"
        case .socialDance:
            return "figure.socialdance"
        case .pickleball:
            return "Pickleball"
        case .cooldown:
            return "Cooldown"
        case .swimBikeRun:
            return "Swim-Bike-Run"
        case .transition:
            return "Transition"
        case .underwaterDiving:
            return "Underwater Diving"
        case .other:
            return "Other"
        case .dance:
            return ""
        case .danceInspiredTraining:
            return ""
        @unknown default:
            return "Other"
        }
    }
}
