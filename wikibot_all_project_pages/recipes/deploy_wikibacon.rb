
directory "/opt/wikibacon" do
	owner "ubuntu"
	group "ubuntu"
	mode 0755
	action :create
end

directory "/opt/wikibacon/shared" do
	owner "ubuntu"
	group "ubuntu"
	mode 0755
	action :create
end

deploy_revision "/opt/wikibacon" do
	repo "git://github.com/tedder/wikibacon.git"
	symlinks("bin" => "bin")
	symlink_before_migrate.clear # we don't have config/database.yml
	purge_before_symlink.clear()
	#notifies
end


template "/opt/wikibacon/wiki.conf" do
	source "wiki.conf.erb"
	owner "ubuntu"
	group "ubuntu"
	mode "0600"
end

cron "current" do
	hour "*"
	minute "*/20"
	mailto "ted@perljam.net"
	action :create
	command %Q{/usr/bin/perl -I /opt/wikibacon/shared/cached-copy/ /opt/wikibacon/shared/cached-copy/bin/current.pl --userfile=/opt/wikibacon/wiki.conf >> /var/log/wikibacon.log 2>&1 }
end
