if Rails.configuration.webpack[:use_manifest]
  common_manifest = Rails.root.join('public', 'assets', 'webpack-common-manifest.json')

  if File.exist?(common_manifest)
    Rails.configuration.webpack[:common_manifest] = JSON.parse(
      File.read(common_manifest)
    ).with_indifferent_access
  end
end
