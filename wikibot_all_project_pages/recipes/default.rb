#
# Cookbook Name:: wikibot_all_project_pages
# Recipe:: default
#
# Copyright 2013, Ted Timmons, MIT license
#

include_recipe perl
depends 'libtime-modules-perl' # Time::ParseDate
depends 'libmediawiki-api-perl' # MediaWiki::API

