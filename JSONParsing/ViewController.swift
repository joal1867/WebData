//
//  ViewController.swift
//  JSONParsing
//
//  Created by Joal on 19/11/2018.
//  Copyright © 2018 Joal. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    //디자인 테이블뷰 1개와 변수연결
    @IBOutlet weak var tableView: UITableView!
    

    //파싱할 결과를 저장할 2개의 문자열 배열변수를 인스턴스 변수로 선언
    //저자명과 책의 제목을 저장할 2개의 배열 생성
    var authors : [String] = [String]()
    var titles : [String] = [String]()
    
    
    //앱이 시작할 때 호출되는 메소드
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //web에서 데이터를 다운로드 받아 JSON Parsing을 수행
        //데이터를 다운로드 받을 URL을 생성
        let url = URL(string:"https://apis.daum.net/search/book?apikey=465b06fae32febacbc59502598dd7685&q=java&output=json")
        //웹의 데이터를 다운로드 (*예외처리하라는 에러메시지 발생)
        //예외 에러메시지 처리 방1) 예외를 처리하지 않을 경우
        let data = try! Data(contentsOf: url!)
        //예외 에러메시지 처리 방2)예외처리하는 코드
        //do{
        //    let data = Data(contentsOf: url!)
        //}catch{
        //}
        
        //다운로드 받은 데이터가 JSON형식이라면 파싱해서 디셔너리로 변환
        //처음 {"까지 걸러냅니다.
        let result = try! JSONSerialization.jsonObject(with: data, options: []) as! [String:Any]
        //주의! 파싱 직후 출력하면 디코딩이 안된채로 출력될 수 있습니다.
        //channel 키의 값을 디셔너리로 가져오기
        let channel = result["channel"] as! NSDictionary
        //item 키의 값을 배열로 가져오기
        let items = channel["item"] as! NSArray
        //가져온 배열을 반복문으로 순회하며 하나씩 읽기
        for index in 0...(items.count-1){
            //데이터 가져오기
            let item = items[index] as! NSDictionary
            authors.append(item["author"] as! String)
            titles.append(item["title"] as! String)
        }
        //출력해서 파싱이 잘 되었는지 확인
        print(authors)
        print(titles)

        
        //파싱결과를 테이블 뷰에 출력
        //tableView의 UITableViewDataSource 프로토콜을 conform한 인스턴스를 dataSource에 속성에 지정
        tableView.dataSource = self
    }
}


//파싱결과를 테이블 뷰에 출력
//extension - 기능확장
extension ViewController : UITableViewDataSource{
    //섹션별(그룹 별) 행의 개수를 설정하는 메소드
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return titles.count
    }
    //행에 셀을 만들어주는 메소드생성
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //셀 만들기
        let cell = UITableViewCell(style: .default, reuseIdentifier: "cell")
        //셀에 내용을 출력
        cell.textLabel?.text = "\(authors[indexPath.row])-\(titles[indexPath.row])"
        return cell
    }
}
