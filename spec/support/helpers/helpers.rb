module Helpers

  def create_firebase_userid_token(user: nil)
    JWT.encode payload.merge({ sub: user }),
               OpenSSL::PKey::RSA.new(FirebaseIdToken::Testing::Certificates.private_key), 'RS256'
  end

  private

  def payload # rubocop:disable Metrics/MethodLength
    {
      iss: "https://securetoken.google.com/#{Rails.application.credentials.firebase.id}",
      name: 'Ugly Bob',
      picture: 'https://someurl.com/photo.jpg',
      aud: Rails.application.credentials.firebase.id.to_s,
      auth_time: 1_492_981_192,
      user_id: 'theUserID',
      sub: 'theUserID',
      iat: 1_492_981_200,
      exp: 33_029_000_017,
      email: 'uglybob@emailurl.com',
      email_verified: true,
      firebase: {
        identities: {
          'google.com': [
            '1010101010101010101'
          ],
          email: [
            'uglybob@emailurl.com'
          ]
        },
        sign_in_provider: 'google.com'
      }
    }
  end

end
