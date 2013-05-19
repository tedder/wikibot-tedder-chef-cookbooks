include_recipe "ec2foo::awscli"
include_recipe "wikibot_newpagesearch::configure"
include_recipe "wikibot_newpagesearch::deploy"

execute "shutdown" do
	action :nothing
	command %Q{shutdown -h +10 "shutdown via chef/opsworks recipe"}
end

execute "upload_cache" do
	action :nothing
	not_if {File.exists?("/opt/tedderbot/appbundle.tgz")}
	command %Q{aws s3 get-object --bucket tedderbot-wikitools --region us-west-2 --key newpagesearch/appbundle.tgz /opt/tedderbot/appbundle.tgz}
	notifies :run, resources(:execute => "shutdown"), :delayed
end

execute "runner" do
	action :nothing
  command %Q{java -cp /opt/tedderbot/ -cp /opt/tedderbot/NewPageFetcherApplication_lib/ -jar /opt/tedderbot/NewPageFetcherApplication.jar /opt/tedderbot/AwsCredentials.properties /opt/tedderbot/wiki.properties >> /opt/tedderbot/run.log 2>&1 }
	notifies :run, resources(:execute => "upload_cache")
end

execute "download_cache" do
	not_if {File.exists?("/opt/tedderbot/wiki-articles.data")}
	command %Q{aws s3 get-object --bucket tedderbot-wikitools --region us-west-2 --key newpagesearch/wiki-articles.data /opt/tedderbot/wiki-articles.data}
	notifies :run, resources(:execute => "runner"), :delayed
end


