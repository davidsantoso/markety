# Markety

# This is a somewhat heavily-modified fork of [David Santoso's gem](https://github.com/davidsantoso/markety).

I haven't decided what will happen with these changes beyond my immediate need.
I might contribute back, I might fork a new gem, or I might forget it.  Dunno.


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
leads = client.get_lead_by_email("joe@example.com").leads

# Update a lead record
lead.set_attribute("Email", "joe-schmoe@example.com")

# Update a lead record with an attribute that isn't a string
lead.set_attribute("Activated", true, "Boolean") # [1]

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

Marketo is releasing a new REST API to manage leads on June 20, 2014 so be sure to check developers.marketo.com after that date for another lead management integration possibility. Markety will still be under active development for other Marketo API actions that are not yet supported with their REST API.
