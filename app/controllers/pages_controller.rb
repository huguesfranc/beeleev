class PagesController < ApplicationController
  Dir[Rails.root + 'app/views/pages/*.html.erb'].each do |action|
    define_method(File.basename(action, '.html.erb')) {}
  end
end
