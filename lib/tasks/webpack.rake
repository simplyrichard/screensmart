namespace :webpack do
  desc 'compile bundles using webpack'
  task :compile => [:npm_install] do
  end

  task :npm_install do
    system 'npm install'
  end
end
