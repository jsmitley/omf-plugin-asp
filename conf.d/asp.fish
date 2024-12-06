function __fish_print_aws_profiles -d 'Prints a list of AWS profiles' -a select
  set -q AWS_CONFIG_FILE; or set AWS_CONFIG_FILE "$HOME/.aws/config"
  if test -f "$AWS_CONFIG_FILE"
    set profiles (command sed -n 's/^\[profile \(.*\)\]/\1/p' "$AWS_CONFIG_FILE")
  end

  set -q AWS_SHARED_CREDENTIALS_FILE; or set AWS_SHARED_CREDENTIALS_FILE "$HOME/.aws/credentials"
  if test -f "$AWS_SHARED_CREDENTIALS_FILE"
    set credentials_profiles (command sed -n 's/^\[\(.*\)\]/\1/p' "$AWS_SHARED_CREDENTIALS_FILE")
  end

  for profile in $credentials_profiles
    if not contains $profile $profiles
      set -a profiles $profile
    end
  end

  string join \n $profiles
end
