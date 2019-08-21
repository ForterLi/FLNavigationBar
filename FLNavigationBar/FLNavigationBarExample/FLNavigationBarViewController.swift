//
//  FLNavigationBarViewController.swift
//  FLBaseKit
//
//  Created by 李永强 on 2019/8/15.
//  Copyright © 2019 李永强. All rights reserved.
//

import UIKit



func FLRandomColor() -> UIColor {
    return  UIColor(red: CGFloat(arc4random_uniform(256))/255.0, green: CGFloat(arc4random_uniform(256))/255.0, blue: CGFloat(arc4random_uniform(256))/255.0, alpha: 1)
}
var count = 0

class FLNavigationBarViewController: UIViewController,UITableViewDelegate,UITableViewDataSource,FLNavigationPopDelegate {
    // MARK: - Class Public Methods
    // MARK: - Instance Public Methods
    // MARK: - Property
    
    var image:UIImage?
    var barStyle:FLBarStyle?
    var barBackgroundColor:UIColor?
    var barBlurEffectStyle:FLBlurEffectStyle?
    var isAloneBar:Bool = false
    
    @IBOutlet weak var changeBtn: UIButton!
    @IBOutlet weak var tableView: UITableView!
    
    var barStyles:[[String:FLBlurEffectStyle]]!
    var colors:[[String:UIColor]]!
    var transparents:[String]!
    var hiddenStyle:[String]!
    
    var customBar:[[String:Any]]!


    override var shouldAutorotate: Bool {
        get {
           return true
        }
    }
    
    // MARK: - Life Cycle
    override func loadView() {
        super.loadView()
        if barStyle != nil {
            self.navigationItem.yq_barStyle = barStyle!
        }
        
        if barBackgroundColor != nil {
            self.navigationItem.yq_barBackgroundColor = barBackgroundColor!
        }
        
        if barBlurEffectStyle != nil {
            self.navigationItem.yq_barBlurEffectStyle = barBlurEffectStyle!
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = "\(count)"
        if self.barStyle == FLBarStyle.hidden {
            self.navigationItem.title = nil
        }
        self.navigationItem.backBarButtonItem = UIBarButtonItem.init(title: "", style: .done, target: nil, action: nil)
        if isAloneBar {
            addAloneBarNavigationBar()
            self.alone_navigationItem.title = "\(count)"
        }

        if image != nil {
             addAloneBarNavigationBar()
             self.alone_navigationItem.hidesBackButton = true;
             self.alone_barNavigationBar.setBackgroundImage(image, for: .default)
        }
        
      
        count += 1
        
        // 默认样式
        barStyles = [
            ["BarStyleExtraLight": FLBlurEffectStyle.extraLight],
            ["BarStyleLightk":FLBlurEffectStyle.light],
            ["BarStyleDark":FLBlurEffectStyle.dark]
            ]
        
        // color样式
        colors = [
        ["None" : UIColor.clear],
        ["Black" : UIColor.black],
        ["White" : UIColor.white],
        ["Red" : UIColor.red],
        ["Random" : FLRandomColor()]
        ];
        
        // 透明样式
        transparents = ["Transparent"]
        
        // 隐藏样式
        hiddenStyle = ["Hidden"]
        
        // 图片样式
        customBar = [
            ["Image":""],
            ["Alone Bar":""],
        ];
        tableView.reloadData()
    }
    
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        if isAloneBar || image != nil {
            aloneBarViewDidLayoutSubviews()
        }
    }
    
    // MARK: - Delegate
    func numberOfSections(in tableView: UITableView) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 { return barStyles.count}
        else if section == 1 {return colors.count}
        else if section == 2 {return transparents.count}
        else if section == 3 {return hiddenStyle.count}
        else if section == 4 {return customBar.count}
        else {return 0};
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let  cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        switch indexPath.section {
        case 0:
            let item = barStyles[indexPath.row]
            cell.textLabel?.text = item.keys.first
            break
        case 1:
            let item = colors[indexPath.row]
            cell.textLabel?.text = item.keys.first
            break
        case 2:
            let item = transparents[indexPath.row]
            cell.textLabel?.text = item
            break
        case 3:
            let item = hiddenStyle[indexPath.row]
            cell.textLabel?.text = item
            break
        case 4:
            let item = customBar[indexPath.row]
            cell.textLabel?.text = item.keys.first
            break
        default:
            break
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 { return "Bar Style Default"}
        else if section == 1 {return "Bar Style Color"}
        else if section == 2 {return "Bar Style Transparent"}
        else if section == 3 {return "Bar Style hidden"}
        else if section == 4 {return "Custom Bar Stylee"}
        else {return nil}
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc:FLNavigationBarViewController = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "FLNavigationBarViewController") as! FLNavigationBarViewController
        
        switch indexPath.section {
        case 0:
            vc.barStyle = .default
            let item = barStyles[indexPath.row]
            vc.barBlurEffectStyle = item.values.first!
            break
        case 1:
            vc.barStyle = .color
            let item = colors[indexPath.row]
            vc.barBackgroundColor = item.values.first!
            break
        case 2:
            vc.barStyle = .transparent
            break
        case 3:
            vc.barStyle = .hidden
            break
        case 4:
            if indexPath.row == 0 {
                vc.barStyle = .transparent
                vc.image = UIImage.init(named: "timg.jpg")
            }else if indexPath.row == 1 {
                vc.barStyle = .hidden
                vc.isAloneBar = true
            }
            break
        default:
            break
        }
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
    func barNavigationShouldPopOnBackButton() -> Bool {
        let backAlert:UIAlertController = UIAlertController(title: "back", message: "back", preferredStyle: .alert)
        backAlert.addAction(.init(title: "back", style: .destructive, handler: { (d) in
            self.navigationController?.popViewController(animated: true)
        }))
        backAlert.addAction(.init(title: "cancle", style: .cancel, handler: { (d) in
        }))
        self.present(backAlert, animated: true, completion: nil)
        return false
    }
    
    // MARK: - Event Repons
    @IBAction func changeColorAction(_ sender: Any) {
        changeBtn.backgroundColor = FLRandomColor()
    }
    
    // MARK: - Notification
    // MARK: - Instance Private Methods
    
    // MARK: 初始化
    func initialize() {}
    // MARK: 视图初始化
    func setupViews() {}
    
}
