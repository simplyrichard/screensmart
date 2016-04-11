class AppController < ApplicationController
  include ActionView::Helpers::AssetUrlHelper
  include ActionView::Helpers::AssetTagHelper
  include ActionView::Helpers::JavaScriptHelper

  respond_to :html

  def webpack_bundle_tag
    src =
      if Rails.configuration.webpack[:use_manifest]
        "#{compute_asset_host}/assets/bundle"
      else
        "#{compute_asset_host}/assets/#{bundle}-bundle"
      end

    javascript_include_tag(src)
  end
  helper_method :webpack_bundle_tag

  def webpack_manifest_script
    return '' unless Rails.configuration.webpack[:use_manifest]
    javascript_tag "window.webpackManifest = #{Rails.configuration.webpack[:common_manifest]}"
  end
  helper_method :webpack_manifest_script
end
