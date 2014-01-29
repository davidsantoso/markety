# Markety
Easily integrate with the Marketo SOAP API to find and update leads.

This is a fork off of the [Rapleaf marketo_gem] (https://github.com/Rapleaf/marketo_gem) but has been updated to work with Savon v2.3.1. It makes connecting to your Marketo database to find and update leads a snap. If you're having problems connecting to Marketo, please submit an issue as there have been lots of changes with [Savon] (https://github.com/savonrb/savon) lately.

## Install
Add this your Gemfile:

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

# Update a lead record
lead.set_attribute("Email", "joe-schmoe@example.com")

# Update a lead record with an attribute that isn't a string
lead.set_attribute("Activated", true, "Boolean")

# Sync the lead with Marketo
response = client.sync_lead_record(lead)

# Check your lead database in Marketo to see the changes!
```

## Help and Docs

* I still have to write some official documentation.