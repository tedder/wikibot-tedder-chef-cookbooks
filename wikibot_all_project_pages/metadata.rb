name             'wikibot_all_project_pages'
maintainer       'Inervo Networks'
maintainer_email 'ted+wikibot@perljam.net'
license          'MIT'
description      'Installs/Configures wikibot_all_project_pages'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          '0.1.0'

depends 'perl'
depends 'libtime-modules-perl' # Time::ParseDate
depends 'libmediawiki-api-perl' # MediaWiki::API

