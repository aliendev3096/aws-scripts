touch metadata.txt
curl -w "\n" http://169.254.169.254/latest/meta-data/public-hostname >> metadata.txt
curl -w "\n" http://169.254.169.254/latest/meta-data/iam/info >> metadata.txt
curl -w "\n" http://169.254.169.254/latest/meta-data/security-groups >> metadata.txt
