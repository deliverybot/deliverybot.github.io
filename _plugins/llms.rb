# frozen_string_literal: true

# Publishes the docs in a form that is easy for LLMs and AI assistants to read
# (see https://llmstxt.org):
#
# - a Markdown copy of every docs page next to its HTML, e.g.
#   /docs/quickstart.md for /docs/quickstart/
# - /llms-full.txt, all of those copies in one file
# - site.data.llms_docs, the list of copies that /llms.txt links to
module Deliverybot
  class LlmsGenerator < Jekyll::Generator
    priority :lowest

    # Reading order: overview first, then setup, reference, guide and the rest.
    ORDER = %w[
      /docs/how-it-works/
      /docs/quickstart/
      /docs/configuration/
      /docs/guide/
      /docs/integrations/
      /docs/deploying/
    ].freeze

    def generate(site)
      docs = site.pages.select { |page| doc?(page) }.sort_by { |page| sort_key(page) }

      copies = docs.map do |page|
        markdown_url = page.url.chomp("/") + ".md"
        page.data["markdown_url"] = markdown_url
        copy = Jekyll::PageWithoutAFile.new(site, site.source, "", "#{page.basename}.txt")
        copy.content = plain_markdown(page)
        copy.data.merge!("layout" => nil, "permalink" => markdown_url, "sitemap" => false)
        copy
      end
      site.pages.concat(copies)

      site.data["llms_docs"] = docs.map do |page|
        {
          "title" => page.data["title"],
          "description" => page.data["description"],
          "url" => page.data["markdown_url"],
          "group" => page.data["group"]
        }
      end

      full = Jekyll::PageWithoutAFile.new(site, site.source, "", "llms-full.txt")
      full.content = docs.map do |page|
        "<!-- Source: #{site.config["url"]}#{page.url} -->\n\n#{plain_markdown(page).strip}\n"
      end.join("\n")
      full.data.merge!("layout" => nil, "sitemap" => false)
      site.pages << full
    end

    private

    # Kramdown attribute lists such as {:target="_blank"} mean nothing outside
    # the HTML build.
    def plain_markdown(page)
      page.content.gsub(/\{:[^}\n]*\}/, "")
    end

    def doc?(page)
      page.url.start_with?("/docs/") && page.ext == ".md"
    end

    def sort_key(page)
      section = ORDER.index { |prefix| page.url.start_with?(prefix) } || ORDER.size
      # Index pages first, then numbered guide steps in numeric order.
      index = page.url == ORDER[section] ? 0 : 1
      step = page.basename[/\A\d+/].to_i
      [section, index, step, page.url]
    end
  end
end
