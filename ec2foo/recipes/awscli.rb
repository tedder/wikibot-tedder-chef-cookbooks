depends 'python'
include_recipe 'python'
include_recipe 'python::pip'

package 'python'
python_pip 'aws-cli'

