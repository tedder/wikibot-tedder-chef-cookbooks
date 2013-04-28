#
# Cookbook Name:: wikibot_all_project_pages
# Recipe:: default
#
# Copyright 2013, Ted Timmons, MIT license
#

package 'perl' do
	action :install
end

# Time::ParseDate
package 'libtime-modules-perl' do
	action :install
end

# MediaWiki::API
package 'libmediawiki-api-perl' do
	action :install
end

