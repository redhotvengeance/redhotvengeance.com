task :default => :dev

desc "Initiate dev environment"
task :dev do
    Rake::Task["build"].invoke
    Rake::Task["open"].invoke
    Rake::Task["server"].invoke(false)
end

desc "Build Jekyll site"
task :build do
    sh %{jekyll}, :verbose => false
end

desc "Start local server"
task :server do
  sh %{foreman start}, :verbose => false
end

desc "Open local site"
task :open do
    `open http://localhost:4567/`
end
