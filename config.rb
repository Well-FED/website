env_name = ENV['APP_ENV'] || 'dev'
require "environments/#{env_name}"

# Reload the browser automatically whenever files change
configure :development do
  activate :livereload
end

page "*.xml", :layout => false
page "*.txt", :layout => false

set :site_name, 'Well-FED'
set :env_name, env_name
set :font_dir, 'fonts'
set :css_dir, 'css'
set :js_dir, 'js'
set :images_dir, 'img'

set :url_root, ApplicationConfig::BASE_URL

# This section generates the pattern-library based on data/patterns.json
patterns_prefix = 'page_patterns_'
patterns_section_class = 'patterns'

data.patterns.each do |pattern|
	proxy "/patterns/#{pattern[:page_name]}",
	"patterns/template.html",
	:locals => {
		:examples => pattern[:examples],
		:page_name => pattern[:page_name],
		:page_title => pattern[:page_title],
		:page_classes => patterns_prefix + pattern[:page_name],
		:section_class => patterns_section_class,
		:page_description => pattern[:page_description]
	},
	:ignore => true
end

activate :directory_indexes

activate :autoprefixer do |config|
  config.browsers = ['last 2 versions', 'Explorer >= 9']
  config.cascade  = false
end

# Build-specific configuration
configure :build do
  activate :gzip do |gzip|
    gzip.exts = %w(.js .css .html .htm .svg .txt .xml)
  end
  # For example, change the Compass output style for deployment
  activate :minify_css

  # Minify Javascript on build
  activate :minify_javascript
  set :js_compressor, Uglifier.new()

  # Enable cache buster
  activate :asset_hash, :ignore => [/touch-icon/, /opengraph/]

  activate :minify_html do |html|
    html.remove_http_protocol    = false
    html.remove_input_attributes = true
    html.remove_quotes           = true
    html.remove_intertag_spaces  = true
  end
end
