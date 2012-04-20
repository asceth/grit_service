require 'rubygems'
require 'ernie'
require 'grit'

module GritService
  module Service
    module Repo
      extend GritService::Helpers

      def initialize_path(path, options)
        repo_options = {}
        epath = File.expand_path(path)

        if File.exist?(File.join(epath, '.git'))
          repo_options[:working_dir] = epath
          repo_options[:path] = File.join(epath, '.git')
          repo_options[:bare] = false
        elsif File.exist?(epath) && (epath =~ /\.git$/ || options[:is_bare])
          repo_options[:path] = epath
          repo_options[:bare] = true
        elsif File.exist?(epath)
          raise Grit::InvalidGitRepositoryError.new(epath)
        else
          raise Grit::NoSuchPathError.new(epath)
        end

        repo_options
      end
    end
  end
end

Ernie.expose(:git, GritService::Service::Repo)
