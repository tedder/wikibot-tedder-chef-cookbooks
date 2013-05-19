# great list of configurations here:
# https://gist.github.com/jtimberman/1718805

node_name "tedder"
client_key "/Users/tedder/.ssh/id_rsa"

#cookbook_path [ "#{File.dirname(__FILE__)}/../cookbooks" ]
#cookbook_path [ "/var/chef/cookbooks" ]
cookbook_path [ "/Users/tedder/git/wikibot-tedder-chef-cookbooks" ]

cookbook_email "ted@perljam.net"

cookbook_license "mit"

knife[:flavor] = 'm1.small'
knife[:region] = 'us-west-2'
