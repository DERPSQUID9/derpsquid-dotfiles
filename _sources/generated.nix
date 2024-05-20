# This file was generated by nvfetcher, please do not modify it manually.
{ fetchgit, fetchurl, fetchFromGitHub, dockerTools }:
{
  catppuccin-fuzzel = {
    pname = "catppuccin-fuzzel";
    version = "eeb4c8d159187ef7eb59a4a99baec67c2e797e9f";
    src = fetchFromGitHub {
      owner = "catppuccin";
      repo = "fuzzel";
      rev = "eeb4c8d159187ef7eb59a4a99baec67c2e797e9f";
      fetchSubmodules = false;
      sha256 = "sha256-yJvhc4ovgdxEdqFDxWNOkHJHTBF9UaCefetgCGhoG0A=";
    };
    date = "2024-01-24";
  };
  catppuccin-prismlauncher = {
    pname = "catppuccin-prismlauncher";
    version = "07e9c3ca0ff8eb7da9fa8b5329a9d2ceec707f24";
    src = fetchFromGitHub {
      owner = "catppuccin";
      repo = "prismlauncher";
      rev = "07e9c3ca0ff8eb7da9fa8b5329a9d2ceec707f24";
      fetchSubmodules = false;
      sha256 = "sha256-/qUqF92e3kYkl59GUMMFRtRTzVgSp5tGPxnXLGeusys=";
    };
    date = "2024-03-30";
  };
  catppuccin-wallpapers = {
    pname = "catppuccin-wallpapers";
    version = "1023077979591cdeca76aae94e0359da1707a60e";
    src = fetchFromGitHub {
      owner = "zhichaoh";
      repo = "catppuccin-wallpapers";
      rev = "1023077979591cdeca76aae94e0359da1707a60e";
      fetchSubmodules = false;
      sha256 = "sha256-h+cFlTXvUVJPRMpk32jYVDDhHu1daWSezFcvhJqDpmU=";
    };
    date = "2022-08-24";
  };
  context-switch-xplr = {
    pname = "context-switch-xplr";
    version = "85ac284b33144540741f48a5a42d3366d00acae9";
    src = fetchFromGitHub {
      owner = "igorepst";
      repo = "context-switch.xplr";
      rev = "85ac284b33144540741f48a5a42d3366d00acae9";
      fetchSubmodules = false;
      sha256 = "sha256-ryVvZIMBkG7FpJVpEj0SfibWFDEEsvA8089ptErlqwg=";
    };
    date = "2023-12-28";
  };
  demeter = {
    pname = "demeter";
    version = "0.1.0";
    src = fetchurl {
      url = "https://nyxt.atlas.engineer/static/release/demeter.tar.gz";
      sha256 = "sha256-XjgI0F2QVwV2KSH+7eO3G1lX/NZ6hXPYztCIlXdnOJc=";
    };
  };
  dragon-xplr = {
    pname = "dragon-xplr";
    version = "5fbddcb33f7d75a5abd12d27223ac55589863335";
    src = fetchFromGitHub {
      owner = "sayanarijit";
      repo = "dragon.xplr";
      rev = "5fbddcb33f7d75a5abd12d27223ac55589863335";
      fetchSubmodules = false;
      sha256 = "sha256-FJbyu5kK78XiTJl0NNXcI0KPOdXOPwpbBCWPUEpu5zA=";
    };
    date = "2023-01-11";
  };
  dua-cli-xplr = {
    pname = "dua-cli-xplr";
    version = "66ccf983fab7f67d6b00adc0365a2b26550e7f81";
    src = fetchFromGitHub {
      owner = "sayanarijit";
      repo = "dua-cli.xplr";
      rev = "66ccf983fab7f67d6b00adc0365a2b26550e7f81";
      fetchSubmodules = false;
      sha256 = "sha256-XDhXaS8GuY3fuiSEL0WcLFilZ72emmjTVi07kv5c8n8=";
    };
    date = "2022-01-19";
  };
  extra-icons-xplr = {
    pname = "extra-icons-xplr";
    version = "1f27b9a74c23b869fe64d12f3d8c2a1207ff8eb7";
    src = fetchFromGitHub {
      owner = "dtomvan";
      repo = "extra-icons.xplr";
      rev = "1f27b9a74c23b869fe64d12f3d8c2a1207ff8eb7";
      fetchSubmodules = false;
      sha256 = "sha256-9xDK960CSqdHdKKczH5ULpS0s/2KYwl+NgvQCt6FLCs=";
    };
    date = "2023-06-01";
  };
  fish-bd = {
    pname = "fish-bd";
    version = "ab686e028bfe95fa561a4f4e57840e36902d4d7d";
    src = fetchFromGitHub {
      owner = "0rax";
      repo = "fish-bd";
      rev = "ab686e028bfe95fa561a4f4e57840e36902d4d7d";
      fetchSubmodules = false;
      sha256 = "sha256-GeWjoakXa0t2TsMC/wpLEmsSVGhHFhBVK3v9eyQdzv0=";
    };
    date = "2022-03-04";
  };
  fzf-xplr = {
    pname = "fzf-xplr";
    version = "c8991f92946a7c8177d7f82ed939d845746ebaf5";
    src = fetchFromGitHub {
      owner = "sayanarijit";
      repo = "fzf.xplr";
      rev = "c8991f92946a7c8177d7f82ed939d845746ebaf5";
      fetchSubmodules = false;
      sha256 = "sha256-dpnta67p3fYEO3/GdvFlqzdyiMaJ9WbsnNmoIRHweMI=";
    };
    date = "2023-09-04";
  };
  icons-xplr = {
    pname = "icons-xplr";
    version = "2d04b5ba3a9c5c6c886f5f3f1d8facde6e6e7612";
    src = fetchFromGitHub {
      owner = "jbms";
      repo = "icons.xplr";
      rev = "2d04b5ba3a9c5c6c886f5f3f1d8facde6e6e7612";
      fetchSubmodules = false;
      sha256 = "sha256-KUX7SJqYElpmYtbzyqyPB7rfBXlaBsj8yyRJ7Swn0hE=";
    };
    date = "2023-06-19";
  };
  nx-dark-reader = {
    pname = "nx-dark-reader";
    version = "57dc1a9482a81d7c15b00c4b9d647bf1b129d8e4";
    src = fetchFromGitHub {
      owner = "aartaka";
      repo = "nx-dark-reader";
      rev = "57dc1a9482a81d7c15b00c4b9d647bf1b129d8e4";
      fetchSubmodules = false;
      sha256 = "sha256-CKJGCk7ATd0naFhill5rrvay6V2JE4Bstu4tFpaAjB0=";
    };
    date = "2023-06-20";
  };
  nx-fruit = {
    pname = "nx-fruit";
    version = "161856d20bccec729a43767bd926aca2e651f100";
    src = fetchFromGitHub {
      owner = "atlas-engineer";
      repo = "nx-fruit";
      rev = "161856d20bccec729a43767bd926aca2e651f100";
      fetchSubmodules = false;
      sha256 = "sha256-mLZ/1LagwsdTj/qOxqTOu3OP6pwByO0ITfwxi547qeg=";
    };
    date = "2024-01-03";
  };
  nx-router = {
    pname = "nx-router";
    version = "0.2.0";
    src = fetchgit {
      url = "https://git.migalmoreno.com/nx-router";
      rev = "0.2.0";
      fetchSubmodules = false;
      deepClone = true;
      leaveDotGit = true;
      sha256 = "sha256-H4v90ujqZJaigEodz5d8fr1qKcbIyxzN9sUiy9qkwbA=";
    };
  };
  nx-search-engines = {
    pname = "nx-search-engines";
    version = "f81f47df82f8e322f0a8919d05fc513297095a0b";
    src = fetchFromGitHub {
      owner = "aartaka";
      repo = "nx-search-engines";
      rev = "f81f47df82f8e322f0a8919d05fc513297095a0b";
      fetchSubmodules = false;
      sha256 = "sha256-Q+6B3lDzlhfHnS306yLh5LpxdIXESdH/Y2D3GJodbXs=";
    };
    date = "2023-06-07";
  };
  offline-docs-xplr = {
    pname = "offline-docs-xplr";
    version = "cba060b5a009696fe1b2ccbdd73d7ba2e2d7b51d";
    src = fetchFromGitHub {
      owner = "sayanarijit";
      repo = "offline-docs.xplr";
      rev = "cba060b5a009696fe1b2ccbdd73d7ba2e2d7b51d";
      fetchSubmodules = false;
      sha256 = "sha256-+ilunEbnPpP8NEhfNlr8rK7fwQhyTHFhsFZnI85TkXk=";
    };
    date = "2024-02-10";
  };
  ouch-xplr = {
    pname = "ouch-xplr";
    version = "375edf19ff3e0286bd7a101b9e4dd24fa5abaeb8";
    src = fetchFromGitHub {
      owner = "dtomvan";
      repo = "ouch.xplr";
      rev = "375edf19ff3e0286bd7a101b9e4dd24fa5abaeb8";
      fetchSubmodules = false;
      sha256 = "sha256-YGFQKzIYIlL+UW2Nel2Tw7WC3MESaVbWYlpj5o2FfLs=";
    };
    date = "2022-01-23";
  };
  plugin-sudope = {
    pname = "plugin-sudope";
    version = "83919a692bc1194aa322f3627c859fecace5f496";
    src = fetchFromGitHub {
      owner = "oh-my-fish";
      repo = "plugin-sudope";
      rev = "83919a692bc1194aa322f3627c859fecace5f496";
      fetchSubmodules = false;
      sha256 = "sha256-pD4rNuqg6TG22L9m8425CO2iqcYm8JaAEXIVa0H/v/U=";
    };
    date = "2021-04-11";
  };
  roblox-oof = {
    pname = "roblox-oof";
    version = "latest";
    src = fetchurl {
      url = "https://archive.org/download/savetheoof/ouch.ogg";
      sha256 = "sha256-vcxbfljNxTFS+uFxrV/zKdDWWBBYN2hJIwkN5MN8AH0=";
    };
  };
  scp-xplr = {
    pname = "scp-xplr";
    version = "578bfd6bd379b113ce63bb0f73658eef2594c817";
    src = fetchFromGitHub {
      owner = "sayanarijit";
      repo = "scp.xplr";
      rev = "578bfd6bd379b113ce63bb0f73658eef2594c817";
      fetchSubmodules = false;
      sha256 = "sha256-E/a1JQX7cKOWpPcEFvew3LDLTCyHwXfbTNDtNw2WiXY=";
    };
    date = "2024-02-10";
  };
  style-xplr = {
    pname = "style-xplr";
    version = "e1fbd803e8a1dc4a6a1460816b485fb06412e6b8";
    src = fetchFromGitHub {
      owner = "emsquid";
      repo = "style.xplr";
      rev = "e1fbd803e8a1dc4a6a1460816b485fb06412e6b8";
      fetchSubmodules = false;
      sha256 = "sha256-eP0+xA3qtbAUJaqBxdY1qDhnCF/tY3MAaq1fZd4SLmA=";
    };
    date = "2023-01-09";
  };
  tri-pane-xplr = {
    pname = "tri-pane-xplr";
    version = "d90c65eb2bdd182f09db2db8969a99666f90c78b";
    src = fetchFromGitHub {
      owner = "sayanarijit";
      repo = "tri-pane.xplr";
      rev = "d90c65eb2bdd182f09db2db8969a99666f90c78b";
      fetchSubmodules = false;
      sha256 = "sha256-repzWTUYZirpBwQ+SEe1Gp1EFMHGG5VONSRS00c995c=";
    };
    date = "2023-07-05";
  };
  type-to-nav-xplr = {
    pname = "type-to-nav-xplr";
    version = "de817bd19c56b7cbb1c39c05e4412b7f188b548c";
    src = fetchFromGitHub {
      owner = "sayanarijit";
      repo = "type-to-nav.xplr";
      rev = "de817bd19c56b7cbb1c39c05e4412b7f188b548c";
      fetchSubmodules = false;
      sha256 = "sha256-BBIGX0gLJeX3F0wn22IGUr/qzlL4ryh0RjsZURJ1xq4=";
    };
    date = "2022-01-19";
  };
  wallpaper = {
    pname = "wallpaper";
    version = "latest";
    src = fetchurl {
      url = "https://64.media.tumblr.com/c5543874b9cbe98da1d20945a45e989b/tumblr_o5a5r9Z9O71tvppquo1_r1_1280.gifv";
      sha256 = "sha256-iU65D6V/VQFELwF8V10jwQk8T8xowjRs8eERzn3B7YA=";
    };
  };
  wl-clipboard-xplr = {
    pname = "wl-clipboard-xplr";
    version = "a3ffc87460c5c7f560bffea689487ae14b36d9c3";
    src = fetchFromGitHub {
      owner = "sayanarijit";
      repo = "wl-clipboard.xplr";
      rev = "a3ffc87460c5c7f560bffea689487ae14b36d9c3";
      fetchSubmodules = false;
      sha256 = "sha256-I4rh5Zks9hiXozBiPDuRdHwW5I7ppzEpQNtirY0Lcks=";
    };
    date = "2023-01-11";
  };
  you-should-use = {
    pname = "you-should-use";
    version = "a332823512c0b51e71516ebb8341db0528c87926";
    src = fetchFromGitHub {
      owner = "paysonwallach";
      repo = "fish-you-should-use";
      rev = "a332823512c0b51e71516ebb8341db0528c87926";
      fetchSubmodules = false;
      sha256 = "sha256-MmGDFTgxEFgHdX95OjH3jKsVG1hdwo6bRht+Lvvqe5Y=";
    };
    date = "2022-02-13";
  };
  zoxide-xplr = {
    pname = "zoxide-xplr";
    version = "e50fd35db5c05e750a74c8f54761922464c1ad5f";
    src = fetchFromGitHub {
      owner = "sayanarijit";
      repo = "zoxide.xplr";
      rev = "e50fd35db5c05e750a74c8f54761922464c1ad5f";
      fetchSubmodules = false;
      sha256 = "sha256-ZiOupn9Vq/czXI3JHvXUlAvAFdXrwoO3NqjjiCZXRnY=";
    };
    date = "2023-01-11";
  };
}
