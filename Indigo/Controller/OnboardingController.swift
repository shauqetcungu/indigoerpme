//
//  OnboardingController.swift
//  Indigo
//
//  Created by Saša Vujanovic on 14/03/2019.
//  Copyright © 2019 Shauqet Cungu. All rights reserved.
//

import Foundation
import Charts
import WMGaugeView

func createSlides() -> [Silde] {
    
    let slide1:Silde = Bundle.main.loadNibNamed("Slide", owner:RUSAGE_SELF, options: nil)?.first as! Silde
    slide1.nameLbl.text = "ODNOS LOŠEG DUGA"
    
    let myGauge = WMGaugeView(frame: CGRect(x: 0, y: 0, width: 300, height: 300))
    myGauge.center = CGPoint(x: slide1.frame.width/2, y: slide1.frame.height/2-50)
    myGauge.backgroundColor = UIColor.clear
    
    let gaugeLabel = UILabel(frame: CGRect(x: 0, y: myGauge.frame.height, width: 100, height: 40))
    gaugeLabel.center = CGPoint(x: slide1.frame.width/2, y: myGauge.frame.height)
    gaugeLabel.textColor = UIColor.white
    gaugeLabel.font = UIFont(name: "Helvetica Neue", size: 25)
    //gaugeLabel.textAlignment = .center
    gaugeLabel.text = "30%"
    
    myGauge.needleStyle = WMGaugeViewNeedleStyleFlatThin
    myGauge.needleWidth = 0.03
    myGauge.needleScrewRadius = 0
    
    
    
    myGauge.minValue = 0
    myGauge.maxValue = 100
    myGauge.rangeValues = [10, 20, 100]
    myGauge.rangeColors = [barGreen, barOrange, barRed]
    
    myGauge.rangeLabels = ["", "", ""]
    myGauge.rangeLabelsFontColor = UIColor.white
    myGauge.showRangeLabels = true
    myGauge.rangeLabelsWidth = 0.03
    
    myGauge.unitOfMeasurementFont = UIFont (name: "Helvetica Neue", size: 20)
    
    myGauge.showInnerBackground = false
    
    
    myGauge.scaleDivisions = 10; //broj velikih crtica
    myGauge.scaleSubdivisions = 1; // broj malih crtica, kad je 0 ne prikazuje uopste
    
    myGauge.scaleDivisionsWidth = 0.00;
    myGauge.scaleDivisionsLength = 0.02;
    
    myGauge.setValue( Float(30) , animated: true, duration: 4)
    
    myGauge.addSubview(gaugeLabel)
    slide1.addSubview(myGauge)
    
    
    
    
    let slide2:Silde = Bundle.main.loadNibNamed("Slide", owner: RUSAGE_SELF, options: nil)?.first as! Silde
    slide2.nameLbl.text = "TOP 10 KUPACA"
    let barChartView = HorizontalBarChartView(frame: CGRect(x: 0, y: 0, width: slide2.frame.width, height: slide2.frame.height-100))
    barChartView.center = CGPoint(x: slide2.frame.width/2, y: slide2.frame.height/2)
    
    let colors1 = [barOrange,barRed,barGreen]
    
    
    var months =  ["Vezuv d.o.o.", "Crnogorski Telekom A.D.", "KK Budućnost VOLI", "Ekološki pokret \"Ozon\"", "Vujačić company", "Ženski rukometni klub \"Budućnost\"", "Montecco inc d.o.o.", "Jugopetrol a.d.", "NVO Građanska alijansa", "Fudbalski savez Crne Gore"]
    
    func setBarChart(months: [String], ukupnaVrijednost: [Double], dugUvaluti: [Double], dugVanValute: [Double]) {
        barChartView.noDataText = "You need to provide data for the chart."
        var dataEntries: [BarChartDataEntry] = []
        
        for i in 0..<months.count {
            let dataEntry = BarChartDataEntry(x: Double(i), yValues:[dugUvaluti[i], dugVanValute[i], ukupnaVrijednost[i]-dugUvaluti[i]-dugVanValute[i]])
            dataEntries.append(dataEntry)
            
        }
        
        let chartDataSet = BarChartDataSet(values: dataEntries, label: "")
        let chartData = BarChartData(dataSet: chartDataSet)
        barChartView.xAxis.valueFormatter = IndexAxisValueFormatter(values: months)
        
        chartDataSet.colors = colors1
        barChartView.data = chartData
    }
    
    var top10KupacaLegend: [LegendEntry] = []
    
    let top10KupacaLegendNames = ["Ukupna vrijednost faktura", "Ukupna vrijednost duga u valuti", "Ukupna vrijednost duga van valute"]
    let top10KupacaLegendColors = [barGreen,barOrange,barRed]
    
    for i in 0..<top10KupacaLegendNames.count {
        let top10KupacaLegendEntry = LegendEntry(label: top10KupacaLegendNames[i], form: .circle, formSize: 10, formLineWidth: 0, formLineDashPhase: 0, formLineDashLengths:[CGFloat(0)], formColor: top10KupacaLegendColors[i])
        top10KupacaLegend.append(top10KupacaLegendEntry)
    }
    let ukupnaVrijednost = [10430.44,5687,4900.5,4840,3448.5,3085.5,2940.3,2246.97,1900.01,1633.5]
    let dugUvaluti = [2807.44,3569.5,0,0,0,0,0,0,0,0]
    let dugVanValute = [0,2117.5,1633.59,0, 1149.5,0,980.1,0,258,544.5]
    
    barChartView.legend.setCustom(entries: top10KupacaLegend)
    barChartView.xAxis.drawAxisLineEnabled = false
    barChartView.xAxis.drawGridLinesEnabled = false
    
    barChartView.leftAxis.enabled = false
    barChartView.rightAxis.enabled = false
    barChartView.drawBordersEnabled = false
    
    
    barChartView.drawBordersEnabled = false
    barChartView.minOffset = 0
    barChartView.xAxis.granularityEnabled = true
    barChartView.xAxis.granularity = 1
    barChartView.notifyDataSetChanged()
    
    
   
    
    setBarChart(months: months, ukupnaVrijednost: ukupnaVrijednost, dugUvaluti: dugUvaluti, dugVanValute: dugVanValute)
    slide2.addSubview(barChartView)
    
    
    
    let slide3:Silde = Bundle.main.loadNibNamed("Slide", owner: RUSAGE_SELF, options: nil)?.first as! Silde
    slide3.nameLbl.text = "TOP 10 DOBAVLJAČA"
    
    let slide4:Silde = Bundle.main.loadNibNamed("Slide", owner: RUSAGE_SELF, options: nil)?.first as! Silde
    slide4.nameLbl.text = "TARGETI, PRIHODI"
    
    let slide5:Silde = Bundle.main.loadNibNamed("Slide", owner: RUSAGE_SELF, options: nil)?.first as! Silde
    slide5.nameLbl.text = "TARGETI, RASHODI"
    
    let slide6:Silde = Bundle.main.loadNibNamed("Slide", owner: RUSAGE_SELF, options: nil)?.first as! Silde
    slide6.nameLbl.text = "PROFITABILNOST"
    
    let profitabilnostGauge = WMGaugeView(frame: CGRect(x: 0, y: 0, width: 300, height: 300))
    profitabilnostGauge.center = CGPoint(x: slide6.frame.width/2, y: slide6.frame.height/2-50)
    profitabilnostGauge.backgroundColor = UIColor.clear
    
    let profitabilnostGaugeLabel = UILabel(frame: CGRect(x: 0, y: myGauge.frame.height, width: 100, height: 40))
    profitabilnostGaugeLabel.center = CGPoint(x: slide1.frame.width/2, y: myGauge.frame.height)
    profitabilnostGaugeLabel.textColor = UIColor.white
    profitabilnostGaugeLabel.font = UIFont(name: "Helvetica Neue", size: 25)
    profitabilnostGaugeLabel.text = "30%"
    
    profitabilnostGauge.needleStyle = WMGaugeViewNeedleStyleFlatThin
    profitabilnostGauge.needleWidth = 0.03
    profitabilnostGauge.needleScrewRadius = 0
    
    
    
    profitabilnostGauge.minValue = -100
    profitabilnostGauge.maxValue = 100
    profitabilnostGauge.rangeValues = [0, 100]
    profitabilnostGauge.rangeColors = [barRed, barGreen]
    
    profitabilnostGauge.rangeLabels = ["", ""]
    profitabilnostGauge.rangeLabelsFontColor = UIColor.white
    profitabilnostGauge.showRangeLabels = true
    profitabilnostGauge.rangeLabelsWidth = 0.03
    
    profitabilnostGauge.unitOfMeasurementFont = UIFont (name: "Helvetica Neue", size: 20)
    
    profitabilnostGauge.showInnerBackground = false
    
    
    profitabilnostGauge.scaleDivisions = 4; //broj velikih crtica
    profitabilnostGauge.scaleSubdivisions = 1; // broj malih crtica, kad je 0 ne prikazuje uopste
    
    profitabilnostGauge.scaleDivisionsWidth = 0.00;
    profitabilnostGauge.scaleDivisionsLength = 0.02;
    
    profitabilnostGauge.setValue( Float(30) , animated: true, duration: 4)
    
    profitabilnostGauge.addSubview(profitabilnostGaugeLabel)
    slide6.addSubview(profitabilnostGauge)
    
    
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
