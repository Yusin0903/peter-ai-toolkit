aws configure set aws_access_key_id     "$AWS_ACCESS_KEY_ID"     --profile tmp-investigate
aws configure set aws_secret_access_key "$AWS_SECRET_ACCESS_KEY" --profile tmp-investigate
aws configure set aws_session_token     "$AWS_SESSION_TOKEN"     --profile tmp-investigate
aws configure set region us-east-1                                --profile tmp-investigate

export AWS_PROFILE=tmp-investigate
echo "Profile activated: tmp-investigate"
