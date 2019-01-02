/*

Building and linking the result in the current directory:
$ nix-build emacs.nix
$ ./result/bin/emacs

*/
{ pkgs ? import <nixpkgs> {} }:

let
  shrink-path = epkgs: epkgs.callPackage ({ dash
                                          , emacs
                                          , f
                                          , fetchurl
                                          , lib
                                          , melpaBuild
                                          , s }:
    melpaBuild {
      pname = "shrink-path";
      ename = "shrink-path";
      version = "20170812.1947";
      src = fetchurl {
        url = "https://gitlab.com/bennya/shrink-path.el/-/archive/master/shrink-path.el-master.tar.gz";
        sha256 = "089jd59b4y0bairnzfxla9jkxxmg86i8j851g7vjb0cp3msdhjg1";
      };
      recipe = fetchurl {
        url = "https://raw.githubusercontent.com/milkypostman/melpa/86b0d105e8a57d5f0bcde779441dc80b85e170ea/recipes/shrink-path";
        sha256 = "0fq13c6g7qbq6f2ry9dzdyg1f6p41wimkjcdaj177rnilz77alzb";
        name = "recipe";
      };
      packageRequires = [ dash emacs f s ];
      meta = {
        homepage = "https://melpa.org/#/shrink-path";
        license = lib.licenses.free;
      };
    }) {};
  doom-modeline = epkgs: epkgs.callPackage ({ all-the-icons
                                            , dash
                                            , eldoc-eval
                                            , emacs
                                            , fetchFromGitHub
                                            , fetchurl
                                            , lib
                                            , melpaBuild
                                            , projectile }:
    melpaBuild {
      pname = "doom-modeline";
      ename = "doom-modeline";
      version = "20181231.0000";
      src = fetchFromGitHub {
        owner = "seagle0128";
        repo = "doom-modeline";
        rev = "3d1490d6e6c3d07e89d62f44ce87617697dfdb55";
        sha256 = "05n9g98nydgmxh9l717qc1q8w08g4p9gyk36fbzy7lwnzjlpf2ma";
      };
      recipe = fetchurl {
        url = "https://raw.githubusercontent.com/milkypostman/melpa/f4f610757f85fb01bd9b1dd212ddbea8f34f3ecd/recipes/doom-modeline";
        sha256 = "0pscrhhgk4wpz1f2r94ficgan4f9blbhqzvav1wjahwp7fn5m29j";
        name = "recipe";
      };
      packageRequires = [
        all-the-icons
        dash
        eldoc-eval
        emacs
        projectile
        (shrink-path epkgs)
      ];
      meta = {
        homepage = "https://melpa.org/#/doom-modeline";
        license = lib.licenses.free;
      };
    }) {};
in
  pkgs.emacsWithPackages (epkgs: (with epkgs.elpaPackages; [
    exwm
    undo-tree
  ]) ++ (with epkgs.melpaPackages; [
    anaconda-mode
    avy
    bar-cursor
    buttercup
    company
    company-anaconda
    company-nixos-options
    company-php
    company-quickhelp
    counsel
    counsel-projectile
    crux
    diminish
    dimmer
    docker
    dockerfile-mode
    (doom-modeline epkgs)
    emms
    expand-region
    exwm-edit
    flycheck
    git-timemachine
    gpastel
    gruvbox-theme
    helpful
    highlight-indentation
    hydra
    ibuffer-projectile
    iedit
    intero
    ivy
    ivy-hydra
    iy-go-to-char
    macrostep
    magit
    markdown-mode
    nix-mode
    no-littering
    org-bullets
    org-pomodoro
    org-tree-slide
    paredit
    php-mode
    projectile
    purescript-mode
    restclient
    shackle
    spaceline
    swiper
    use-package
    web-mode
    which-key
    yaml-mode
  ]) ++ (with epkgs.orgPackages; [
    org-plus-contrib
  ]) ++ [
    pkgs.notmuch
  ])
