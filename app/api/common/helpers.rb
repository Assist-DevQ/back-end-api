module Common
  module Helpers
    extend Grape::API::Helpers

    def authenticate!
      return if docs_endpoint?
    end

    private

    def docs_endpoint?
      route.origin == '/docs'
    end
  end
end
