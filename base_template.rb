if yes? "Copy base templates?"  
  run "cp /Users/ap/code/app_template/layouts/application.html.erb app/views/layouts/"
  run "cp /Users/ap/code/app_template/helpers/layout_helper.rb app/helpers/"
  run "cp /Users/ap/code/app_template/stylesheets/* public/stylesheets/"
  run "touch public/stylesheets/application.css"
end

if yes? "Use authentication and authorization?"
  gem "authlogic"
  gem "declarative_authorization", :source => "http://gemcutter.org"
end

if yes? "Use russian pack?"
  gem "russian"
  gem "rutils"
end

if yes? "Need search functionality?"
  gem "searchlogic"
end

rake "gems:install", :sudo => true

file ".gitignore", <<-END
.DS_Store
log/*.log
tmp/**/*
config/database.yml
db/*.sqlite3
END

run "touch tmp/.gitignore log/.gitignore vendor/.gitignore"
run "cp config/database.yml config/example_database.yml"

generate :controller, "welcome index"
route "map.root :controller => 'welcome'"
run "rm public/index.html"
git :rm => "public/index.html"

git :init
git :add => ".", :commit => "-m 'initial commit'"
