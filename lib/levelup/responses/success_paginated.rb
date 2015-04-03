module Levelup
  module Responses
    # Class that encapsulates a successful response from a paginated endpoint of the LevelUp API.
    class SuccessPaginated < Success
      attr_writer :next_page_request, :next_page

      def next_page?
        !next_page_request.nil? && !next_page.nil?
      end

      def next
        unless next_page?
          raise Errors::InvalidRequest, 'Attempted to fetch next page at '\
            'final page of list'
        end

        next_page_request.send_to_api(:get, next_page)
      end

      private

      attr_reader :next_page_request, :next_page
    end
  end
end
