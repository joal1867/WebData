//
//  ViewController.swift
//  WebData
//
//  Created by Joal on 19/11/2018.
//  Copyright © 2018 Joal. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    //디자인 이미지 뷰 1개와 변수 연결
    @IBOutlet weak var webImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //*웹에서 데이터(문자열,이미지..)를 다운로드 받아오는 코드의 처음패턴은 같습니다.
        //다운로드 받을 주소 입력 -> 데이터 가져오기 -> 데이터 저장
        
        //웹에서 문자열 다운받기
        //문자열을 가져올 URL주소 입력
        let url = URL(string: "https://www.daum.net")
        //데이터 가져오기
        let data = try! Data(contentsOf: url!)
        //콘솔에 출력
        //print(data)
        //데이터 저장 *형변환 해야한다.
        let daumString = NSString(data: data, encoding: String.Encoding.utf8.rawValue)
        //출력
        print(daumString!)
        
        
        //파일 매니저 객체를 생성
        let fm = FileManager.default
        //도큐먼트 디렉토리의 경로를 생성
        let dirPaths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
        let docDir = dirPaths[0]
        //파일의 경로를 생성
        let filePath = docDir + "/toystory4.jpg"
        
        //파일이 없다면
        if fm.fileExists(atPath: filePath) == false{
            //웹에서 이미지 다운받기
            //이미지 파일의 내용을 다운로드 받을 URL주소 입력
            let imgAddr = "https://i.pinimg.com/originals/f3/61/9b/f3619bb1bf1bf7a077145515c494f143.jpg"
            //데이터 가져오기
            let imgUrl = URL(string: imgAddr)
            //데이터 저장
            let imgData = try! Data(contentsOf: imgUrl!)
            //다운로드 받은 데이터로 파일을 생성
            fm.createFile(atPath: filePath, contents: imgData, attributes: nil)
            print("다운로드")
        }
        let dataBuffer = fm.contents(atPath: filePath)
        //이미지 데이터로 변환
        let image = UIImage(data: dataBuffer!)
        //화면에 출력
        webImage.image = image
        
        
        
        
        
        
    }
    
    
}

