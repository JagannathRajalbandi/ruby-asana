### WARNING: This file is auto-generated by the asana-api-meta repo. Do not
### edit it manually.

module Asana
  module Resources
    # A _project_ represents a prioritized list of tasks in Asana. It exists in a
    # single workspace or organization and is accessible to a subset of users in
    # that workspace or organization, depending on its permissions.
    #
    # Projects in organizations are shared with a single team. You cannot currently
    # change the team of a project via the API. Non-organization workspaces do not
    # have teams and so you should not specify the team of project in a
    # regular workspace.
    class Project < Resource

      include EventSubscription


      attr_reader :id

      attr_reader :archived

      attr_reader :created_at

      attr_reader :followers

      attr_reader :modified_at

      attr_reader :name

      attr_reader :color

      attr_reader :notes

      attr_reader :workspace

      attr_reader :team

      class << self
        # Returns the plural name of the resource.
        def plural_name
          'projects'
        end

        # Creates a new project in a workspace or team.
        #
        # Every project is required to be created in a specific workspace or
        # organization, and this cannot be changed once set. Note that you can use
        # the `workspace` parameter regardless of whether or not it is an
        # organization.
        #
        # If the workspace for your project _is_ an organization, you must also
        # supply a `team` to share the project with.
        #
        # Returns the full record of the newly created project.
        #
        # workspace - [Id] The workspace or organization to create the project in.
        # team - [Id] If creating in an organization, the specific team to create the
        # project in.
        #
        # options - [Hash] the request I/O options.
        # data - [Hash] the attributes to post.
        def create(client, workspace: required("workspace"), team: nil, options: {}, **data)
          with_params = data.merge(workspace: workspace, team: team).reject { |_,v| v.nil? || Array(v).empty? }
          self.new(parse(client.post("/projects", body: with_params, options: options)).first, client: client)
        end

        # If the workspace for your project _is_ an organization, you must also
        # supply a `team` to share the project with.
        #
        # Returns the full record of the newly created project.
        #
        # workspace - [Id] The workspace or organization to create the project in.
        # options - [Hash] the request I/O options.
        # data - [Hash] the attributes to post.
        def create_in_workspace(client, workspace: required("workspace"), options: {}, **data)
          with_params = data.merge(workspace: workspace).reject { |_,v| v.nil? || Array(v).empty? }
          self.new(parse(client.post("/workspaces/%s/projects", body: with_params, options: options)).first, client: client)
        end

        # Creates a project shared with the given team.
        #
        # Returns the full record of the newly created project.
        #
        # team - [Id] The team to create the project in.
        # options - [Hash] the request I/O options.
        # data - [Hash] the attributes to post.
        def create_in_team(client, team: required("team"), options: {}, **data)
          with_params = data.merge(team: team).reject { |_,v| v.nil? || Array(v).empty? }
          self.new(parse(client.post("/teams/%s/projects", body: with_params, options: options)).first, client: client)
        end

        # Returns the complete project record for a single project.
        #
        # options - [Hash] the request I/O options.
        def find_by_id(client, options: {})

          Resource.new(parse(client.get("/projects/%s", options: options)).first, client: client)
        end

        # Returns the compact project records for some filtered set of projects.
        # Use one or more of the parameters provided to filter the projects returned.
        #
        # workspace - [Id] The workspace or organization to filter projects on.
        # team - [Id] The team to filter projects on.
        # archived - [Boolean] Only return projects whose `archived` field takes on the value of
        # this parameter.
        #
        # per_page - [Integer] the number of records to fetch per page.
        # options - [Hash] the request I/O options.
        def find_all(client, workspace: nil, team: nil, archived: nil, per_page: 20, options: {})
          params = { workspace: workspace, team: team, archived: archived, limit: per_page }.reject { |_,v| v.nil? || Array(v).empty? }
          Collection.new(parse(client.get("/projects", params: params, options: options)), type: self, client: client)
        end

        # Returns the compact project records for all projects in the workspace.
        #
        # workspace - [Id] The workspace or organization to find projects in.
        # archived - [Boolean] Only return projects whose `archived` field takes on the value of
        # this parameter.
        #
        # per_page - [Integer] the number of records to fetch per page.
        # options - [Hash] the request I/O options.
        def find_by_workspace(client, workspace: required("workspace"), archived: nil, per_page: 20, options: {})
          params = { workspace: workspace, archived: archived, limit: per_page }.reject { |_,v| v.nil? || Array(v).empty? }
          Collection.new(parse(client.get("/workspaces/%s/projects", params: params, options: options)), type: self, client: client)
        end

        # Returns the compact project records for all projects in the team.
        #
        # team - [Id] The team to find projects in.
        # archived - [Boolean] Only return projects whose `archived` field takes on the value of
        # this parameter.
        #
        # per_page - [Integer] the number of records to fetch per page.
        # options - [Hash] the request I/O options.
        def find_by_team(client, team: required("team"), archived: nil, per_page: 20, options: {})
          params = { team: team, archived: archived, limit: per_page }.reject { |_,v| v.nil? || Array(v).empty? }
          Collection.new(parse(client.get("/teams/%s/projects", params: params, options: options)), type: self, client: client)
        end
      end

      # A specific, existing project can be updated by making a PUT request on the
      # URL for that project. Only the fields provided in the `data` block will be
      # updated; any unspecified fields will remain unchanged.
      #
      # When using this method, it is best to specify only those fields you wish
      # to change, or else you may overwrite changes made by another user since
      # you last retrieved the task.
      #
      # Returns the complete updated project record.
      #
      # project - [Id] The project to update.
      # options - [Hash] the request I/O options.
      # data - [Hash] the attributes to post.
      def update(project: required("project"), options: {}, **data)
        with_params = data.merge(project: project).reject { |_,v| v.nil? || Array(v).empty? }
        refresh_with(parse(client.put("/projects/%s", body: with_params, options: options)).first)
      end

      # A specific, existing project can be deleted by making a DELETE request
      # on the URL for that project.
      #
      # Returns an empty data record.
      #
      # project - [Id] The project to delete.
      def delete(project: required("project"))
        params = { project: project }.reject { |_,v| v.nil? || Array(v).empty? }
        client.delete("/projects/%s", params: params) && true
      end

      # Returns compact records for all sections in the specified project.
      #
      # per_page - [Integer] the number of records to fetch per page.
      # options - [Hash] the request I/O options.
      def sections(per_page: 20, options: {})
        params = { limit: per_page }.reject { |_,v| v.nil? || Array(v).empty? }
        Collection.new(parse(client.get("/projects/%s/sections", params: params, options: options)), type: Resource, client: client)
      end

      # Returns the compact task records for all tasks within the given project,
      # ordered by their priority within the project. Tasks can exist in more than one project at a time.
      #
      # per_page - [Integer] the number of records to fetch per page.
      # options - [Hash] the request I/O options.
      def tasks(per_page: 20, options: {})
        params = { limit: per_page }.reject { |_,v| v.nil? || Array(v).empty? }
        Collection.new(parse(client.get("/projects/%s/tasks", params: params, options: options)), type: Task, client: client)
      end

    end
  end
end
