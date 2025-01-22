{ pkgs, ... }:
{
  home = {
    # GNU less is required for the --quit-if-one-screen option to work properly.
    packages = [ pkgs.less ];

    sessionVariables = {
      LESS = "--quit-if-one-screen --hilite-search --hilite-unread --ignore-case --LONG-PROMPT --RAW-CONTROL-CHARS --chop-long-lines --window=-4";
    };
  };
}
