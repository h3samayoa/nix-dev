{ pkgs, lib, ... }: {
  name = "Terraform dev env";

  # I like using starship for my shell so this is optional more info: https://starship.rs/ 
  # you can add a starship.toml file to source from so it builds with devenv
  starship = {
    enable = true;
    config.enable = false;
  };

  #better git diffs 
  difftastic.enable = true;

  #define what packages you want in your devenv // search for them here https://search.nixos.org/packages 
  packages = with pkgs; [
    #Essential 
    curl
    git
    jq
    vim
    #Aws
    awscli2
    terraform
    kubectl
    docker
    kubernetes-helm
  ];

  #language support
  languages = { terraform.enable = true; };

  # https://devenv.sh/pre-commit-hooks/ 
  pre-commit.hooks = {
    shellcheck.enable = true;
    nixfmt.enable = true;
    yamllint.enable = true;
    terraform-format.enable = true;
    tflint.enable = true;
  };

  # Environment vars
  dotenv.enable = false; # define your env vars in a .env file
  env = { DEVENV_STACK = "terraform"; };

  # can be used to mock external attached resources 
  hosts = { };

  enterShell = ''
    printf "Terraform v%s\n" `terraform version --json | jq -r '.["terraform_version"]'` 
  '';
}
