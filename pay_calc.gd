extends Node2D

@onready var pay_input: SpinBox = $In/PayInput
@onready var tithe_input: SpinBox = $In/TitheInput
@onready var savings_input: SpinBox = $In/SavingsInput
@onready var invest_input: SpinBox = $In/InvestInput
@onready var invest_division_input: SpinBox = $In/InvestDivisionInput


@onready var spending_out: Label = $Out/SpendingOut
@onready var tithe_out: Label = $Out/TitheOut
@onready var savings_out: Label = $Out/SavingsOut
@onready var invest_out: Label = $Out/InvestOut
@onready var percent_out: Label = $PercentOut
@onready var total_savings_invest_out: Label = $Out/TotalSavingsInvestOut

var spending_amount: float = 0.0
var tithe_amount: float = 0.0
var savings_amount: float = 0.0
var invest_amount: float = 0.0
var invest_divided_amount: float = 0.0

func _process(delta: float) -> void:
	
	var tithe_in: float = (tithe_input.value / 100.0)
	var savings_in: float = (savings_input.value / 100.0)
	var invest_in: float = (invest_input.value / 100.0)
	
	if (tithe_input.value + savings_input.value + invest_input.value) > 100.0:
		savings_input.value = savings_input.value - 1
		if savings_input.value == 0 and (tithe_input.value + savings_input.value + invest_input.value) > 100.0:
			invest_input.value = invest_input.value - 1
	
	tithe_amount = pay_input.value * tithe_in
	savings_amount = (pay_input.value - tithe_amount) * savings_in
	invest_amount = (pay_input.value - tithe_amount) * invest_in
	invest_divided_amount = invest_amount / invest_division_input.value
	spending_amount = (pay_input.value - tithe_amount - savings_amount - invest_amount)
	
	update_outputs()



func update_outputs():
	percent_out.text = "Total Percent Taken: " + str("%1.0f" % (tithe_input.value + savings_input.value + invest_input.value)) + str("%")
	
	spending_out.text = "Spending: $" + str("%.2f" % spending_amount)
	
	tithe_out.text = "Tithe: $" + str("%.2f" % tithe_amount)
	
	savings_out.text = "Savings: $" + str("%.2f" % savings_amount)
	
	if invest_divided_amount < invest_amount:
		invest_out.text = "Invest: $" + str("%.2f" % invest_amount) + "  |  " + str("%.2f" % invest_divided_amount) + "  x  " + str("%1.0f" % invest_division_input.value)
	else:
		invest_out.text = "Invest: $" + str("%.2f" % invest_amount)
		
	total_savings_invest_out.text = "Savings and Invest: $" +  str("%.2f" % (savings_amount + invest_amount))
