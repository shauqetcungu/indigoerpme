//
//  OnboardingController.swift
//  Indigo
//
//  Created by Saša Vujanovic on 14/03/2019.
//  Copyright © 2019 Shauqet Cungu. All rights reserved.
//

import Foundation
import Charts

func createSlides() -> [Silde] {
    
    let slide1:Silde = Bundle.main.loadNibNamed("Slide", owner:RUSAGE_SELF, options: nil)?.first as! Silde
    slide1.nameLbl.text = "ODNOS LOŠEG DUGA"
    
    let slide2:Silde = Bundle.main.loadNibNamed("Slide", owner: RUSAGE_SELF, options: nil)?.first as! Silde
    slide2.nameLbl.text = "TOP 10 KUPACA"
    let barChartView = HorizontalBarChartView(frame: CGRect(x: 0, y: 0, width: slide2.frame.width, height: slide2.frame.height))
    //barChartView.center = CGPoint(x: slide2.frame.width/2, y: slide2.frame.height/2)
    let months =  ["Digitalni marketing", "Softveri", "Dizajn", "Outsourcing"]
    let unitsSold = [39721.79,15340.42,4053.49,4295.5]
    let colors1 = [UIColor(hexString:"dd3232"),UIColor(hexString:"ed9d10"),UIColor(hexString:"7caf45"),UIColor(hexString:"00aac6")]
    func setBarChart(months: [String], values: [Double]) {
        barChartView.noDataText = "You need to provide data for the chart."
        var dataEntries: [BarChartDataEntry] = []
        
        for i in 0..<months.count {
            let dataEntry = BarChartDataEntry(x: Double(i), y: values[i])
            dataEntries.append(dataEntry)
            
        }
        
        let chartDataSet = BarChartDataSet(values: dataEntries, label: "Units Sold")
        let chartData = BarChartData(dataSet: chartDataSet)
        
        barChartView.data = chartData
    }
    var legenda: [LegendEntry] = []
    for i in 0..<months.count {
        let legendaentry = LegendEntry(label: months[i], form: .circle, formSize: 10, formLineWidth: 0, formLineDashPhase: 0, formLineDashLengths:[CGFloat(0)], formColor: colors1[i])
        legenda.append(legendaentry)
    }
    barChartView.legend.setCustom(entries: legenda)
    barChartView.xAxis.labelPosition = .bottom
    barChartView.notifyDataSetChanged()
    setBarChart(months: months, values: unitsSold)
    //slide2.addSubview(barChartView)
    let slide3:Silde = Bundle.main.loadNibNamed("Slide", owner: RUSAGE_SELF, options: nil)?.first as! Silde
    slide3.nameLbl.text = "TOP 10 DOBAVLJAČA"
    
    let slide4:Silde = Bundle.main.loadNibNamed("Slide", owner: RUSAGE_SELF, options: nil)?.first as! Silde
    slide4.nameLbl.text = "TARGETI, PRIHODI"
    
    let slide5:Silde = Bundle.main.loadNibNamed("Slide", owner: RUSAGE_SELF, options: nil)?.first as! Silde
    slide5.nameLbl.text = "TARGETI, RASHODI"
    
    let slide6:Silde = Bundle.main.loadNibNamed("Slide", owner: RUSAGE_SELF, options: nil)?.first as! Silde
    slide6.nameLbl.text = "PROFITABILNOST"
    
    let slide7:Silde = Bundle.main.loadNibNamed("Slide", owner: RUSAGE_SELF, options: nil)?.first as! Silde
    slide7.nameLbl.text = "VRIJEDNOST IZLAZNIH FAKTURA"
    let pieChartView = PieChartView(frame: CGRect(x: 0, y: 0, width: slide7.frame.width-50, height: slide7.frame.height))
    pieChartView.center = CGPoint(x: slide7.frame.width/2, y: slide7.frame.height/2)
    pieChartView.setExtraOffsets(left: 0, top: -200, right: 0, bottom: 200)
    var legendLabels: [LegendEntry] = []
    let linijeBiznisa = ["Digitalni marketing", "Softveri", "Dizajn", "Outsourcing"]
    let values = [39721.79,15340.42,4053.49,4295.5]
    let colors = [UIColor(hexString:"dd3232"),UIColor(hexString:"ed9d10"),UIColor(hexString:"7caf45"),UIColor(hexString:"00aac6")]
    for i in 0..<linijeBiznisa.count {
        let legendEntry = LegendEntry(label: linijeBiznisa[i], form: .circle, formSize: 10, formLineWidth: 0, formLineDashPhase: 0, formLineDashLengths:[CGFloat(0)], formColor: colors[i])
        legendLabels.append(legendEntry)
    }
    
    pieChartView.legend.setCustom(entries: legendLabels)
    pieChartView.legend.textColor = UIColor.white
    
    pieChartView.animate(yAxisDuration: 2)
    pieChartView.centerText = "UKUPNO"
    pieChartView.legend.orientation = .vertical
    pieChartView.notifyDataSetChanged()
    func setChart(dataPoints: [String], values: [Double], colors: [UIColor]) {
        var dataEntries: [ChartDataEntry] = []
        for i in 0..<dataPoints.count {
            let dataEntry = PieChartDataEntry(value: values[i])
            dataEntries.append(dataEntry)
        }
        let pieChartDataSet = PieChartDataSet(values: dataEntries, label: "")
        let pieChartData = PieChartData(dataSet: pieChartDataSet)
        pieChartView.data = pieChartData
        pieChartDataSet.colors = colors
        
    }
    setChart(dataPoints: linijeBiznisa, values: values, colors:colors)
    slide7.addSubview(pieChartView)
    
    let slide8:Silde = Bundle.main.loadNibNamed("Slide", owner: RUSAGE_SELF, options: nil)?.first as! Silde
    slide8.nameLbl.text = "BROJ IZLAZNIH FAKTURA"
    
    let slide9:Silde = Bundle.main.loadNibNamed("Slide", owner: RUSAGE_SELF, options: nil)?.first as! Silde
    slide9.nameLbl.text = "NEPLAĆENE IZLAZNE FAKTURE"
    
    return [slide1, slide2, slide3, slide4, slide5, slide6, slide7, slide8, slide9]
}
