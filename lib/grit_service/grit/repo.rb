module Grit
  class Repo
    def self.initialize_repo(path, options)
      GritService.bertrpc.call.repo.initialize_repo(path, options)
    end

    def initialize(path, options = {})
      repo_options = self.class.initialize_repo(path, options)

      @bare = repo_options[:bare]
      self.path = repo_options[:path]
      self.working_dir = repo_options[:working_dir]

      self.git = Git.new(self.path)
    end
  end # Repo
end # Grit
