package 'ssmtp'
package 'mailutils'

template "/etc/ssmtp.conf" do
  source "ssmtp.conf.erb"
  owner "root"
  group "root"
  mode "0600"
end

