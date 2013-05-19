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

cron "current" do
	hour "7"
	mailto "ted@perljam.net"
	action :create
  command %Q{java -cp NewPageFetcherApplication_lib/ -jar NewPageFetcherApplication.jar  AwsCredentials.properties wiki.properties >> /var/log/tedderbot.log 2>&1 }
	#command %Q{/usr/bin/perl -I /opt/wikibacon/shared/cached-copy/ /opt/wikibacon/shared/cached-copy/bin/current.pl --userfile=/opt/wikibacon/wiki.conf >> /var/log/wikibacon.log 2>&1 }
end


