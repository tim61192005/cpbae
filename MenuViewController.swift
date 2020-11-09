//
//  MenuViewController.swift
//  UserRegistrationExample
//
//  Created by 陳勁廷 on 2020/6/17.
//  Copyright © 2020 Sergey Kargopolov. All rights reserved.
//

import UIKit
import SwiftKeychainWrapper
//struct cellData {
//    var opened = Bool()
//    var title = String()
//    var sectionData = [String]()
//}

protocol SlideMenuDelegate {
    func slideMenuItemSelectedAtIndex(_ index : Int32)
    }


class MenuViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, ExpandableHeaderViewDelegate {
 
//    var tableViewData = [cellData]()
    
    
    //Array to display menu options
    @IBOutlet var tblMenuOptions: UITableView!
    //Transparent burron to hide Menu
    @IBOutlet var btnCloseMenuOverlay: UIButton!
    //Menu button which was tapped to display the menu
    var btMenu : UIButton!
    //delegate of the MenuVC
    var delegate : SlideMenuDelegate?
    
  
   var sections = [
    Section(genre: "學分班程", sbeject: ["課程總覽","法律","不動產","圖書管理","隨班附讀"], expanded: false),
    Section(genre: "國際語文", sbeject: ["課程總覽","英語","日/韓語","東南亞語","歐語及其他"], expanded: false),
    Section(genre: "專業進修", sbeject: ["課程總覽","商業管理","藝術人文","兒童成長","資訊科技"], expanded: false),
    Section(genre: "委訓合作", sbeject: ["企業委訓","專業證照","政府補助"], expanded: false),
    Section(genre: "場地空間", sbeject: ["場地租借","住宿服務","產學合作"], expanded: false)
    ]
    
//    var sections = [
//    Section(genre: "學分班程", sbeject: ["收藏-1","收藏-1","收藏-1","收藏-1","收藏-1"], expanded: false),
//    Section(genre: "國際語文", sbeject: ["課程總覽","英語","日/韓語","東南亞語","歐語及其他"], expanded: false),
//    Section(genre: "專業進修", sbeject: ["課程總覽","商業管理","藝術人文","兒童成長","資訊科技"], expanded: false),
//    Section(genre: "委訓合作", sbeject: ["企業委訓","專業證照","政府補助"], expanded: false),
//    Section(genre: "場地空間", sbeject: ["場地租借","住宿服務","產學合作"], expanded: false)
//    ]

    override func viewDidLoad() {
           super.viewDidLoad()
        
//        tblMenuOptions.tableFooterView = UIView()
//           // Do any additional setup after loading the view.
//        tableViewData = [cellData(opened: false, title: "學分班程", sectionData: ["課程總覽","法律","不動產","圖書管理","隨班附讀"]),
//                         cellData(opened: false, title: "國際語文", sectionData: ["課程總覽","英語","日/韓語","東南亞語","歐語及其他"]),
//                         cellData(opened: false, title: "專業進修", sectionData: ["課程總覽","商業管理","藝術人文","兒童成長","資訊科技"]),
//                         cellData(opened: false, title: "委訓合作", sectionData: ["企業委訓","專業證照","政府補助"]),
//                         cellData(opened: false, title: "場地空間", sectionData: ["場地租借","住宿服務","產學合作"])]
       }
    
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
   
    }
    

    
    
   
    @IBAction func onCloseMenuClick(_ button: UIButton!) {
        
        btMenu.tag = 0
        if (self.delegate != nil) {
            var index = Int32(button.tag)
            if (button == self.btnCloseMenuOverlay) {
                index = -1
            }
            delegate?.slideMenuItemSelectedAtIndex(index)
        }
        
        UIView.animate(withDuration: 0.3, animations: {() -> Void in
            self.view.frame = CGRect(x: -UIScreen.main.bounds.size.width, y: 0, width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height)
            self.view.layoutIfNeeded()
            self.view.backgroundColor = UIColor.clear
        }, completion: {(finished) -> Void in
            self.view.removeFromSuperview()
            
            self.removeFromParentViewController()
        })
    }
    
        //這是下拉的
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let dataIndex = indexPath.row - 1
//        if indexPath.row == 0 {
//            guard let cell = tableView.dequeueReusableCell(withIdentifier: "cellMenu") else {return UITableViewCell()}
//            cell.textLabel?.text = tableViewData[indexPath.section].title
//            return cell
//        } else {
//            guard let cell = tableView.dequeueReusableCell(withIdentifier: "cellMenu") else {
//                return UITableViewCell()}
//            cell.textLabel?.text = tableViewData[indexPath.section].sectionData[dataIndex]
//            return cell
//        }
//    }
//
           
