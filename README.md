# Markety
===========
Easily integrate with the Marketo SOAP API to find and update leads.

This gem is a fork of the original Marketo gem but has been updated to work with Sevon 2.3.0. Note, that there is a nokogiri dependency issue with most gems requiring version 1.6 but Savon still locked down to < 1.6. If you're already running nokogiri 1.6 then you'll probably run into problems when you run bundle install.

===========

## Install

```
gem install markety
```

## Examples

```ruby
# Instantiate a new Markety client using your Marketo SOAP endpoint, User ID, and Encryption Key
client = Markety.new_client(USER_ID, ENCRYPTION_KEY, END_POINT) 

# Get a lead from the Marketo database
lead = client.get_lead_by_email("joe@example.com")

# Update a lead record and sync
lead.set_attribute("Email", "joe-schmoe@example.com")
response = client.sync_lead_record(lead)

# Check your lead database in Marketo to see the changes!
```

## Help and Docs

* I still have to write some official documentation