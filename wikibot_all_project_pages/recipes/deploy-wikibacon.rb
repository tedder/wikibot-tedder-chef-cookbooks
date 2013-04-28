
deploy_revision "/opt/wikibacon" do
	repo "git://github.com/tedder/wikibacon.git"
	#symlinks("cron" => "/etc/cron.d/blah")
	#notifies
end
