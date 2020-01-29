class V1::Base < Grape::API
  version 'v1', using: :path

  dir_to_api_version_files = Rails.root.join('app', 'api', 'v1', '*')
  files = Dir[dir_to_api_version_files].reject { |a| a.eql?(__FILE__) }.select { |a| a =~ /\.rb$/ }
  files.each { |a| mount ('V1::' << File.basename(a, '.rb').camelize).constantize }

  route :any, '*path' do
    error!({ errors: { error: ['404 Not Found'] } }, 404)
  end

  add_swagger_documentation add_version: true,
                            api_version: 'v1',
                            base_path: '/api',
                            format: :json,
                            info: {
                                title: "API: v1",
                                description: "Don't worry be happy"
                            }
end
