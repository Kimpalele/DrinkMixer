
import UIKit
import CoreBluetooth

//Background color #1d2222

var productName = "Drinkmixer 2.0"

final class ViewController: UIViewController, BluetoothSerialDelegate {

    //MARK: Variables
    
    @IBOutlet weak var barButton: UIBarButtonItem!
    @IBOutlet weak var navItem: UINavigationItem!
    
    var alert: UIAlertController!

    //MARK: Functions

    override func viewDidLoad() {
        super.viewDidLoad()
        
        serial = BluetoothSerial(delegate: self)
        reloadView()

        NotificationCenter.default.addObserver(self, selector: #selector(ViewController.reloadView),
                        name: NSNotification.Name(rawValue: "reloadStartViewController"), object: nil)

    }

    deinit{
        NotificationCenter.default.removeObserver(self)
    }


    //Updates main screen
    @objc func reloadView() {
        serial.delegate = self

        if serial.isReady {
            //When connected display the name of the device
            navItem.title = serial.connectedPeripheral!.name
            barButton.title = "Disconnect"
            barButton.tintColor = UIColor.red
            barButton.isEnabled = true
        } else if serial.centralManager.state == .poweredOn {
            //Else just display the name of the app
            navItem.title = productName
            barButton.title = "Connect"
            barButton.tintColor = UIColor.link
            barButton.isEnabled = true
        } else {
            navItem.title = productName
            barButton.title = "Connect"
            barButton.tintColor = UIColor.link
            barButton.isEnabled = false
        }
    }

    //MARK: BluetoothSerialDelegate

    //Notifies user and screen when device disconnects
    func serialDidDisconnect(_ peripheral: CBPeripheral, error: NSError?) {
        reloadView()
        let alert = UIAlertController(title: "Disconnected", message: "Connection has been terminated",preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default,
            handler: { action -> Void in self.dismiss(animated: true) }))
        
        present(alert, animated: true)
    }

    //Notifies user and screen when bluetooth is off
    func serialDidChangeState() {
        reloadView()
        if serial.centralManager.state != .poweredOn {
            let alert = UIAlertController(title: "No bluetooth", message: "Bluetooth is off",preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default,
                handler: { action -> Void in self.dismiss(animated: true) }))
            
            present(alert, animated: true)
        }
    }
    
    //Checks if app is connected to device
    func notConnected() -> Bool {
        if !serial.isReady {
            let alert = UIAlertController(title: "No connection",
                message: "Can't mix drinks \nwithout a connection",preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default,
                handler: { action -> Void in self.dismiss(animated: true) }))
            
            present(alert, animated: true)
            return true
        } else {
            return false
        }
    }
    
    //30 sec
    func showDrinkAlert() {
        alert = UIAlertController(title: "Heads up!", message: "Drink in the making", preferredStyle: .alert)
        present(alert, animated: true)
        Timer.scheduledTimer(timeInterval: 5, target: self, selector:
            #selector(ViewController.dismissAlert), userInfo: nil, repeats: false)
    }
    
    //7 sec
    func showPreparePumpAlert() {
        alert = UIAlertController(title: "Commencing..", message: "Preparing pump", preferredStyle: .alert)
        present(alert, animated: true)
        Timer.scheduledTimer(timeInterval: 5, target: self, selector:
            #selector(ViewController.dismissAlert), userInfo: nil, repeats: false)
    }
    
    //37 sec
    func showPrepareAllPumpsAlert() {
        alert = UIAlertController(title: "Commencing..", message: "Preparing all pumps", preferredStyle: .alert)
        present(alert, animated: true)
        Timer.scheduledTimer(timeInterval: 5, target: self, selector:
            #selector(ViewController.dismissAlert), userInfo: nil, repeats: false)
    }
    
    //2 min
    func showCleaningAlert() {
        alert = UIAlertController(title: "Cleaning", message: "Performing cleaning program\nPlease hold!", preferredStyle: .alert)
        present(alert, animated: true)
        Timer.scheduledTimer(timeInterval: 5, target: self, selector:
            #selector(ViewController.dismissAlert), userInfo: nil, repeats: false)
    }
    
    @objc func dismissAlert(){
        alert.dismiss(animated: true)
    }

    //Checks if device is connected. If so the buttonpress
    //will disconnect device, if not, open scannerscreen
    @IBAction func connectButton(_ sender: Any) {
        if serial.connectedPeripheral == nil {
            performSegue(withIdentifier: "Scanner", sender: self)
        } else {
            serial.disconnect()
            reloadView()
        }
    }
    
    //MARK: Button functions
    
    
    //TODO: Check for possibility to merge into fewer functions with different
    //Parameters depending on which button was pressed.
    @IBAction func drinkOne(_ sender: Any) {
        if notConnected(){
            NSLog("Not Connected")
        } else if !notConnected(){
            serial.sendMessageToDevice("Redbull")
            showDrinkAlert()
        }
    }
    
    @IBAction func drinkTwo(_ sender: Any) {
        if notConnected(){
            NSLog("Not Connected")
        } else if !notConnected(){
            serial.sendMessageToDevice("Cranberry")
            showDrinkAlert()
        }
    }
    
    @IBAction func pump1(_ sender: Any) {
        if notConnected(){
            NSLog("Not Connected")
        } else if !notConnected(){
            serial.sendMessageToDevice("Pump1")
            showPreparePumpAlert()
        }
    }
    
    @IBAction func pump2(_ sender: Any) {
        if notConnected(){
            NSLog("Not Connected")
        } else if !notConnected(){
            serial.sendMessageToDevice("Pump2")
            showPreparePumpAlert()
        }
    }
    
    @IBAction func pump3(_ sender: Any) {
        if notConnected(){
            NSLog("Not Connected")
        } else if !notConnected(){
            serial.sendMessageToDevice("Pump3")
            showPreparePumpAlert()
        }
    }
    
    @IBAction func pump4(_ sender: Any) {
        if notConnected(){
            NSLog("Not Connected")
        } else if !notConnected(){
            serial.sendMessageToDevice("Pump4")
            showPreparePumpAlert()
        }
    }
    
    @IBAction func pump5(_ sender: Any) {
        if notConnected(){
            NSLog("Not Connected")
        } else if !notConnected(){
            serial.sendMessageToDevice("Pump5")
            showPreparePumpAlert()
        }
    }
    
    @IBAction func pump6(_ sender: Any) {
        if notConnected(){
            NSLog("Not Connected")
        } else if !notConnected(){
            serial.sendMessageToDevice("Pump6")
            showPreparePumpAlert()
        }
    }
    
    @IBAction func prepareAll(_ sender: Any) {
        if notConnected(){
            NSLog("Not Connected")
        } else if !notConnected(){
            serial.sendMessageToDevice("prepareAll")
            showPreparePumpAlert()
        }
    }
    
    @IBAction func cleanAll(_ sender: Any) {
        if notConnected(){
            NSLog("Not Connected")
        } else if !notConnected(){
            serial.sendMessageToDevice("cleanAll")
            showCleaningAlert()
        }
    }
    
}
