include_recipe "ec2foo::awscli"
include_recipe "wikibot_newpagesearch::configure"
include_recipe "wikibot_newpagesearch::deploy"

template "/opt/tedderbot/tryrun.sh" do
	source "tryrun.sh.erb"
	owner "ubuntu"
	group "ubuntu"
	mode "0755"
end

template "/etc/cron.d/newpagesearch" do
	source "cron-newpagesearch.erb"
	owner "ubuntu"
	group "ubuntu"
	mode "0644"
end


