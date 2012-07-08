require 'rubygems'
require 'sinatra'

set :public_folder, File.dirname(__FILE__) + '/public'
set :static, true

get '*' do
  send_file File.join(settings.public_folder, request.path, 'index.html')
end

not_found do
  send_file File.join(settings.public_folder, '404', 'index.html')
end
