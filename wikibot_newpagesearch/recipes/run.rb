include_recipe "ec2foo::awscli"
include_recipe "wikibot_newpagesearch::configure"
include_recipe "wikibot_newpagesearch::deploy"

cron "newpagefetch" do
	minute "*/10"
	action "create"
	user "root"
	command %Q{
/usr/local/bin/aws s3 get-object --bucket tedderbot-wikitools --region us-west-2 --key newpagesearch/wiki-articles.data /opt/tedderbot/wiki-articles.data >> /opt/tedderbot/s3.log && 
/usr/bin/java -cp /opt/tedderbot/ -cp /opt/tedderbot/NewPageFetcherApplication_lib/ -jar /opt/tedderbot/NewPageFetcherApplication.jar /opt/tedderbot/AwsCredentials.properties /opt/tedderbot/wiki.properties >> /opt/tedderbot/run.log
aws s3 put-object --bucket tedderbot-wikitools --region us-west-2 --key newpagesearch/appbundle.tgz /opt/tedderbot/appbundle.tgz >> /opt/tedderbot/s3.log
shutdown -h +10 "shutdown via chef/opsworks recipe"
}
end

