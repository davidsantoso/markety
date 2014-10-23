# Markety

This is a heavily-modified fork of [David Santoso's gem](https://github.com/davidsantoso/markety).

The plan is to PR it back to him, and it'll be version 2.

<!--
[![Build Status](https://travis-ci.org/davidsantoso/markety.svg?branch=master)](https://travis-ci.org/davidsantoso/markety)
[![Gem Version](https://badge.fury.io/rb/markety.svg)](http://badge.fury.io/rb/markety)
[![Coverage Status](https://coveralls.io/repos/davidsantoso/markety/badge.png)](https://coveralls.io/r/davidsantoso/markety)
-->

Easily integrate with the Marketo SOAP API to find and update leads.

## Install
Add this your Gemfile:

```ruby
gem 'markety'
```

and run bundle install.

##  Examples


```ruby
# Instantiate a new Markety client using your Marketo SOAP endpoint, User ID, and Encryption Key
client = Markety.new_client(USER_ID, ENCRYPTION_KEY, END_POINT)
# or, if using a workspace:
client = Markety.new_client(USER_ID, ENCRYPTION_KEY, END_POINT, target_workspace: "ws_name")

# Get leads from the Marketo database
lead = client.get_lead_by_idnum("123456").lead              # Lead object (or nil)
leads = client.get_leads_by_email("joe@example.com").leads  # array of Leads

# Update a lead record
lead.set_attribute("Email", "joe-schmoe@example.com")

# Update a lead record with an attribute that isn't a string
lead.set_attribute("Activated", true, "Boolean") # [1] see below

# Sync the lead with Marketo
response = client.sync_lead_record(lead)

# Check if a lead is on a list
client.is_member_of_list('The_List_Name', lead.idnum).list_operation_status? #true if on list
# (alternately, you can use `list_op_status?` or `lop_status?` to save some keystrokes)

# Add a lead to a particular list
client.add_to_list('The_List_Name', lead.idnum).list_operation_status #true if successful add

# Remove a lead from a particular list
client.remove_from_list('The_List_Name', lead.idnum).list_operation_status #true if successful removal
```

[1] Note that [the Marketo API does not let you create custom fields] (https://community.marketo.com/MarketoDiscussionDetail?id=90650000000PpyEAAS#j_id0:j_id2:j_id9:j_id10:apexideas:j_id248) at this time. In order to set a custom attribute through the API, it must first be added from the Admin interface.
_(Admin » Field Management » New Custom Field)_

##  Options

```ruby
# Turn of Savon logging - logging is helpful during development, but outputs a lot of text which you may not want in production
client = Markety.new_client(USER_ID, ENCRYPTION_KEY, END_POINT, { log: false })
```

##  Marketo Lead REST API

Marketo released a lead REST API on June 20, 2014 so be sure to check developers.marketo.com for another lead management integration possibility.
