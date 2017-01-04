module Feedjira
  module Parser
    # Parser for dealing with Atypon feeds.
    class RSSAtypon
      include SAXMachine
      include FeedUtilities
      element :"rss:title", as: :title
      element :"rss:description", as: :description
      element :"rss:link", as: :url
      elements :"rss:item", as: :entries, class: RSSAtyponEntry

      attr_accessor :feed_url

      def self.able_to_parse?(xml) #:nodoc:
        (/\<rdf\:RDF/ =~ xml) && (/\<rss\:channel/ =~ xml)
      end
    end
  end
end
