Aws.config.update({
  region: 'us-east-1',
  credentials: Aws::Credentials.new('AKIAIVBOAW6RHIESZXWQ', 'qaX1Dpm8gg6lKzf41raR8G5DFMpP+mO7QasJDn1t'),
})

S3_BUCKET =  Aws::S3.new.buckets[ENV['S3_BUCKET']]