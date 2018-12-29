/*

Building and linking the result in the current directory:
$ nix-build emacs.nix
$ ./result/bin/emacs

*/
{ pkgs ? import <nixpkgs> {} }:

let
  xelb = epkgs: epkgs.callPackage ({ cl-generic, elpaBuild, emacs, fetchurl, lib }:
    elpaBuild {
      pname = "xelb";
      ename = "xelb";
      version = "0.16";
      src = fetchurl {
        url = "https://elpa.gnu.org/packages/xelb-0.16.tar";
        sha256 = "03wsr1jr7f7zfd80h864rd4makwh4widdnj1kjv2xyjwdgap9rl8";
      };
      packageRequires = [ cl-generic emacs ];
      meta = {
        homepage = "https://elpa.gnu.org/packages/xelb.html";
        license = lib.licenses.free;
      };
    }) {};
  exwm = epkgs: epkgs.callPackage ({ elpaBuild, fetchurl, lib }:
    elpaBuild {
      pname = "exwm";
      ename = "exwm";
      version = "0.21";
      src = fetchurl {
        url = "https://elpa.gnu.org/packages/exwm-0.21.tar";
        sha256 = "07ng1pgsnc3isfsyzh2gfc7391p9il8lb5xqf1z6yqn20w7k6xzj";
      };
      packageRequires = [ (xelb epkgs) ];
      meta = {
        homepage = "https://elpa.gnu.org/packages/exwm.html";
        license = lib.licenses.free;
      };
    }) {};
  shrink-path = epkgs: epkgs.callPackage ({ dash
                                          , emacs
                                          , f
                                          , fetchFromGitLab
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
      version = "20181204.0530";
      src = fetchFromGitHub {
        owner = "seagle0128";
        repo = "doom-modeline";
        rev = "2e65c9d06b30cef156f7e74b773e67b487af9b24";
        sha256 = "1g9vhslgagkdwccwcac5xlpc1n4bi5806fdrc6yy6wmdmij5q7ji";
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
    (exwm epkgs)
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
