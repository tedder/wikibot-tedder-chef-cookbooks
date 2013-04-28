directory "/opt/wikibacon" do
	owner "ubuntu"
	group "ubuntu"
	mode 0755
	action :create
end

deploy_revision "/opt/wikibacon" do
	repo "git://github.com/tedder/wikibacon.git"
	#symlinks("cron" => "/etc/cron.d/blah")
	#notifies
end
