task :default => :dev

desc "Initiate dev environment"
task :dev do
  Rake::Task["open"].invoke
  Rake::Task["server"].invoke(false)
end

desc "Build Jekyll site"
task :build do
  sh %{bundle exec jekyll build}, :verbose => false
end

desc "Start local server"
task :server do
  sh %{bundle exec jekyll serve}, :verbose => false
end

desc "Open local site"
task :open do
  `open http://localhost:4000/`
end
