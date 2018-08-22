CarrierWave.configure do |config|
    config.fog_provider = 'fog/aws'
    config.fog_credentials = {
        provider: 'AWS',
        aws_access_key_id: ENV['ACCESS_KEY_ID'],
        aws_secret_access_key: ENV['SECRET_ACCESS_KEY'],
        region: 'ap-northeast-1'#リージョンをUS以外にしたかたはそのリージョンに変更
    }

    config.cache_storage = :fog
    case Rails.env
    when 'development'
        config.fog_directory  = 'tamtim'
        config.asset_host = 'https://s3-ap-northeast-1.amazonaws.com/tamtim'
    when 'production'
        config.fog_directory  = 'tamtim'
        config.asset_host = 'https://s3-ap-northeast-1.amazonaws.com/tamtim'
    end
end