//            //這是下拉的
//        func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//            if tableViewData[indexPath.section].opened == true {
//                tableViewData[indexPath.section].opened = false
//                let sections = IndexSet.init(integer: indexPath.section)
//                tableView.reloadSections(sections, with: .none)
//            } else {
//                tableViewData[indexPath.section].opened = true
//                let sections = IndexSet.init(integer: indexPath.section)
//                tableView.reloadSections(sections, with: .none)
//            }
//            print("你點選了 + \(indexPath.row)")
//        }
    
    
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//            //這是下拉的
//            if tableViewData[section].opened == true {
//                return tableViewData[section].sectionData.count + 1
//            }else{
//                return 1
//            }
//        }
//        func numberOfSections(in tableView: UITableView) -> Int {
//
//
//
//            //這是下拉的
//            return tableViewData.count
//        }
//
//    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
//        cell.tintColor = UIColor.white
//
//    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sections[section].sbeject.count
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 44
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if (sections[indexPath.section].expanded) {
            return 44
        }else {
            return 0
        }
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = ExpandableHeaderView()
        header.customInit(title: sections[section].genre, section: section, delegate: self)
        return header
    }
    
   func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "cellMenu")!
    cell.textLabel?.text = sections[indexPath.section].sbeject[indexPath.row]
    return cell
    }
    
    func toggleSection(header: ExpandableHeaderView, section: Int) {
        sections[section].expanded = !sections[section].expanded
        
        tblMenuOptions.beginUpdates()
        for i in 0 ..< sections[section].sbeject.count{
            tblMenuOptions.reloadRows(at: [IndexPath(row: i, section: section)], with: .automatic)
        }
        tblMenuOptions.endUpdates()
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let simpleVC = SimpleVC()
//        simpleVC.setWebView(webURL: sections[indexPath.section].sbeject[indexPath.row])
////        simpleVC.customInit(imageName: sections[indexPath.section].sbeject[indexPath.row])
//        tableView.deselectRow(at: indexPath, animated: true)
//        self.navigationController?.pushViewController(simpleVC, animated: true)
        
        let simpleVC = SimpleVC()
        let classoverviewVC = ClassOverviewVC()
        let legalVC = LegalVC()
        let realEstateVC = RealEstateVC()
        let libraryManagementVC = LibraryManagementVC()
        let attachedReadingVC = AttachedReadingVC()
        let languageOverviewVC = LanguageOverviewVC()
        let englishVC = EnglishVC()
        let jpanesekoreanVC = JPaneseKKoreanVC()
        let southeastAsianVC = SoutheastAsianVC()
        let european_othersVC = European_OthersVC()
        let professionaloverviewVC = ProFessionalOverviewVC()
        let businessVC = BusinessVC()
        let artVC = ArtVC()
        let childVC = ChildVC()
        let itVC = ItVC()
        let enterpriseVC = EnterpriseVC()
        let licenseVC = LicenseVC()
        let subsidyVC = SubsidyVC()
        let venuerentalVC = VenueRentalVC()
        let accommodationserviceVC = AccommodationServiceVC()
        let industryuniversityVC = IndustryUniversityVC()
        
        if sections[indexPath.section].genre == "學分班程"{
            if sections[indexPath.section].sbeject[indexPath.row] == "課程總覽" {
                simpleVC.setWebView(webURL: sections[indexPath.section].sbeject[indexPath.row])
                tableView.deselectRow(at: indexPath, animated: true)
                        self.navigationController?.pushViewController(classoverviewVC, animated: true)
            }else if sections[indexPath.section].sbeject[indexPath.row] == "法律" {
                simpleVC.setWebView(webURL: sections[indexPath.section].sbeject[indexPath.row])
                tableView.deselectRow(at: indexPath, animated: true)
                        self.navigationController?.pushViewController(legalVC, animated: true)
            }else if sections[indexPath.section].sbeject[indexPath.row] == "不動產" {
                simpleVC.setWebView(webURL: sections[indexPath.section].sbeject[indexPath.row])
                tableView.deselectRow(at: indexPath, animated: true)
                        self.navigationController?.pushViewController(realEstateVC, animated: true)
            }else if sections[indexPath.section].sbeject[indexPath.row] == "圖書管理" {
                simpleVC.setWebView(webURL: sections[indexPath.section].sbeject[indexPath.row])
                tableView.deselectRow(at: indexPath, animated: true)
                        self.navigationController?.pushViewController(libraryManagementVC, animated: true)
            }else if sections[indexPath.section].sbeject[indexPath.row] == "隨班附讀" {
                simpleVC.setWebView(webURL: sections[indexPath.section].sbeject[indexPath.row])
                tableView.deselectRow(at: indexPath, animated: true)
                        self.navigationController?.pushViewController(attachedReadingVC, animated: true)
            }
            
        }else if sections[indexPath.section].genre == "國際語文" {
            if sections[indexPath.section].sbeject[indexPath.row] == "課程總覽" {
                simpleVC.setWebView(webURL: sections[indexPath.section].sbeject[indexPath.row])
                tableView.deselectRow(at: indexPath, animated: true)
                        self.navigationController?.pushViewController(languageOverviewVC, animated: true)
            }else if sections[indexPath.section].sbeject[indexPath.row] == "英語" {
                simpleVC.setWebView(webURL: sections[indexPath.section].sbeject[indexPath.row])
                tableView.deselectRow(at: indexPath, animated: true)
                        self.navigationController?.pushViewController(englishVC, animated: true)
            }else if sections[indexPath.section].sbeject[indexPath.row] == "日/韓語" {
                simpleVC.setWebView(webURL: sections[indexPath.section].sbeject[indexPath.row])
                tableView.deselectRow(at: indexPath, animated: true)
                        self.navigationController?.pushViewController(jpanesekoreanVC, animated: true)
            }else if sections[indexPath.section].sbeject[indexPath.row] == "東南亞語" {
                simpleVC.setWebView(webURL: sections[indexPath.section].sbeject[indexPath.row])
                tableView.deselectRow(at: indexPath, animated: true)
                        self.navigationController?.pushViewController(southeastAsianVC, animated: true)
            }else if sections[indexPath.section].sbeject[indexPath.row] == "歐語及其他" {
                simpleVC.setWebView(webURL: sections[indexPath.section].sbeject[indexPath.row])
                tableView.deselectRow(at: indexPath, animated: true)
                        self.navigationController?.pushViewController(european_othersVC, animated: true)
            }
            
        }else if sections[indexPath.section].genre == "專業進修" {
            if sections[indexPath.section].sbeject[indexPath.row] == "課程總覽" {
                simpleVC.setWebView(webURL: sections[indexPath.section].sbeject[indexPath.row])
                tableView.deselectRow(at: indexPath, animated: true)
                        self.navigationController?.pushViewController(professionaloverviewVC, animated: true)
            }else if sections[indexPath.section].sbeject[indexPath.row] == "商業管理" {
                simpleVC.setWebView(webURL: sections[indexPath.section].sbeject[indexPath.row])
                tableView.deselectRow(at: indexPath, animated: true)
                        self.navigationController?.pushViewController(businessVC, animated: true)
            }else if sections[indexPath.section].sbeject[indexPath.row] == "藝術人文" {
                simpleVC.setWebView(webURL: sections[indexPath.section].sbeject[indexPath.row])
                tableView.deselectRow(at: indexPath, animated: true)
                        self.navigationController?.pushViewController(artVC, animated: true)
            }else if sections[indexPath.section].sbeject[indexPath.row] == "兒童成長" {
                simpleVC.setWebView(webURL: sections[indexPath.section].sbeject[indexPath.row])
                tableView.deselectRow(at: indexPath, animated: true)
                        self.navigationController?.pushViewController(childVC, animated: true)
            }else if sections[indexPath.section].sbeject[indexPath.row] == "資訊科技" {
                simpleVC.setWebView(webURL: sections[indexPath.section].sbeject[indexPath.row])
                tableView.deselectRow(at: indexPath, animated: true)
                        self.navigationController?.pushViewController(itVC, animated: true)
            }
            
        }else if sections[indexPath.section].genre == "委訓合作" {
            if sections[indexPath.section].sbeject[indexPath.row] == "企業委訓" {
                simpleVC.setWebView(webURL: sections[indexPath.section].sbeject[indexPath.row])
                tableView.deselectRow(at: indexPath, animated: true)
                        self.navigationController?.pushViewController(enterpriseVC, animated: true)
            }else if sections[indexPath.section].sbeject[indexPath.row] == "專業證照" {
                simpleVC.setWebView(webURL: sections[indexPath.section].sbeject[indexPath.row])
                tableView.deselectRow(at: indexPath, animated: true)
                        self.navigationController?.pushViewController(licenseVC, animated: true)
            }else if sections[indexPath.section].sbeject[indexPath.row] == "政府補助" {
                simpleVC.setWebView(webURL: sections[indexPath.section].sbeject[indexPath.row])
                tableView.deselectRow(at: indexPath, animated: true)
                        self.navigationController?.pushViewController(subsidyVC, animated: true)
            }
            
        }else if sections[indexPath.section].genre == "場地空間" {
           if sections[indexPath.section].sbeject[indexPath.row] == "場地租借" {
                simpleVC.setWebView(webURL: sections[indexPath.section].sbeject[indexPath.row])
                tableView.deselectRow(at: indexPath, animated: true)
                        self.navigationController?.pushViewController(venuerentalVC, animated: true)
            }else if sections[indexPath.section].sbeject[indexPath.row] == "住宿服務" {
                simpleVC.setWebView(webURL: sections[indexPath.section].sbeject[indexPath.row])
                tableView.deselectRow(at: indexPath, animated: true)
                        self.navigationController?.pushViewController(accommodationserviceVC, animated: true)
            }else if sections[indexPath.section].sbeject[indexPath.row] == "產學合作" {
                simpleVC.setWebView(webURL: sections[indexPath.section].sbeject[indexPath.row])
                tableView.deselectRow(at: indexPath, animated: true)
                        self.navigationController?.pushViewController(industryuniversityVC, animated: true)
            }
            
        }
    }
    
    @IBAction func signOutButtonTapped(_ sender: Any) {
      //清除accesstoken紀錄以達到登出狀態
               KeychainWrapper.standard.removeObject(forKey: "accessToken")
               
               
               let signInPage = self.storyboard?.instantiateViewController(withIdentifier: "SignInViewController") as! SignInViewController
               let appDelegate = UIApplication.shared.delegate
               appDelegate?.window??.rootViewController = signInPage
           }
}
