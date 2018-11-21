import UIKit

//데이터를 저장할 자료구조를 클래스로 생성 cf.tuple, struct(구조체), dictionary로도 데이터 저장가능
class Book{
    var id:String!
    var title:String!
    var author:String!
    var summary:String!
}

//XML ParserDelegate의 프로토콜을 conform
class RootTableViewController: UITableViewController, XMLParserDelegate {
    //파싱에 필요한 변수들을 클래스의 인스턴스 변수로 선언
    //태그 하나하나의 값을 저장할 변수
    var elementValue:String!
    //Book 1개를 저장할 변수
    var book : Book!
    //전체 데이터를 저장할 변수
    var books = [Book]()
    
    
    //앱이 실행될 때 수행되는 메소드
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //데이터를 다운로드 받아 파싱을 요청할 객체를 설정하고, 파싱이 종료되면 결과를 대화상자로 출력
        //데이터를 다운로드 받을 주소를 URL인스턴스로 생성
        let url = URL(string:"http://sites.google.com/site/iphonesdktutorials/xml/Books.xml")
        //데이터를 다운로드 받아서 파싱할 객체 만들기
        let xmlParser = XMLParser(contentsOf: url!)
        //파싱을 수행할 객체 지정
        xmlParser!.delegate = self
        //파싱을 요청하고 결과 받기
        let success = xmlParser!.parse()
        if success == true{
            self.title = "파싱 성공"
        }else{
            self.title = "파싱 실패"
        }
    }
    
    
    //XML파싱을 수행할 메소드 (여기에서는 3개의 메소드 작성)
    // ㄴ 5개 또는 3개의 메소드를 작성(문서의 시작/끝, 태그의 시작/끝, 태그의 시작과 끝사이의 내용)
    //MARK: - XMLParser Delegate
    
    //여는 태그를 만났을 때 호출되는 메소드
    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String] = [:]){
        //태그 들 중에서 속성을 가진 태그가 있으면 그 속성을 찾아와서 저장
        if elementName == "Book"{
            book = Book()
            //Book 태그에 있는 id 속성의 값을 찾아서 book에 저장
            var dic = attributeDict as Dictionary
            book.id = dic["id"]
        }
    }
    
    //닫는 태그를 만났을 때 호출되는 메소드
    //하나의 객체를 닫는 태그를 만났을 경우 : 객체를 배열이나 리스트에 저장
    //객체 내의 태그를 만났을 경우 : 그 태그에 해당하는 프로퍼티에 데이터를 저장[
    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?){
        //하나의 객체를 닫는 태그를 만난 경우
        if elementName == "Book"{
            books.append(book)
        }else if elementName == "title"{
            book.title = elementValue
        }else if elementName == "author"{
            book.author = elementValue
        }else if elementName == "summary"{
            book.summary = elementValue
        }
        elementValue = nil
    }
    
    //여는 태그와 닫는 태그 사이의 내용을 만났을 때 호출되는 메소드 : 유일하게 동일한 데이터를 가지고 두번이상 호출될 수 있는 메소드
    //elementValue의 값이 nil이면 바로 저장, 그렇지 않으면 이전 데이터에 추가해야 합니다.
    //Why? 태그에 적는 내용은 하나의 패킷이하로 만들어지기 때문에 한번에 전송되지만,
    //여는 태그와 닫는 태그 사이에 작성하는 내용은 하나의 패킷이상이 될 수 있기 때문입니다.
    //*다른 네트워크 프로그램을 만들 때에도 이 부분은 공통적으로 주의해야 할 사항!
    func parser(_ parser: XMLParser, foundCharacters string: String){
        if elementValue == nil{
            elementValue = string
        }else{
            elementValue = "\(elementValue!)\(string)"
        }
    }
    
    
    //파싱결과를 테이블 뷰에 출력하는 메소드 : 섹션별 (그룹별) 행의 개수를 설정하는 메소드, 행에 셀을 만들어주는 메소드

    //섹션의 개수를 설정하는 메소드 : 삭제가능하며 추가할 경우, 1을 리턴하도록 합니다. (*이 메소드가 없다면, 1을 리턴하는 것으로 설정됩니다.)
    //(*Android에서도 동일하게 적용되는 원리)
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    //섹션별(그룹별) 행의 개수를 설정하는 메소드(required)
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return books.count
    }

    //행에 셀을 만들어주는 메소드(required)
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //셀 만들기
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)
        //셀에 내용을 출력
        cell.textLabel?.text = books[indexPath.row].title
        //cell.accessoryView를 이용하면 이미지를 넣을 수도 있습니다.
        return cell
    }
    
    //셀을 선택했을 때 호출되는 메소드 재정의
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        //하위 뷰 컨트롤러 출력 과정 
        //하위 뷰 컨트롤러 생성
        let detailViewController = self.storyboard?.instantiateViewController(withIdentifier: "DetailViewController") as! DetailViewController
        //데이터 넘기기
        detailViewController.book = books[indexPath.row]
        //데이터 출력
        self.navigationController?.pushViewController(detailViewController, animated: true)
    }
}
