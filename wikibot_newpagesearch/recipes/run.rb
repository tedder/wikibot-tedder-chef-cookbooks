include_recipe "ec2foo::awscli"
include_recipe "deploy"

execute "download_cache" do
	not_if {File.exists?("/opt/tedderbot/wiki-articles.data")}
	command %Q{aws s3 get-object --bucket tedderbot-wikitools --region us-west-2 --key newpagesearch/wiki-articles.data /opt/tedderbot/wiki-articles.data}
	notifies :run, "execute[runner]"
end

execute "runner" do
	action :nothing
  command %Q{java -cp /opt/tedderbot/ -cp /opt/tedderbot/NewPageFetcherApplication_lib/ -jar /opt/tedderbot/NewPageFetcherApplication.jar /opt/tedderbot/AwsCredentials.properties /opt/tedderbot/wiki.properties >> /opt/tedderbot/run.log 2>&1 }
	notifies :run, "execute[upload_cache]"
end

execute "upload_cache" do
	action :nothing
	not_if {File.exists?("/opt/tedderbot/appbundle.tgz")}
	command %Q{aws s3 get-object --bucket tedderbot-wikitools --region us-west-2 --key newpagesearch/appbundle.tgz /opt/tedderbot/appbundle.tgz}
end

