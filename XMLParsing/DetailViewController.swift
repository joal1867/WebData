
import UIKit

class DetailViewController: UIViewController {
    //하위 데이터를 출력하기 위한 디자인 레이블2개와 텍스트뷰1개 변수 연결
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblAuthor: UILabel!
    @IBOutlet weak var txtSummary: UITextView!
    
    //데이터를 넘겨받을 변수를 인스턴스 변수로 선언
    var book : Book!
    
    //앱이 실행될 때 수행되는 메소드
    override func viewDidLoad() {
        super.viewDidLoad()

        //넘겨받은 데이터를 레이블에 출력 
        lblTitle.text = book.title
        lblAuthor.text = book.author
        txtSummary.text = book.summary
        self.title = book.title
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
