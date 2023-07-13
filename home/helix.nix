{ lib, ... }: {
  programs.helix = {
    enable = true;
    settings = {
      theme = "cyberpunk_neon";
      editor = {
        bufferline = "multiple";
        lsp.display-messages = true;
        indent-guides.render = true;
        cursorline = true;
        cursorcolumn = true;
        color-modes = true;
        statusline = {
          left = [
            "mode"
            "spinner"
            "file-name"
            "separator"
            "file-modification-indicator"
          ];
          # center = [];
          right = [
            "diagnostics"
            "separator"
            "file-type"
            "separator"
            "selections"
            "separator"
            "position"
            "file-encoding"
          ];
          separator = "";
        };
      };
    };
    languages.language =
      let
        # Languages that just need auto-format = true
        autoFormat = map
          (name: {
            name = name;
            auto-format = true;
          }) [
          "haskell"
          "lua"
          "nix"
          "python"
        ];
        # Languages that need auto-format and indent
        fourSpaceTab = map
          (name: {
            name = name;
            auto-format = true;
            indent = {
              tab-width = 4;
              unit = "    ";
            };
          }) [
          "bash"
          "c"
          "cpp"
          "unison"
        ];
      in
      lib.concatLists [
        autoFormat
        fourSpaceTab
        [
          {
            name = "bash";
            formatter.command = "shfmt";
          }
          {
            name = "nix";
            formatter.command = "nixpkgs-fmt";
          }
          {
            name = "unison";
            scope = "scope.unison";
            injection-regex = "unison";
            file-types = [ "u" ];
            shebangs = [ ];
            roots = [ ];
            comment-token = "--";
            language-server = {
              command = "netcat";
              args = [ "localhost" "5757" ];
            };
          }
        ]
      ];
    themes = {
      cyberpunk_neon = {
        attribute = "pink";
        keyword = { fg = "pink"; modifiers = [ "bold" ]; };
        "keyword.directive" = { fg = "pink"; modifiers = [ "bold" ]; }; # -- preprocessor comments (#if in C)
        namespace = "pink";
        punctuation = "purple";
        #"punctuation.delimiter" = "lavender";
        operator = "pink";
        special = "orange";
        "variable.other.member" = "cyan";
        variable = "cyan";
        # variable = "almond" # TODO: metavariables only
        # "variable.parameter" = { fg = "lavender", modifiers = ["underlined"] }
        "variable.parameter" = { fg = "cyan"; };
        "variable.builtin" = "cyan";
        type = "cyan";
        "type.builtin" = { fg = "pink"; modifiers = [ "bold" ]; }; # TODO: distinguish?
        constructor = "pink";
        function = "pink";
        "function.macro" = "orange";
        "function.builtin" = { fg = "cyan"; modifiers = [ "bold" ]; };
        tag = "cyan";
        comment = "light-blue";
        constant = "orange";
        "constant.builtin" = "orange";
        string = "orange";
        "constant.numeric" = "orange";
        "constant.character.escape" = "orange";
        # used for lifetimes
        label = "orange";

        "markup.heading" = "pink";
        "markup.bold" = { modifiers = [ "bold" ]; };
        "markup.italic" = { modifiers = [ "italic" ]; };
        "markup.link.url" = { fg = "pink"; modifiers = [ "underlined" ]; };
        "markup.link.text" = "orange";
        "markup.raw" = "cyan";

        "diff.plus" = "green";
        "diff.minus" = "red";
        "diff.delta" = "purple";

        # TODO: diferentiate doc comment
        # concat (ERROR) @error.syntax and "MISSING ;" selectors for errors

        "ui.background" = { bg = "dark-blue"; };
        "ui.background.separator" = { fg = "light-blue"; };
        "ui.linenr" = { fg = "cyan"; };
        "ui.linenr.selected" = { fg = "cyan"; bg = "semi-dark-blue"; modifiers = [ "bold" ]; };
        "ui.statusline" = { fg = "cyan"; bg = "blue"; };
        "ui.statusline.inactive" = { fg = "purple"; bg = "dark-blue"; };
        "ui.statusline.separator" = { fg = "cyan"; };
        "ui.statusline.select" = { fg = "dark-blue"; bg = "purple"; };
        "ui.statusline.insert" = { fg = "dark-blue"; bg = "pink"; };
        "ui.popup" = { fg = "pink"; bg = "blue"; };
        "ui.window" = { fg = "pink"; bg = "dark-blue"; };
        "ui.help" = { fg = "white"; bg = "light-blue"; };

        "ui.text" = { fg = "cyan"; };
        "ui.text.focus" = { fg = "pink"; };
        "ui.text.inactive" = "purple";
        "ui.virtual" = { fg = "light-blue"; };

        "ui.virtual.indent-guide" = { fg = "light-blue"; };

        "ui.selection" = { fg = "white"; bg = "trans-blue"; modifiers = [ "bold" ]; };
        "ui.selection.primary" = { fg = "white"; bg = "trans-purple"; modifiers = [ "bold" ]; };
        # TODO: namespace ui.cursor as ui.selection.cursor?
        "ui.cursor.select" = { fg = "dark-blue"; bg = "white"; };
        "ui.cursor.insert" = { fg = "dark-blue"; bg = "cyan"; };
        "ui.cursor.match" = { fg = "dark-blue"; bg = "purple"; };
        "ui.cursor" = { modifiers = [ "bold" "reversed" ]; };
        "ui.cursorline.primary" = { bg = "semi-dark-blue"; modifiers = [ "bold" ]; };
        "ui.highlight" = { fg = "dark-blue"; bg = "pink"; };

        "ui.menu" = { fg = "cyan"; bg = "dark-blue"; };
        "ui.menu.selected" = { fg = "cyan"; bg = "trans-purple"; modifiers = [ "bold" ]; };
        "ui.menu.scroll" = { fg = "light-blue"; bg = "dark-blue"; };

        "diagnostic.hint" = { underline = { color = "pink"; style = "curl"; }; };
        "diagnostic.info" = { underline = { color = "pink"; style = "curl"; }; };
        "diagnostic.warning" = { underline = { color = "yellow"; style = "curl"; }; };
        "diagnostic.error" = { underline = { color = "red"; style = "curl"; }; };

        warning = { fg = "yellow"; modifiers = [ "bold" ]; };
        error = { fg = "red"; modifiers = [ "bold" ]; };
        info = { fg = "pink"; modifiers = [ "bold" ]; };
        hint = "pink";

        palette = {
          dark-blue = "#000b1e";
          semi-dark-blue = "#09254b";
          blue = "#091833";
          light-blue = "#133e7c";
          trans-blue = "#0b2956";
          cyan = "#0abdc6";
          pink = "#ea00d9";
          purple = "#711c91";
          trans-purple = "#321959";
          red = "#ff0000";
          orange = "#f57800";
          white = "#d7d7d5";
          yellow = "#ffff00";
          green = "#00ff00";
        };
      };
    };
  };
}
