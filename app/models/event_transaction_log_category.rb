class EventTransactionLogCategory
  IDS = 101..110
  MESSAGES = { 101 => "Opening Balance", 
               102 => "Contribution (%d) from (%s) (%d)", 
               103 => "Deduct CC fee from Contribution (%d)", 
               104 => "Deduct SYW fee from Contribution (%d)",
               105 => "Gift Fund Allocation from Contribution (%d)",
               106 => "Donation Fund Allocation from Contribution (%d)",
               107 => "Purchase",
               108 => "Gift Fund Disbursement",
               109 => "Donation Fund Disbursement",
               110 => "SYW Fund Disbursement"
             }
end
