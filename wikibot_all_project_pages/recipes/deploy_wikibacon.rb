
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
	symlink_before_migrate nil # we don't have config/database.yml
	#notifies
end

template "/opt/wikibacon/wiki.conf" do
	source "wiki.conf.erb"
	owner "ubuntu"
	group "ubuntu"
	mode "0600"
end

