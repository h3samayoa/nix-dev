# nix-dev

Nix Dev Environments

## Table of contents

 * [Prerequisites](#prerequisites)
 * [Usage](#usage)
 * [nix-direnv](#nix-direnv)
 * [Troubleshooting](#troubleshooting)

## Prerequisites

 * install nix: https://nixos.org/download/ 

 * <details>
    <summary>Add nix-flakes</summary>
      <p>&emsp;Check if your nix.conf file is in <code>/etc/nix</code> or <code>~/.config/nix</code> then run the following: </p>
      &emsp;<pre><code>echo 'experimental-features = nix-command flakes' >> /etc/nix/nix.conf</code></pre> <br>
      &emsp;<pre><code>echo 'experimental-features = nix-command flakes' >> ~/.config/nix/nix.conf</code></pre>

  * bash version 4.4+

## Usage

For manual usage run <pre><code>NIXPKGS_ALLOW_UNFREE=1 nix develop --impure .</code></pre>

If you define more than one shell use: 

<pre><code>NIXPKGS_ALLOW_UNFREE=1 nix develop --impure .#shellName</code></pre>

If you want to omit the allow unfree tag export it as an Environment Variable **this step is needed for direnv**<pre><code>export NIXPKGS_ALLOW_UNFREE=1</code></pre>

## nix-direnv

To change shells automatically we need to use [direnv](https://github.com/nix-community/nix-direnv) 

Its already preinstalled in the ```.envrc``` file just run ```direnv allow``` 

## Troubleshooting

List of tools used and links to their docs: 

used [nix-systems](https://github.com/nix-systems/nix-systems) to resolve system deps 

You can also use with [flake-parts](https://devenv.sh/guides/using-with-flake-parts/) in our ```flake.nix``` this would require more extensive configuring with [devenv](https://devenv.sh/getting-started/)

**Make sure everything is added to git or nix can't find the file**