module Markety
  # Types of operations you can do on a marketo list
  module ListOperationType
    ADD_TO       = 'ADDTOLIST'
    REMOVE_FROM  = 'REMOVEFROMLIST'
    IS_MEMBER_OF = 'ISMEMBEROFLIST'
  end

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

  # a parameter type to <tt>Markety::Command::SyncLead</tt>
  module SyncMethod
    MARKETO_ID = "MARKETO_ID"
    FOREIGN_ID = "FOREIGN_ID"
    EMAIL = "EMAIL"
  end
end
