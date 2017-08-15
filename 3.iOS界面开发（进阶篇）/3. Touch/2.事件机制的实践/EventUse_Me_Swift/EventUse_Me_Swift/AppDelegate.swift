//
//  AppDelegate.swift
//  EventUse_Me_Swift
//
//  Created by 吴狄 on 2017/7/7.
//  Copyright © 2017年 SharePlus. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate,UITableViewDelegate,UITableViewDataSource {

    var window: UIWindow?

    var tableVC :UITableViewController = UITableViewController(style: .plain)
    
    var data:[[String:String]] = [];

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        
        self.window = UIWindow(frame: UIScreen.main.bounds)
        
        self.tableVC = UITableViewController(style: .plain);
        
        self.tableVC.tableView.delegate = self as UITableViewDelegate;
        self.tableVC.tableView.dataSource = self as UITableViewDataSource;
        self.tableVC.navigationItem.title = "Touch2 Demo"
        
        let naviController = UINavigationController(rootViewController: self.tableVC);
        
        
        
        self.data = [
            [
                "name":"Button - hitTest",
                "class":"ButtonHitTestViewController"
            ],
            [
                "name":"Button - hitTest",
                "class":"ButtonHitTestViewController"
            ],
            [
                "name":"Button - hitTest",
                "class":"ButtonHitTestViewController"
            ],
        
        ]
        
        
        self.window?.backgroundColor = UIColor.white;
        self.window?.rootViewController = naviController;
        
        
        
        
        
        return true
    }

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return self.data.count;
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        var cell = tableView.dequeueReusableCell(withIdentifier: "cell");
        
        let dic = self.data[indexPath.row]

        
        if cell == nil {
           
            cell = UITableViewCell();
        }
        
        
        cell?.textLabel?.text = dic["name"];
        
        return cell!;
        
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    
        
        
        let dic = self.data[indexPath.row]
        
        
        let controllerName = dic["class"]
        
        //获取命名空间，在info.plist文件里就是Executable file
        let nameSpace = Bundle.main.infoDictionary!["CFBundleExecutable"] as! String
        //拼接成固定格式
        let controller:AnyClass = NSClassFromString(nameSpace + "." + controllerName!)!
        //创建对象
        let viewController = (controller as! UIViewController.Type).init()
        
        viewController.view.backgroundColor = UIColor.white;
        viewController.edgesForExtendedLayout = UIRectEdge.init(rawValue: 0);
        
        self.tableVC.navigationController?.pushViewController(viewController , animated: true)
        
        
        
        
    }
    
    
    
    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

