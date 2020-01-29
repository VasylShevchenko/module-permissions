class V1::Access < Grape::API
  namespace :access do

  desc 'Write to a file'
  params do
    requires :token, type: String, allow_blank: false
  end
  get 'write-file' do
    permissions :write_to_a_file, 'You can not write to a file'

    status :ok
    { result: 'write to a file ...' }
  end

  desc 'Reboot the server'
  params do
    requires :token, type: String, allow_blank: false
  end
  get 'reboot-server' do
    permissions :reboot_the_server, 'You can not reboot the server'

    status :ok
    { result: 'start reboot the server' }
  end

  desc 'Download file'
  params do
    requires :token, type: String, allow_blank: false
  end
  get 'download-file' do
    permissions :download_file, 'You can not download file'

    status :ok
    { result: 'download file...' }
  end

  end
end
