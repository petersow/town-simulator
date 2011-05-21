require 'bundler'
Bundler.setup
Bundler::GemHelper.install_tasks

require 'rake'

task :default => [:gem]
#[:clean, :test, :gem]

task :clean do
 # rm_rf "pkg"
end

task :test do
  Spec::Rake::SpecTask.new('spec') do |t|
    t.spec_files = FileList['spec/**/*.rb']
  end
end

task :gem => :build
