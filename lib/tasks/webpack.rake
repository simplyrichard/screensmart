namespace :webpack do
  desc 'compile bundles using webpack'
  task :compile => [:ensure_webpack_installed, :npm_install] do
    cmd = "#{binary_path} --config config/webpack/production.config.js --json"
    output = `#{cmd}`

    stats = JSON.parse(output)

    File.open('./public/assets/webpack-asset-manifest.json', 'w') do |f|
      f.write stats['assetsByChunkName'].to_json
    end
  end

  task :npm_install do
    system 'npm install'
  end

  task :ensure_webpack_installed do
    next if installed?

    system 'npm install -g webpack'
    raise 'Something went wrong installing webpack' unless installed?
  end

  def installed?
    binary_path.present?
  end

  def binary_path
    puts `which webpack`
    `which webpack`.strip
  end
end
