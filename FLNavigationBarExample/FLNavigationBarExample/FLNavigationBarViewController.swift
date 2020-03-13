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

class FLNavigationBarViewController: UIViewController,UITableViewDelegate,UITableViewDataSource,FLNavigationPopDelegate {
    
    // MARK: - Class Public Methods
    // MARK: - Instance Public Methods
    
    // MARK: - Property
    
    var image: UIImage?
    var barStyle: FLBarStyle?
    var barBackgroundColor: UIColor?
    var barBlurEffectStyle: FLBlurEffectStyle?
    var isAloneBar: Bool = false
    
    @IBOutlet weak var lineLab: UILabel!
    var lineColor: UIColor?
    var lineColorTemp: UIColor?
    
    var isPrompt: Bool = false
    var isPromptTemp: Bool = false
    
    var largeTitleDisplayMode:UINavigationItem.LargeTitleDisplayMode = .never
    var largeTitleDisplayModeTemp:UINavigationItem.LargeTitleDisplayMode = .never
    
    @IBOutlet weak var changeBtn: UIButton!
    @IBOutlet weak var tableView: UITableView!
    
    let data:[[[String:Any]]] = [
        [
           ["Default":""]
        ],
        [
            ["White":UIColor.white],
            ["Random" : FLRandomColor()]
        ],
        [
            ["Transparent":""]
        ],
        [
            ["Hidden":""]
        ],
        [
            ["ExtraLight": FLBlurEffectStyle.extraLight],
            ["Lightk":FLBlurEffectStyle.light],
            ["Dark":FLBlurEffectStyle.dark]
        ],
        [
            ["Image":""],
            ["Alone Bar":""]
        ]
    ]

    let sentionTitles:[[String:Any]] = [
        [
            "style":FLBarStyle.default,
            "title":"Default"
        ],
        [
            "style":FLBarStyle.color,
            "title":"Color"
        ],
        [
            "style":FLBarStyle.transparent,
            "title":"Transparent"
        ],
        [
            "style":FLBarStyle.hidden,
            "title":"Hidden"
        ],
        [
            "style":FLBarStyle.translucent,
            "title":"Translucent"
        ],
        [
            "title":"Custom"
        ],
    ]
    
    override var shouldAutorotate: Bool {
        get {
           return true
        }
    }

    // MARK: - Life Cycle
    override func loadView() {
        super.loadView()
        
        self.automaticallyAdjustsScrollViewInsets = false
        if #available(iOS 11.0, *) {
            tableView.contentInsetAdjustmentBehavior = .never
        }
        
        if #available(iOS 11.0, *) {
            self.navigationController?.navigationBar.prefersLargeTitles = true
        }
        
        self.navigationItem.backBarButtonItem = UIBarButtonItem.init(title: "", style: .done, target: nil, action: nil)
        
        if barStyle != nil {
            self.navigationItem.yq_barStyle = barStyle!
        }
        
        if barBackgroundColor != nil {
            self.navigationItem.yq_barBackgroundColor = barBackgroundColor!
        }
        
        if barBlurEffectStyle != nil {
            self.navigationItem.yq_barBlurEffectStyle = barBlurEffectStyle!
        }
        
        self.navigationItem.title = "bar"
        if self.barStyle == FLBarStyle.hidden {
            self.navigationItem.title = nil
        }
        if lineColor != nil {
            self.navigationItem.yq_barLineColor = lineColor!
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initialize()
        setupViews()
  
        /// Imagse
        if image != nil {
             addAloneBarNavigationBar()
             self.alone_navigationItem.hidesBackButton = true;
             self.alone_barNavigationBar.setBackgroundImage(image, for: .default)
        }
        
        if isPrompt {
            if #available(iOS 11.0, *) {
                self.navigationItem.prompt = "prompt title"
            }
        }
        
        if #available(iOS 11.0, *) {
            self.navigationItem.largeTitleDisplayMode = largeTitleDisplayMode
        }
        
        
        var bars:[UIBarButtonItem] = []
        for _ in 0...2 {
            let barView = UIView.init(frame: .init(origin: .zero, size: .init(width: 44, height: 44)));
            barView.backgroundColor = FLRandomColor();
            let barItem = UIBarButtonItem.init(customView: barView)
            bars.append(barItem)
        }
        
        /*~~~  Custom Bar Style   ~~*/
        /// Alone Bar
        if isAloneBar {
            addAloneBarNavigationBar()
            self.alone_navigationItem.title = "bar"
            self.alone_barNavigationBar.isTranslucent = false
            self.alone_barNavigationBar.backgroundColor = UIColor.yellow
            self.alone_navigationItem.rightBarButtonItems = bars
        }else{
            if self.barStyle != FLBarStyle.hidden {
                self.navigationItem.rightBarButtonItems = bars
            }
        }
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        if isAloneBar || image != nil {
            aloneBarViewDidLayoutSubviews()
        }
    }
    
    // MARK: - Delegate
    func numberOfSections(in tableView: UITableView) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let section = data[section] as [Any]
        return section.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let  cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let item = data[indexPath.section][indexPath.row]
        cell.textLabel?.text = item.keys.first
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
       let ddd = sentionTitles[section]
       return (ddd["title"] as! String)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc:FLNavigationBarViewController = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "FLNavigationBarViewController") as! FLNavigationBarViewController
        
        switch indexPath.section {
        case 0:
            vc.barStyle = .default
            break
        case 1:
            let item = data[indexPath.section][indexPath.row] as! [String:UIColor]
            vc.barStyle = .color
            vc.barBackgroundColor = item.values.first!
            break
        case 2:
            vc.barStyle = .transparent
            break
        case 3:
            vc.barStyle = .hidden
            break
        case 4:
            let item = data[indexPath.section][indexPath.row] as! [String:FLBlurEffectStyle]
            vc.barStyle = .translucent
            vc.barBlurEffectStyle = item.values.first!
            break
        default:
            if indexPath.row == 0 {
                vc.barStyle = .transparent
                vc.image = UIImage.init(named: "timg.jpg")
            }else if indexPath.row == 1 {
                vc.barStyle = .hidden
                vc.isAloneBar = true
            }
            break
        }
        vc.lineColor = lineColorTemp
        if vc.barStyle != .hidden {
            vc.isPrompt = isPromptTemp
            vc.largeTitleDisplayMode = largeTitleDisplayModeTemp
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
    
    @IBAction func changeStyleAction(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            self.navigationItem.yq_barStyle = .color
            self.navigationItem.yq_barBackgroundColor = FLRandomColor()
            break
        case 1:
            self.navigationItem.yq_barStyle = .default
            break
        case 2:
            self.navigationItem.yq_barStyle = .transparent
            break
        case 3:
            self.navigationItem.yq_barStyle = .translucent
            break
            
        default:
            break
        }
        self.yq_barStyleUpdate()
    }
    
    @IBAction func lineColorAction(_ sender: Any) {
        lineColorTemp = FLRandomColor()
        lineLab.textColor = lineColorTemp
    }
    
    @IBAction func promptSelectAction(_ sender: UISwitch) {
         isPromptTemp = sender.isOn
    }
    
    @IBAction func switchStyleAction(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            largeTitleDisplayModeTemp = .never
            break
        case 1:
            largeTitleDisplayModeTemp = .automatic
            break
        case 2:
            largeTitleDisplayModeTemp = .always
            break
        default:
            break
        }
    }
    
    
    
    // MARK: - Notification
    // MARK: - Instance Private Methods
    
    // MARK: 初始化
    func initialize() {
        
    }
    // MARK: 视图初始化
    func setupViews() {
        tableView.reloadData()
    }
    
}
