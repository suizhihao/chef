#
# Author:: Jesse Campbell (<hikeit@gmail.com>)
# Copyright:: Copyright (c) 2013 Jesse Campbell
# License:: Apache License, Version 2.0
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

require 'uri'
require 'tempfile'
require 'chef/provider/remote_file'
require 'chef/provider/remote_file/result'

class Chef
  class Provider
    class RemoteFile
      class LocalFile

        attr_reader :uri
        attr_reader :new_resource

        def initialize(uri, new_resource, current_resource)
          @new_resource = new_resource
          @uri = uri
        end

        # Fetches the file at uri, returning a Tempfile-like File handle
        def fetch
          tempfile = Chef::FileContentManagement::Tempfile.new(new_resource).tempfile
          Chef::Log.debug("#{new_resource} staging #{uri.path} to #{tempfile.path}")
          FileUtils.cp(uri.path, tempfile.path)
          Chef::Provider::RemoteFile::Result.new(tempfile, nil, nil)
        end

      end
    end
  end
end