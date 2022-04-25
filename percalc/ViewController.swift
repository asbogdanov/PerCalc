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
    @IBOutlet weak var cancelButton: UIButton! {
        didSet{
            cancelButton.layer.cornerRadius = 10
        }
    }
    @IBOutlet weak var okButton: UIButton! {
        didSet{
            okButton.layer.cornerRadius = 10
        }
    }

    @IBAction func buttonOK(_ sender: UIButton) {

        if let percent = TFPercent.text, let number = TFNumber.text, percent.isEmpty || number.isEmpty {

        let alert = UIAlertController(title: "Не заполнено поле", message: "Пожалуйста, заполните все поля.", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(okAction)
        present(alert, animated: true, completion: nil)
        } else { return labelResult.text = "\(TFPercent.text!)% от числа \(TFNumber.text!) = \((Double(TFNumber.text!)!) * 0.01 * (Double(TFPercent.text!)!))" }
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

