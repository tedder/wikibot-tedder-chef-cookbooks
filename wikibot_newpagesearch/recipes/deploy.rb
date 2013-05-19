directory "/opt/tedderbot" do
	owner "ubuntu"
	group "ubuntu"
	mode 0755
	action :create
end

directory "/opt/tedderbot/shared" do
	owner "ubuntu"
	group "ubuntu"
	mode 0755
	action :create
end

deploy_revision "/opt/tedderbot" do
	repo "git://github.com/tedder/TedderBot.git"
	symlinks("bin" => "bin")
	symlink_before_migrate.clear # we don't have config/database.yml
	purge_before_symlink.clear()
	#notifies
end

template "/opt/tedderbot/AwsCredentials.properties" do
	source "AwsCredentials.properties.erb"
	owner "ubuntu"
	group "ubuntu"
	mode "0600"
end

template "/opt/tedderbot/wiki.properties" do
	source "wiki.properties.erb"
	owner "ubuntu"
	group "ubuntu"
	mode "0600"
end

template "/opt/tedderbot/ehcache.xml" do
	source "ehcache.xml.erb"
	owner "ubuntu"
	group "ubuntu"
	mode "0644"
end

include_recipe "ec2foo::awscli"

execute "download_tar" do
	not_if {File.exists?("/opt/tedderbot/appbundle.tgz")}
	command %Q{aws s3 get-object --bucket tedderbot-wikitools --region us-west-2 --key newpagesearch/appbundle.tgz /opt/tedderbot/appbundle.tgz}
end


execute "extract_tar" do
	not_if {File.exists?("/opt/tedderbot/NewPageFetcherApplication.jar")}
	command %Q{tar -C /opt/tedderbot/ -zxvf /opt/tedderbot/appbundle.tgz}
end


