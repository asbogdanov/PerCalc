//
//  ViewController.swift
//  percalc
//
//  Created by Aleksandr Bogdanov on 19.04.2022.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var TFPercent: UITextField!
    @IBOutlet weak var TFNumber: UITextField!

    @IBOutlet weak var labelResult: UILabel!

    @IBAction func buttonOK(_ sender: UIButton) {

//        guard let percent = TFPercent.text, let number = TFNumber.text else { return }
//        var percentTF = Double(percent)
//        var numberTF = Double(number)
//        var result = labelResult.text

        if TFPercent.text!.isEmpty || TFNumber.text!.isEmpty {
            labelResult.text = "Необходимо заполнить все поля."
        } else {
            labelResult.text = "\(TFPercent.text!)% от числа \(TFNumber.text!) = \((Double(TFNumber.text!)!) * 0.01 * (Double(TFPercent.text!)!))"
        }
    }

    @IBAction func buttonCancel(_ sender: UIButton) {
        TFPercent.text = ""
        TFNumber.text = ""
        labelResult.text = "Здесь отобразится результат!"
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

