//
//  LGPProductListViewController.swift
//  LiveGreenPlants
//
//  Created by Veeresh on 22/05/22.
//

import UIKit

class LGPProductListViewController: LGPViewController {
    
    var presenter:LGPProductListViewToPresenterProtocol?
    @IBOutlet weak var productListTableView : UITableView!
    @IBOutlet weak var storeLogoImageView : UIImageView!
    @IBOutlet weak var storeInfoLabel : UILabel!
    @IBOutlet weak var viewOrderSummaryButton : UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        updateSubviews()
        // Do any additional setup after loading the view.
    }
    
    override func getNavigationTitleText() -> String{
        return "Product Lists" // Use Localization
    }
    
    
    private func updateSubviews(){
        presenter?.registerTableWithCell(tabelView: productListTableView)
        productListTableView.delegate = self
        productListTableView.dataSource = self
        viewOrderSummaryButton.titleLabel?.font = lgpHeaderFont
        viewOrderSummaryButton.setTitleColor(lgpButtonTextColour, for: .normal)
        viewOrderSummaryButton.setTitle("View order summary", for: .normal)// Use Localization
        presenter?.didUpdateSubViews()
    }
    
    private  func updateViewButton(isEnable:Bool){
        viewOrderSummaryButton.backgroundColor = isEnable ?  lgpButtonColour : lgpButtonGrayColour
        viewOrderSummaryButton.isEnabled = isEnable
        
    }
    
    @objc  func incrementButtonAction(sender:UIButton) {
        presenter?.handleQuantitySelection(incrementButton: sender, tableView: productListTableView, isIncrement: true)
    }
    
    @objc  func decrementButtonAction(sender:UIButton) {
        presenter?.handleQuantitySelection(incrementButton: sender, tableView: productListTableView, isIncrement: false)
    }
    
    
    @IBAction func showOrderSummaryClicked(_ sender : Any) {
        presenter?.navigateToOrderSummary()
        
    }


}


extension LGPProductListViewController: UITableViewDataSource,UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter?.numberOfRowsInSection() ?? 0
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = presenter?.getCell(tableView: tableView, forRowAt: indexPath)
        cell?.quantityIncrementButton.addTarget(self, action:#selector(self.incrementButtonAction(sender:)), for: .touchUpInside)
        cell?.quantityDecrementButton.addTarget(self, action:#selector(self.decrementButtonAction(sender:)), for: .touchUpInside)
        cell?.selectionStyle = .none
        return cell!
    }
    
    
    
    
}


extension LGPProductListViewController :  LGPProductListPresenterToViewProtocol {
    func showFetchProductListSuccess() {
        self.productListTableView.reloadData()
    }
    
    func showFetchStoreInfoSuccess() {
        presenter?.updateStoreInfoSection(logoImage: storeLogoImageView, infoLabel: storeInfoLabel)
    }
    
    func showFetchProductListFailure() {
        //Diplay Alert for Failure
    }
    
    func showFetchStoreInfoFailure() {
        //Diplay Alert for Failure
    }
    
    func refresh(indexPath:IndexPath){
        self.productListTableView.reloadRows(at: [indexPath], with: .automatic)
    }
    
    func enableViewSummaryButton(isEnable:Bool){
        updateViewButton(isEnable: isEnable)
    }
    
    
   
    
}

extension LGPProductListViewController: LGPNavigationControllerViewControllerDelegate {
    func refreshRootViewController() {
        presenter?.didUpdateSubViews()
    }
    
    
}


