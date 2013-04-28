#
# Cookbook Name:: wikibot_all_project_pages
# Recipe:: default
#
# Copyright 2013, Ted Timmons, MIT license
#

include_recipe 'perl'
package 'libtime-modules-perl' # Time::ParseDate
package 'libmediawiki-api-perl' # MediaWiki::API

