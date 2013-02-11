require 'rubygems'
require 'rake/clean'

CLEAN.include(['spec/fixtures/'])
CLOBBER.include('.tmp', '.librarian')

require 'puppetlabs_spec_helper/rake_tasks'

task :librarian_spec_prep do
 sh "librarian-puppet install --path=spec/fixtures/modules/"
end
task :spec_prep => :librarian_spec_prep
task :default => :spec