class AppController < ApplicationController
  include ActionView::Helpers::AssetUrlHelper
  include ActionView::Helpers::AssetTagHelper
  include ActionView::Helpers::JavaScriptHelper

  respond_to :html

  def webpack_manifest_script
    return '' unless Rails.configuration.webpack[:use_manifest]
    javascript_tag "window.webpackManifest = #{Rails.configuration.webpack[:common_manifest].to_json}"
  end
  helper_method :webpack_manifest_script

  def webpack_bundle_tags
    config = Rails.configuration.webpack
    base_path = "#{compute_asset_host}/assets"

    return javascript_include_tag "#{base_path}-bundle" unless config[:use_manifest]

    config[:common_manifest].map do |_key, filename|
      javascript_include_tag("#{base_path}/#{filename}")
    end.join.html_safe
  end
  helper_method :webpack_bundle_tags
end
