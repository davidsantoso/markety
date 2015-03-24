# Markety

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

and run `bundle install`.

##  Getting Started

Instantiate a new Markety client using your Marketo SOAP endpoint, User ID, and Encryption Key
```ruby
client = Markety::Client.new(USER_ID, ENCRYPTION_KEY, END_POINT)
# or, if using a workspace:
client = Markety::Client.new(USER_ID, ENCRYPTION_KEY, END_POINT, target_workspace: "ws_name")
```

You can get leads from Marketo by idnum or by email. Markety returns a ``GetLeadResponse``
object which contains an array of leads.  Because Marketo allows for an email address to be
tied to more than one lead, getting by email could potentially result in an array of leads
with the same email address so you can call ``.leads`` to get all the leads in the array.
Getting a lead by idnum will return a single lead, however because ``GetLeadResponse`` is
an array of leads, you'll need to add ``.lead`` to get the lead from the response.
```ruby
# By idnum
lead = client.get_lead_by_idnum("123456").lead  # Single lead object (or nil)

# By email
leads = client.get_leads_by_email("joe@example.com").leads  # array of Leads
```

After getting your leads, you can update their attributes before syncing.
```ruby
# Update a leads email address
lead.set_attribute("Email", "joe-schmoe@example.com")

# Update a lead record with an attribute that isn't a string
lead.set_attribute("Activated", true, "Boolean") # [1] see below
```

Once you're ready to sync back, just tell Markety how you'd like it to sync.
There are currently 3 supported methods, "EMAIL", "MARKETO_ID" and "FOREIGN_ID"
```
# Sync the lead with Marketo
response = client.sync_lead(lead, "EMAIL")
```

There are a few available list operations available at the moment. Be sure to pass in the lead
idnum and not the lead itself to run the query.
 ```ruby
# Check if a lead is on a list
client.is_member_of_list('The_List_Name', lead.idnum).list_operation_status? # true if on list
# (alternately, you can use `list_op_status?` or `lop_status?` to save some keystrokes)

# Add a lead to a particular list
client.add_to_list('The_List_Name', lead.idnum).list_operation_status #true if successful add

# Remove a lead from a particular list
client.remove_from_list('The_List_Name', lead.idnum).list_operation_status #true if successful removal
```

If you would like to create a lead in Marketo, you can use the sync lead method the same way
you would use the sync lead to update a lead. Just start by instantiating a Markety::Lead.
```ruby
new_lead = Markety::Lead.new
new_lead.set_attribute("Email", "doge@suchemail.com")
response = client.sync_lead(new_lead, "EMAIL")
```

Be sure you have the correct attribute fields. You can find those in your Market Admin dashboard.

[1] Note that [the Marketo API does not let you create custom fields] (https://community.marketo.com/MarketoDiscussionDetail?id=90650000000PpyEAAS#j_id0:j_id2:j_id9:j_id10:apexideas:j_id248) at this time. In order to set a custom attribute through the API, it must first be added from the Admin interface.
_(Admin » Field Management » New Custom Field)_

### Custom Objects
You can also create and fetch Marketo custom object instances. Marketo custom objects allow you to
have a one-to-many relationship between your marketo leads and the custom object. You will need to
have custom objects set up in your account before you can create or get them.

Each custom object has their own unique key and foreign key which can be used as identifiers.
You can find all the custom objects that belong to a particular lead, or find a custom object
with a specific id.
```
# getting a custom object
custom_object = client.get_custom_object_by_keys("Roadshow", {"MKTOID" => 1090177, "rid" => 123456})
```

You can create your own custom object easily by specifying the object type name, keys and attributes
```
# creating a custom object
custom_object = Markety::CustomObject.new(
    object_type_name: "Roadshow",
    keys: {"MKTOID" => 1090177, "rid" => "rid1"},
    attributes: {"city" => "SanMateo", "zip" => 94404 })
```

Once you've created your custom object, you can sync it up and specify either the "INSERT", "UPDATE"
or "UPSERT" operations (the default is "UPSERT" if no operation is specified).
```
# syncing a custom object
response = client.sync_custom_object(custom_object, "UPSERT")
```

For more information about custom objects, check out http://developers.marketo.com/documentation/soap/custom-object-operations/

##  Options

```ruby
# Turn off Savon logging - logging is helpful during development,
# but outputs a lot of text which you may not want in production
client = Markety::Client.new(USER_ID, ENCRYPTION_KEY, END_POINT, { log: false })
```

## Contributing

PRs are very welcome! Feel free to send a PR for any endpoint you might need.

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

###Dev hint:

In `irb`, from this repo's root dir, this will load the Markety classes:

    > $LOAD_PATH.unshift "./lib"
    > require 'markety'


## To Do's
1. More tests.
2. Add campaign endpoints.

##  Marketo Lead REST API

Marketo released a lead REST API on June 20, 2014 so be sure to check developers.marketo.com
for another lead management integration possibility.

## Authors
David Santoso and [Grant Birchmeier](https://github.com/gbirchmeier).
