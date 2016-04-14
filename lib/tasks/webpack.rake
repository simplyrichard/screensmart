namespace :webpack do
  desc 'compile bundles using webpack'
  task :compile => [:ensure_installed] do
    cmd = "#{binary_path} --config config/webpack/production.config.js --json"
    output = `#{cmd}`

    stats = JSON.parse(output)

    File.open('./public/assets/webpack-asset-manifest.json', 'w') do |f|
      f.write stats['assetsByChunkName'].to_json
    end
  end

  task :ensure_installed do
    already_installed = binary_path.present?
    next if already_installed

    system 'npm install -g webpack'
  end

  def binary_path
    `which webpack`.strip
  end
end
