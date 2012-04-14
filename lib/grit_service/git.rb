require 'grit'
require 'bertrpc'

module Grit
  class Git
    def self.bertrpc(host = 'localhost', port = 9999)
      @bertrpc ||= BERTRPC::Service.new(host, port)
    end

    def self.repo(git_dir)
      @repos ||= {}
      @repos[git_dir] ||= Grit::Git.new(git_dir)
    end

    def self.service_methods
      @service_methods ||= []
    end

    def self.service(method)
      service_methods += [method]
      define_method(method) do |*args|
        bertrpc.call.send(:method, *([self.git_dir, args].flatten))
      end
    end

    def bertrpc
      self.class.bertrpc
    end

    service :exist?
    service :put_raw_object
    service :get_raw_object
    service :get_git_object
    service :object_exists?
    service :select_existing_objects
    service :fs_exist?
    service :fs_read
    service :fs_write
    service :fs_delete
    service :fs_move
    service :fs_mkdir
    service :fs_chmod
    service :list_remotes
    service :create_tempfile
    service :commit_from_sha
    service :check_applies
    service :get_patch
    service :apply_patch

    def native(cmd, options = {}, *args, &block)
      bert.call.send(cmd, options, *args)
    end
  end # Git
end # Grit
