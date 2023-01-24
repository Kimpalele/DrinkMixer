
import UIKit
import CoreBluetooth

final class ScanViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, BluetoothSerialDelegate {

    //MARK: Variables

    @IBOutlet weak var tryAgain: UIBarButtonItem!
    @IBOutlet weak var tableView: UITableView!

    //Discovered peripherals
    var peripherals: [(peripheral: CBPeripheral, RSSI: Float)] = []

    var selectedPeripheral: CBPeripheral?

    //MARK: Functions

    override func viewDidLoad(){
        super.viewDidLoad()

        //The button will only be availble once a scan is timed out
        tryAgain.isEnabled = false
        
        tableView.tableFooterView = UIView(frame: CGRect.zero)
        
        //Tell the delegate to notificate the current screen if something goes wrong
        serial.delegate = self

        if serial.centralManager.state != .poweredOn {
            title = "Bluetooth avstängd"
            return
        }

        serial.startScan()
        Timer.scheduledTimer(timeInterval: 10, target: self, selector: #selector(ScanViewController.scanTimeOut), userInfo: nil, repeats: false)
    }

    override func didReceiveMemoryWarning() {
        //Dispose unneccesary resources
        super.didReceiveMemoryWarning()
    }

    //Will be called upon 10 seconds after the try again button has been pressed
    @objc func scanTimeOut() {
        serial.stopScan()
        tryAgain.isEnabled = true
        title = "Skanning klar"
    }

    //Will be called 10 seconds after first connection attempt
    @objc func connectTimeOut() {

        //Dont bother if we succeded connecting
        if let _ = serial.connectedPeripheral{
            return
        }

        if let _ = selectedPeripheral {
            serial.disconnect()
            selectedPeripheral = nil
        }
    }

    //MARK: UITableViewDataSource

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return peripherals.count
    }

    //Adds discovered peripherals into the tableview for the user to see and select
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        //TODO: Haven't got the cell creation to work properly with the peripheral name
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell")!
        let label = cell.viewWithTag(1) as? UILabel
        label?.text = peripherals[(indexPath as NSIndexPath).row].peripheral.name
        return cell
    }

    //MARK: UITableViewDelegate

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)

        //When user has selected a device, stop scanning and proceed to the next screen
        serial.stopScan()
        selectedPeripheral = peripherals[(indexPath as NSIndexPath).row].peripheral
        serial.connectToPeripheral(selectedPeripheral!)
        
        //Set a timer for 10 seconds then call on the timeout func
        Timer.scheduledTimer(timeInterval: 10, target: self, selector: #selector(ScanViewController.connectTimeOut), userInfo: nil, repeats: false)
    }

    //MARK: BluetoothSerialDelegate

    func serialDidDiscoverPeripheral(_ peripheral: CBPeripheral, RSSI: NSNumber?) {

        //Check if its a duplicate
        for existing in peripherals {
            if existing.peripheral.identifier == peripheral.identifier {return}
        }

        //add into the array, sort and reload again
        let theRSSI = RSSI?.floatValue ?? 0.0
        peripherals.append((peripheral: peripheral, RSSI: theRSSI))
        peripherals.sort {$0.RSSI < $1.RSSI}
        tableView.reloadData()
    }

    //TODO: Find out why this doesn't trigger correctly
    func serialDidFailToConnect(_ peripheral: CBPeripheral, error: NSError?) {
        //Enables tryAgain button and show popup with info
        tryAgain.isEnabled = true
        let alert = UIAlertController(title: "Woops", message: "Failed to connect", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: {action -> Void in alert.dismiss(animated: true) }))
        present(alert, animated: true)
    
    }
    
    //This seems to trigger when an attempted connection failed,
    //Instead of when a device disconnects
    func serialDidDisconnect(_ peripheral: CBPeripheral, error: NSError?) {
        //Enables tryAgain button and show popup with info
        tryAgain.isEnabled = true
        let alert = UIAlertController(title: "Woops", message: "Connection failed", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: {action -> Void in alert.dismiss(animated: true) }))
        present(alert, animated: true)

    }
    
    //Closes scanner screen and returns to main screen once connection has been established
    func serialIsReady(_ peripheral: CBPeripheral) {
        NotificationCenter.default.post(name: Notification.Name(rawValue: "reloadStartViewController"), object: self)
        dismiss(animated: true, completion: nil)
        NSLog("Anslutning Klar")
    }
    
    //Returns to main screen if bluetooth is turned off while scanner screen is active
    func serialDidChangeState() {
        if serial.centralManager.state != .poweredOn {
            NotificationCenter.default.post(name: Notification.Name(rawValue: "reloadStartViewController"), object: self)
            dismiss(animated: true, completion: nil)
            NSLog("BT av")
        }
    }


    //MARK: IBActions
    
    @IBAction func cancel(_ sender: Any) {
        serial.stopScan()
        dismiss(animated: true)
    }
    
    //Empty array of discovered peripherals, disable try again button
    //Start new scan and setup new scan timeout
    @IBAction func tryAgain(_ sender: AnyObject) {
        // empty array, disable try again button
        //start scanning once more and setup
        //new scan timeout
        peripherals = []
        tableView.reloadData()
        tryAgain.isEnabled = false
        title = "Scanning ..."
        serial.startScan()
        Timer.scheduledTimer(timeInterval: 10, target: self, selector: #selector(ScanViewController.scanTimeOut), userInfo: nil, repeats: false)
    }




}
