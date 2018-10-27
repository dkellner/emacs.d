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
      version = "0.20";
      src = fetchurl {
        url = "https://elpa.gnu.org/packages/exwm-0.20.tar";
        sha256 = "0nhhzbkm0mkj7sd1dy2c19cmn56gyaj9nl8kgy86h4fp63hjaz04";
      };
      packageRequires = [ (xelb epkgs) ];
      meta = {
        homepage = "https://elpa.gnu.org/packages/exwm.html";
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
    emms
    exwm-edit
    flycheck
    git-timemachine
    gpastel
    gruvbox-theme
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
