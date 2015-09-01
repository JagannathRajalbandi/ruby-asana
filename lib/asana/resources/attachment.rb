### WARNING: This file is auto-generated by the asana-api-meta repo. Do not
### edit it manually.

module Asana
  module Resources
    # An _attachment_ object represents any file attached to a task in Asana,
    # whether it's an uploaded file or one associated via a third-party service
    # such as Dropbox or Google Drive.
    class Attachment < Resource


      attr_reader :id

      attr_reader :created_at

      attr_reader :download_url

      attr_reader :host

      attr_reader :name

      attr_reader :parent

      attr_reader :view_url

      class << self
        # Returns the plural name of the resource.
        def plural_name
          'attachments'
        end

        # Returns the full record for a single attachment.
        #
        # options - [Hash] the request I/O options.
        def find_by_id(client, options: {})

          Resource.new(parse(client.get("/attachments/%s", options: options)).first, client: client)
        end

        # Returns the compact records for all attachments on the task.
        #
        # task - [Id] Globally unique identifier for the task.
        #
        # per_page - [Integer] the number of records to fetch per page.
        # options - [Hash] the request I/O options.
        def find_by_task(client, task: required("task"), per_page: 20, options: {})
          params = { task: task, limit: per_page }.reject { |_,v| v.nil? || Array(v).empty? }
          Collection.new(parse(client.get("/tasks/%s/attachments", params: params, options: options)), type: self, client: client)
        end
      end

    end
  end
end
