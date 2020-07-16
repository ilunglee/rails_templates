module Controller

  module Macros

    def login_resource(resource, *args)
      before do
        @request.env['devise.mapping'] = Devise.mappings[resource]
        user = FactoryBot.create(resource, *args)
        sign_in user
      end
    end

  end

end
