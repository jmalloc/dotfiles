{ ... }:
{
  programs.starship = {
    enable = true;

    settings = {
      aws = {
        disabled = true;
      };

      direnv = {
        disabled = false;
      };

      git_commit = {
        tag_disabled = false;
      };

      golang = {
        disabled = true;
      };

      kubernetes = {
        disabled = false;
      };

      custom.git_wip = {
        require_repo = true;
        symbol = "🚧 WORK IN PROGRESS ";
        style = "red";
        when = "grep WIP <(git log -n 1 --pretty=%B)";
      };
    };
  };
}
