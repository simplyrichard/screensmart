namespace :webpack do
  desc 'compile bundles using webpack'
  task :compile => [:npm_install] do
    system "#{webpack_command} --config config/webpack/production.config.js --json"

    stats = JSON.parse(output)

    File.open('./public/assets/webpack-asset-manifest.json', 'w') do |f|
      f.write stats['assetsByChunkName'].to_json
    end
  end

  task :npm_install do
    system 'npm install'
  end

  def webpack_command
    'node node_modules/webpack/bin/webpack.js'
  end
end
