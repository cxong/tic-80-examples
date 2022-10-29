module ExamplePlugin
  class ExamplePageGenerator < Jekyll::Generator
    safe true

    def generate(site)
      examples = site.static_files.select{|file| file.start_with?("/examples/")}.map{|file| file.split('/')[2]}.uniq()
      examples.each do |example|
        site.pages << ExamplePage.new(site, example)
      end
    end
  end

  # Subclass of `Jekyll::Page` with custom method definitions.
  class ExamplePage < Jekyll::Page
    def initialize(site, example)
      @site = site             # the current site instance.
      @base = site.source      # path to the source directory.
      @example = example       # the name of the example.

      # All pages have the same filename, so define attributes straight away.
      @basename = 'example'    # filename without the extension.
      @ext      = '.html'      # the extension.
      @name     = 'index.html' # basically @basename + @ext.
    end

    # Placeholders that are used in constructing page URL.
    def url_placeholders
      {
        :example    => @example,
        :basename   => basename,
        :output_ext => output_ext,
      }
    end
  end
end
