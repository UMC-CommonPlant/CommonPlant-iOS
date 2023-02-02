//
//  CalendarViewController.swift
//  CommonPlant_iOS
//
//  Created by hweyoung on 2023/02/02.
//

import UIKit
import FSCalendar

class CalendarViewController: UIViewController, FSCalendarDelegate, FSCalendarDataSource, FSCalendarDelegateAppearance {

    @IBOutlet weak var calendarView: FSCalendar!

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setCalendarUI()
        
        calendarView.appearance.eventDefaultColor = UIColor.green
        calendarView.appearance.eventSelectionColor = UIColor.blue
        // Do any additional setup after loading the view.
    }
    func setCalendarUI(){
        calendarView.delegate = self
        calendarView.dataSource = self

        self.calendarView.calendarWeekdayView.weekdayLabels[0].text = "일"
        self.calendarView.calendarWeekdayView.weekdayLabels[1].text = "월"
        self.calendarView.calendarWeekdayView.weekdayLabels[2].text = "화"
        self.calendarView.calendarWeekdayView.weekdayLabels[3].text = "수"
        self.calendarView.calendarWeekdayView.weekdayLabels[4].text = "목"
        self.calendarView.calendarWeekdayView.weekdayLabels[5].text = "금"
        self.calendarView.calendarWeekdayView.weekdayLabels[6].text = "토"
        
//        // 월~일 글자 폰트 및 사이즈 지정
//        self.calendarView.appearance.weekdayFont = UIFont.SpoqaHanSans(type: .Regular, size: 14)
        self.calendarView.appearance.headerTitleFont = UIFont.systemFont(ofSize: 14)

//        // 숫자들 글자 폰트 및 사이즈 지정
//        self.calendarView.appearance.titleFont = UIFont.SpoqaHanSans(type: .Regular, size: 16)
        self.calendarView.appearance.headerTitleFont = UIFont.systemFont(ofSize: 16)




        // 캘린더 스크롤 가능하게 지정
        self.calendarView.scrollEnabled = true
        // 캘린더 스크롤 방향 지정
        self.calendarView.scrollDirection = .horizontal

        // Header dateFormat, 년도, 월 폰트(사이즈)와 색, 가운데 정렬
        self.calendarView.appearance.headerDateFormat = "YYYY년 MM월"
//        self.calendarView.appearance.headerTitleFont = UIFont.SpoqaHanSans(type: .Bold, size: 20)
        self.calendarView.appearance.headerTitleFont = UIFont.systemFont(ofSize: 20)
        self.calendarView.appearance.headerTitleColor = UIColor(named: "FFFFFF")?.withAlphaComponent(0.9)
        self.calendarView.appearance.headerTitleAlignment = .center


        // 요일 글자 색
        self.calendarView.appearance.weekdayTextColor = UIColor(named: "F5F5F5")?.withAlphaComponent(0.2)

        // 캘린더 높이 지정
        self.calendarView.headerHeight = 68
        // 캘린더의 cornerRadius 지정
        self.calendarView.layer.cornerRadius = 10

        // 양옆 년도, 월 지우기
        self.calendarView.appearance.headerMinimumDissolvedAlpha = 0.0

        // 달에 유효하지 않은 날짜의 색 지정
        self.calendarView.appearance.titlePlaceholderColor = UIColor.white.withAlphaComponent(0.2)
//        // 평일 날짜 색
//        self.calendarView.appearance.titleDefaultColor = UIColor.white.withAlphaComponent(0.5)
        // 달에 유효하지않은 날짜 지우기
        self.calendarView.placeholderType = .none
//
        // 캘린더 숫자와 subtitle간의 간격 조정
        self.calendarView.appearance.subtitleOffset = CGPoint(x: 0, y: 4)
        
    }
    
    func monthCalendar(){
        calendarView.scope = .month
        
        

    }
    
    // 원하는 날짜 아래에 subtitle 지정
       // 오늘 날짜에 오늘이라는 글자를 추가해보았다
//       func calendar(_ calendar: FSCalendar, subtitleFor date: Date) -> String? {
//           return "오늘"
////           switch dateFormatter.string(from: date) {
////           case dateFormatter.string(from: Date()):
////               return "오늘"
////           default:
////               return nil
////           }
//       }
    
    //이벤트 개수 최대 3개
    func calendar(_ calendar: FSCalendar, numberOfEventsFor date: Date) -> Int {
            return 5
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
