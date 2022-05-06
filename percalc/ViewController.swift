//
//  ViewController.swift
//  percalc
//
//  Created by Aleksandr Bogdanov on 19.04.2022.
//

import UIKit

class ViewController: UIViewController {

    var uiElements = ["Нахождение % от числа",
                      "Сколько % составляет число от числа",
                      "Прибавить % к числу",
                      "Выделить НДС",
                      "Начислить НДС"]

    var pickerView = UIPickerView()

    var selectedIndex: Int = -1

    @IBOutlet weak var TFPercent: UITextField!
    @IBOutlet weak var TFNumber: UITextField!
    @IBOutlet weak var labelResult: UILabel!
    @IBOutlet weak var selectOperation: UITextField! {
        didSet{
            selectOperation.text = "Нажмите для выбора операции"
            selectOperation.textAlignment = .center
        }
    }
    @IBOutlet weak var firstLabel: UILabel! {
        didSet{
            firstLabel.isHidden = true
        }
    }
    @IBOutlet weak var secondLabel: UILabel! {
        didSet{
            secondLabel.isHidden = true
        }
    }
    @IBOutlet weak var percentLabel: UILabel! {
        didSet{
            percentLabel.isHidden = true
        }
    }
    @IBOutlet weak var cancelButton: UIButton! {
        didSet{
            cancelButton.layer.cornerRadius = 10
            cancelButton.frame.size = CGSize(width: 100, height: 60)
        }
    }
    @IBOutlet weak var okButton: UIButton! {
        didSet{
            okButton.layer.cornerRadius = 10
            okButton.frame.size = CGSize(width: 100, height: 60)
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        pickerView.delegate = self
        pickerView.dataSource = self
        pickerView.backgroundColor = .white

        selectOperation.inputView = pickerView
    }

    @IBAction func buttonOK(_ sender: UIButton) {

        if let percent = TFPercent.text, let number = TFNumber.text, percent.isEmpty || number.isEmpty {

            // создание всплывающих алертов в случае пустых полей
            let alert = UIAlertController(title: "Не заполнено поле", message: "Пожалуйста, заполните все поля.", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            alert.addAction(okAction)
            present(alert, animated: true, completion: nil)
        } else {

            let number = (Double(TFNumber.text!)!)
            let percent = (Double(TFPercent.text!)!)
            let resultOfVAT = Double()

            switch selectedIndex {
            case 0:
                let calcValue = calcPercentFromNumber(number: number, percent: percent)
                labelResult.text = "\(TFPercent.text!)% от числа \(TFNumber.text!) = \(calcValue)"
                break

            case 1:
                let calcValue = calcPercentNumberFromNumber(number: number, percent: percent)
                labelResult.text = "Число \(TFPercent.text!) от числа \(TFNumber.text!) = \(calcValue)%"
                break

            case 2:
                let calcValue = calcAddPercentToNumber(number: number, percent: percent)
                labelResult.text = "\(TFNumber.text!) + \(TFPercent.text!)% = \(calcValue)"
                break

            case 3:
                let calcValue = calcMinusVAT(number: number, percent: percent)
                let calcVAT = calcVATFromMinusVAT(number: number, percent: percent, result: resultOfVAT)
                labelResult.text =  """
                                    Сумма без НДС = \(calcValue)
                                    Сумма НДС = \(calcVAT)
                                    """
                break

            case 4:
                let calcValue = calcPlusVAT(number: number, percent: percent)
                let calcVAT = calcVATFromPlusVAT(number: number, percent: percent, result: resultOfVAT)
                labelResult.text =  """
                                    Сумма с НДС = \(calcValue)
                                    Сумма НДС = \(calcVAT)
                                    """
                break

            default:
                break
            }
        }
    }

    func calcPercentFromNumber (number: Double, percent: Double) -> Double {
        let result = number * 0.01 * percent
        return result
    }

    func calcPercentNumberFromNumber (number: Double, percent: Double) -> Double {
        let result = (percent / number) * 100
        return result
    }

    func calcAddPercentToNumber (number: Double, percent: Double) -> Double {
        let result = number * (1 + percent / 100)
        return result
    }

    func calcMinusVAT (number: Double, percent: Double) -> Double {
        var result = number / (1 + percent / 100)
        result = (result * 100).rounded() / 100
        return result
    }

    func calcVATFromMinusVAT (number: Double, percent: Double, result: Double) -> Double {
        var resultOfVAT = number - (number / (1 + percent / 100))
        resultOfVAT = (resultOfVAT * 100).rounded() / 100
        return resultOfVAT
    }

    func calcPlusVAT (number: Double, percent: Double) -> Double {
        var result = number * (1 + percent / 100)
        result = (result * 100).rounded() / 100
        return result
    }

    func calcVATFromPlusVAT (number: Double, percent: Double, result: Double) -> Double {
        var resultOfVAT = (number * (1 + percent / 100)) - number
        resultOfVAT = (resultOfVAT * 100).rounded() / 100
        return resultOfVAT
    }

    @IBAction func buttonCancel(_ sender: UIButton) {
        TFPercent.text = ""
        TFNumber.text = ""
        labelResult.text = "Здесь отобразится результат!"
        selectOperation.text = "Нажмите для выбора операции"

        view.endEditing(true) //убирает клавиатуру при нажатии кнопки "Сброс"
    }

    // Метод скрытия клавиатуры при нажатии на любое место на экране
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
}

extension ViewController: UIPickerViewDataSource, UIPickerViewDelegate {

    public func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    public func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return uiElements.count
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return uiElements[row]
    }

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {

        selectOperation.text = uiElements[row]
        selectedIndex = row

        switch row {
        case 0:
            percentLabel.isHidden = false
            firstLabel.isHidden = false
            secondLabel.isHidden = false

            firstLabel.text = "Сколько составляет"
            secondLabel.text = "от числа"

            break

        case 1:
            percentLabel.isHidden = true
            firstLabel.isHidden = false
            secondLabel.isHidden = false

            firstLabel.text = "Сколько составляет"
            secondLabel.text = "от числа"

            break

        case 2:
            percentLabel.isHidden = false
            firstLabel.text = "Прибавить"
            secondLabel.text = "к числу"

            break

        case 3:
            percentLabel.isHidden = false
            firstLabel.isHidden = false
            secondLabel.isHidden = false
            firstLabel.text = "Ставка НДС"
            secondLabel.text = "Выделить НДС от числа"

            break

        case 4:
            percentLabel.isHidden = false
            firstLabel.isHidden = false
            secondLabel.isHidden = false
            firstLabel.text = "Ставка НДС"
            secondLabel.text = "Начислить НДС к числу"

            break

        default:
            break
        }
    }
}

//отключена функция Paste при долгом нажатии на поле для ввода текста
class TextField: UITextField {

    override func canPerformAction(_ action: Selector, withSender sender: Any?) -> Bool {
        if action == #selector(UIResponderStandardEditActions.paste(_:)) {
            return false
        }
        return super.canPerformAction(action, withSender: sender)
    }
}

//отключение мигающего курсора
class SelectOperation: UITextField {

    override func caretRect(for position: UITextPosition) -> CGRect {
        return CGRect.zero
    }
}


