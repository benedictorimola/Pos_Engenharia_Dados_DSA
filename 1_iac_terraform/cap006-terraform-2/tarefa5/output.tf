output "instance_ids" {
    value = module.bamr_ec2_instances.instance_ids
}

output "bucket_id" {
    value = module.bamr_s3_bucket.bucket_id
  
}