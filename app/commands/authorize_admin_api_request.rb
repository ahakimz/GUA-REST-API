class AuthorizeAdminApiRequest
    prepend SimpleCommand

    def initialize(headers = {})
        @headers = headers
    end

    def call
        admin
    end

    private

    attr_reader :headers
    # @adminn = Admin.find(params[:id])
    # @profile = @adminn.profile.build
    # @profile = Profile.new(:user_id => @user.id)
    def admin
        @admin ||= Admin.find(decoded_auth_token[:user_id]) if decoded_auth_token
        @admin || errors.add(:token, 'Invalid token') && nil
    end

    def decoded_auth_token
        @decoded_auth_token ||= JsonWebToken.decode(http_auth_header)
    end

    def http_auth_header
        if headers['Authorization'].present?
            return headers['Authorization'].split(' ').last
        else
            errors.add(:token, 'Missing token')
        end
        nil
    end
end
