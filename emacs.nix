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
in
  pkgs.emacsWithPackages (epkgs: (with epkgs.elpaPackages; [
    exwm
    undo-tree
  ]) ++ (with epkgs.melpaPackages; [
    anaconda-mode
    avy
    bar-cursor
    better-defaults
    buttercup
    company
    company-anaconda
    company-nixos-options
    company-php
    company-quickhelp
    counsel
    counsel-projectile
    crux
    dante
    diminish
    dimmer
    direnv
    docker
    dockerfile-mode
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
    ivy
    ivy-hydra
    iy-go-to-char
    macrostep
    magit
    markdown-mode
    nix-mode
    no-littering
    org-pomodoro
    org-super-agenda
    org-tree-slide
    paredit
    php-mode
    projectile
    purescript-mode
    rainbow-delimiters
    restclient
    shackle
    (shrink-path epkgs)
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
