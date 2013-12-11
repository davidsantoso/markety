# Markety
Easily integrate with the Marketo SOAP API to find and update leads.

Unfortunately this gem isn't working. The savon gem to build to SOAP request does not seem to properly set the operation based off of the WSDL file. I've submitted an [issue](https://github.com/savonrb/savon/issues/530) so hopefully it's resolved soon.

## Install
For now, add this your Gemfile:

```ruby
gem 'markety'
```

and run bundle install.

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

* I still have to write some official documentation.