require File.expand_path(File.dirname(__FILE__) + "/test_helper")

class SprocketsHelperTest < ActionView::TestCase
  tests Sprockets::Rails::Helpers::AssetTagHelper
  include Sprockets::Rails::TestHelpers

  def setup
    Rails.application.config.action_controller.perform_caching = true
    # create images
    asset_file("images/logo.png")

    # create javascript files
    asset_file("javascripts/application.js")
    asset_file("javascripts/dir/xmlhr.js")
    asset_file("javascripts/extra.js")
    asset_file("javascripts/xmlhr.js")

    # create stylesheets
    asset_file("stylesheets/application.css")
    asset_file("stylesheets/dir/style.css")
    asset_file("stylesheets/style.css")
    asset_file("stylesheets/extra.css")
  end

  def url_for(*args)
    "http://www.example.com"
  end

  test "asset path" do
    assert_equal "/assets/logo-d41d8cd98f00b204e9800998ecf8427e.png",
      asset_path("logo.png")

    assert_equal "/images/logo",
      asset_path("/images/logo")
    assert_equal "/images/logo.gif",
      asset_path("/images/logo.gif")

    assert_equal "/dir/audio",
      asset_path("/dir/audio")

    assert_equal "http://www.example.com/video/play",
      asset_path("http://www.example.com/video/play")
    assert_equal "http://www.example.com/video/play.mp4",
      asset_path("http://www.example.com/video/play.mp4")
  end

  test "asset path with relavtive url root" do
    @controller.config.relative_url_root = "/collaboration/hieraki"
    assert_equal "/collaboration/hieraki/images/logo.gif",
     asset_path("/images/logo.gif")
  end

  test "javascript path" do
    assert_equal "/assets/application-89aa68ab245a2f74086f3b0ce57540fa.js",
      asset_path(:application, "js")

    assert_equal "/assets/xmlhr-d41d8cd98f00b204e9800998ecf8427e.js",
      asset_path("xmlhr", "js")
    assert_equal "/assets/dir/xmlhr-d41d8cd98f00b204e9800998ecf8427e.js",
      asset_path("dir/xmlhr.js", "js")

    assert_equal "/dir/xmlhr.js",
      asset_path("/dir/xmlhr", "js")

    assert_equal "http://www.example.com/js/xmlhr",
      asset_path("http://www.example.com/js/xmlhr", "js")
    assert_equal "http://www.example.com/js/xmlhr.js",
      asset_path("http://www.example.com/js/xmlhr.js", "js")
  end

  test "javascript include tag" do
    assert_equal '<script src="/assets/application-89aa68ab245a2f74086f3b0ce57540fa.js" type="text/javascript"></script>',
      javascript_include_tag(:application)

    assert_equal '<script src="/assets/xmlhr-d41d8cd98f00b204e9800998ecf8427e.js" type="text/javascript"></script>',
      javascript_include_tag("xmlhr")
    assert_equal '<script src="/assets/xmlhr-d41d8cd98f00b204e9800998ecf8427e.js" type="text/javascript"></script>',
      javascript_include_tag("xmlhr.js")
    assert_equal '<script src="http://www.example.com/xmlhr" type="text/javascript"></script>',
      javascript_include_tag("http://www.example.com/xmlhr")

    assert_equal "<script src=\"/assets/demo-89aa68ab245a2f74086f3b0ce57540fa.js?body=1\" type=\"text/javascript\"></script>\n<script src=\"/assets/dir/xmlhr-d41d8cd98f00b204e9800998ecf8427e.js?body=1\" type=\"text/javascript\"></script>\n<script src=\"/assets/extra-d41d8cd98f00b204e9800998ecf8427e.js?body=1\" type=\"text/javascript\"></script>\n<script src=\"/assets/omg-f635a55b29904e04e4106d169de7312f.js?body=1\" type=\"text/javascript\"></script>\n<script src=\"/assets/xmlhr-d41d8cd98f00b204e9800998ecf8427e.js?body=1\" type=\"text/javascript\"></script>\n<script src=\"/assets/application-89aa68ab245a2f74086f3b0ce57540fa.js?body=1\" type=\"text/javascript\"></script>",
      javascript_include_tag(:application, :debug => true)

    assert_equal  "<script src=\"/assets/xmlhr-d41d8cd98f00b204e9800998ecf8427e.js\" type=\"text/javascript\"></script>\n<script src=\"/assets/extra-d41d8cd98f00b204e9800998ecf8427e.js\" type=\"text/javascript\"></script>",
      javascript_include_tag("xmlhr", "extra")
  end

  test "stylesheet path" do
    assert_equal "/assets/application-7ea558a750731502bda5d079e5aab069.css", asset_path(:application, "css")

    assert_equal "/assets/style-d41d8cd98f00b204e9800998ecf8427e.css", asset_path("style", "css")
    assert_equal "/assets/dir/style-d41d8cd98f00b204e9800998ecf8427e.css", asset_path("dir/style.css", "css")
    assert_equal "/dir/style.css", asset_path("/dir/style.css", "css")

    assert_equal "http://www.example.com/css/style",
      asset_path("http://www.example.com/css/style", "css")
    assert_equal "http://www.example.com/css/style.css",
      asset_path("http://www.example.com/css/style.css", "css")
  end

  test "stylesheet link tag" do
    assert_equal '<link href="/assets/application-7ea558a750731502bda5d079e5aab069.css" media="screen" rel="stylesheet" type="text/css" />',
      stylesheet_link_tag(:application)

    assert_equal '<link href="/assets/style-d41d8cd98f00b204e9800998ecf8427e.css" media="screen" rel="stylesheet" type="text/css" />',
      stylesheet_link_tag("style")
    assert_equal '<link href="/assets/style-d41d8cd98f00b204e9800998ecf8427e.css" media="screen" rel="stylesheet" type="text/css" />',
      stylesheet_link_tag("style.css")

    assert_equal '<link href="http://www.example.com/style.css" media="screen" rel="stylesheet" type="text/css" />',
      stylesheet_link_tag("http://www.example.com/style.css")
    assert_equal '<link href="/assets/style-d41d8cd98f00b204e9800998ecf8427e.css" media="all" rel="stylesheet" type="text/css" />',
      stylesheet_link_tag("style", :media => "all")
    assert_equal '<link href="/assets/style-d41d8cd98f00b204e9800998ecf8427e.css" media="print" rel="stylesheet" type="text/css" />',
      stylesheet_link_tag("style", :media => "print")

    assert_equal "<link href=\"/assets/demo-89aa68ab245a2f74086f3b0ce57540fa.js?body=1\" media=\"screen\" rel=\"stylesheet\" type=\"text/css\" />\n<link href=\"/assets/dir/xmlhr-d41d8cd98f00b204e9800998ecf8427e.js?body=1\" media=\"screen\" rel=\"stylesheet\" type=\"text/css\" />\n<link href=\"/assets/extra-d41d8cd98f00b204e9800998ecf8427e.js?body=1\" media=\"screen\" rel=\"stylesheet\" type=\"text/css\" />\n<link href=\"/assets/omg-f635a55b29904e04e4106d169de7312f.js?body=1\" media=\"screen\" rel=\"stylesheet\" type=\"text/css\" />\n<link href=\"/assets/xmlhr-d41d8cd98f00b204e9800998ecf8427e.js?body=1\" media=\"screen\" rel=\"stylesheet\" type=\"text/css\" />\n<link href=\"/assets/application-7ea558a750731502bda5d079e5aab069.css?body=1\" media=\"screen\" rel=\"stylesheet\" type=\"text/css\" />",
      stylesheet_link_tag(:application, :debug => true)

    assert_equal "<link href=\"/assets/style-d41d8cd98f00b204e9800998ecf8427e.css\" media=\"screen\" rel=\"stylesheet\" type=\"text/css\" />\n<link href=\"/assets/extra-d41d8cd98f00b204e9800998ecf8427e.css\" media=\"screen\" rel=\"stylesheet\" type=\"text/css\" />",
      stylesheet_link_tag("style", "extra")
  end
end
