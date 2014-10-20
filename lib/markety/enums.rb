module Markety
  # Types of keys that can be used to look up a lead.
  # (Other key types exist, but Markety only supports these at this time.)
  module LeadKeyType
    IDNUM           = "IDNUM"
    EMAIL           = "EMAIL"

#    COOKIE          = "COOKIE"
#    LEADOWNEREMAIL  = "LEADOWNEREMAIL"
#    SFDCACCOUNTID   = "SFDCACCOUNTID"
#    SFDCCONTACTID   = "SFDCCONTACTID"
#    SFDCLEADID      = "SFDCLEADID"
#    SFDCLEADOWNERID = "SFDCLEADOWNERID"
#    SFDCOPPTYID     = "SFDCOPPTYID"
  end

  # a parameter type to Markety::Command::SyncLead
  module SyncMethod
    MARKETO_ID = "MARKETO_ID"
    FOREIGN_ID = "FOREIGN_ID"
    EMAIL = "EMAIL"
  end
end
