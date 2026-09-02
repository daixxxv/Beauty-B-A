require "aws-sdk-s3" rescue nil

if defined?(Aws)
  Aws.config[:request_checksum_calculation] = "when_required"
  Aws.config[:response_checksum_validation] = "when_required"
end
