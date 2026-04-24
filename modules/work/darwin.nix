{ ... }:

{
  homebrew = {
    taps = [
      { name = "atlassian/homebrew-acli"; }
    ];
    brews = [
      "acli"
    ];
    casks = [
      "aws-vpn-client"
      "cursor-cli"
      "royal-tsx"
    ];
  };
}
