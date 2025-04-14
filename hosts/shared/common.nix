# 💫 https://github.com/JaKooLit 💫 #
# Packages and Fonts config including the "programs" options
{
  self,
  pkgs,
  inputs,
  system,
  ...
}: {
  nixpkgs.config.allowUnfree = true;

  environment.systemPackages =
    (with pkgs; [
      # System Packages
      bat
      bc
      curl
      cpufrequtils
      duf
      dust
      fd
      ffmpeg
      glow
      git
      kanata
      killall
      libnotify
      ripgrep
      starship
      tree
      vim
      wget
      zoxide

      fastfetch
      #ranger

      btop
      jq
      unzip
      xarchiver
    ])
    ++ [
      self.packages."${system}".my-neovim
    ];

  # FONTS
  fonts.packages = with pkgs; [
    noto-fonts
    fira-code
    terminus_font
    (nerdfonts.override {fonts = ["JetBrainsMono"];}) # stable banch
    (nerdfonts.override {fonts = ["DaddyTimeMono"];}) # stable banch
  ];

  programs.git.enable = true;

  services.kanata = {
    enable = true;
    keyboards = {
      internalKeyboard = {
        devices = [
          "/dev/input/event1"
          "/dev/input/event4"
        ];
        extraDefCfg = "process-unmapped-keys yes";
        config = ''
          (deflocalkeys-linux
            conf 171
          )
          (defsrc
             caps esc a s d f j k l ;
            conf
          )
          (defvar
             tap-time 149
             hold-time 150
             long-tap-time 200
             long-hold-time 200
          )

          (defalias
             escctrl (tap-hold 200 200 esc lctl)
             a (tap-hold $long-tap-time $long-hold-time a lalt)
             s (tap-hold $tap-time $long-hold-time s lmet)
             d (tap-hold $tap-time $hold-time d lsft)
             f (tap-hold $tap-time $hold-time f lctl)
             j (tap-hold $tap-time $hold-time j rctl)
             k (tap-hold $tap-time $hold-time k rsft)
             l (tap-hold $tap-time $hold-time l rmet)
             ; (tap-hold $long-tap-time $long-hold-time ; ralt)
             base (layer-switch base)
             game (layer-switch game)
             cec (layer-switch cec)
          )

          (deflayer base
             @escctrl caps @a @s @d @f @j @k @l @;
             @game
          )
          (deflayer game
             @escctrl caps a s d f @j @k @l @;
             @cec
          )
          (deflayermap cec
             caps @escctrl
             esc caps
             conf @base
          )
        '';
      };
    };
  };
}
