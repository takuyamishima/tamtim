if Rails.env.production?
  CarrierWave.configure do |config|
    config.fog_credentials = {
        provider: 'AWS',
        aws_access_key_id: ENV['ACCESS_KEY_ID'] || 'dummy',
        aws_secret_access_key: ENV['SECRET_ACCESS_KEY'] || 'dummy',
        region: 'ap-northeast-1'#リージョンをUS以外にしたかたはそのリージョンに変更
    }
    config.cache_storage = :fog
    config.fog_directory  = 'tamtim'
    config.asset_host = 'https://s3-ap-northeast-1.amazonaws.com/tamtim'
    config.fog_attributes = { cache_control: "public, max-age=#{365.days.to_i}" }
  end
end
