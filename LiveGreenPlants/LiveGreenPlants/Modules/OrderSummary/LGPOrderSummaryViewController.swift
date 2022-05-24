//
//  LGPOrderSummaryViewController.swift
//  LiveGreenPlants
//
//  Created by Veeresh on 22/05/22.
//

import UIKit

class LGPOrderSummaryViewController: LGPViewController {

    var presenter:LGPOrderSummaryViewToPresenterProtocol?
    @IBOutlet weak var summaryInfoTableView : UITableView!
    @IBOutlet weak var placeOrderButton : UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver( self, selector: #selector(keyboardWillShowHere(notification:)), name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
        updateSubviews()

        // Do any additional setup after loading the view.
    }
    
    override func getNavigationTitleText() -> String{
        return "Order Summary"
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
    }
    
    private func updateSubviews(){
        presenter?.registerTableWithCell(tabelView: summaryInfoTableView)
        summaryInfoTableView.delegate = self
        summaryInfoTableView.dataSource = self
        placeOrderButton.titleLabel?.font = lgpHeaderFont
        placeOrderButton.setTitleColor(lgpButtonTextColour, for: .normal)
        placeOrderButton.setTitle("Place Order", for: .normal)
        presenter?.didUpdateSubViews()
    }
    
    private func updateViewButton(isEnable:Bool){
        placeOrderButton.backgroundColor = isEnable ?  lgpButtonColour : lgpButtonGrayColour
        placeOrderButton.isEnabled = isEnable
        
    }
    
    
    
    //MARK: - Handling keyboard notification
    @objc func keyboardWillShowHere( notification:NSNotification ) {
        // read the CGRect from the notification (if any)
        if let newFrame = (notification.userInfo?[ UIResponder.keyboardFrameEndUserInfoKey ] as? NSValue)?.cgRectValue {
            let insets = UIEdgeInsets( top: 0, left: 0, bottom: newFrame.height, right: 0 )
         self.summaryInfoTableView.contentInset = insets
            self.summaryInfoTableView.scrollIndicatorInsets = insets
        }
    }
    
    @IBAction func placeAnOrderClicked(_sender : Any) {
        presenter?.placeAnOrder()
    }
    


}

extension LGPOrderSummaryViewController: UITableViewDataSource,UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter?.numberOfRowsInSection() ?? 0
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = presenter?.getCell(tableView: tableView, forRowAt: indexPath)
        cell?.selectionStyle = .none
        return cell!
    }
    
}


extension LGPOrderSummaryViewController : LGPOrderSummaryPresenterToViewProtocol {
    func reloadSubviews() {
        self.summaryInfoTableView.reloadData()
    }
    
    
}


extension LGPOrderSummaryViewController : UITextViewDelegate {
    
    func textViewDidEndEditing(_ textView: UITextView) {
        presenter?.handleTextViewEndEditing(textView: textView, tableView: summaryInfoTableView)
    }
    
    func enablePlaceOrderButton(isEnable:Bool){
        updateViewButton(isEnable: isEnable)
    }
}
