module Grit
  class Git
    def self.service(method)
      define_method(method) do |*args|
        GritService.bertrpc.call.git.send(method, *([self.git_dir, args].flatten))
      end
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
      GritService.bertrpc.call.git.native(self.git_dir, cmd, options, *args)
    end
  end # Git
end # Grit
