# Markety
Easily integrate with the Marketo SOAP API to find and update leads.

This gem is a fork of the original Marketo gem but has been updated to work with savon 2.3.0. Note that there is a dependency issue with both the savon and wasabi gems requiring nokogiri < 1.6 to maintain support for Ruby 1.8 so if you're already running nokogiri 1.6, you'll probably run into problems when you execute bundle install. The issue has been fixed for both gems but the update has not been pushed to rubygems.org so the work around is to use bundler to install Savon and Wasabi directly from GitHub. [Savon version 2 branch](https://github.com/savonrb/savon/tree/version2) | [Wasabi](https://github.com/savonrb/savon/tree/version2)

Here's the specific [issue](https://github.com/savonrb/savon/issues/487). The savon gem should be updated on rubygems.org later this week so the dependency issue will be resolved and you won't need to install savon or wasabi from GitHub.

## Install
For now, add this your Gemfile:

```ruby
gem "savon", :git => "git://github.com/savonrb/savon.git", :branch => :version2
gem "wasabi", :git => "https://github.com/savonrb/wasabi.git"
gem 'markety'
```

and run bundle install.

The savon and wasabi gems must be installed via GitHub to avoid the nokogiri 1.6 dependency issue.

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