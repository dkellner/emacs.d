/*

Building and linking the result in the current directory:
$ nix build -f emacs.nix
$ ./result/bin/emacs

*/
{ pkgs ? import <nixpkgs> {} }:

let
  xelb = epkgs: epkgs.callPackage ({ cl-generic, elpaBuild, emacs, fetchurl, lib }:
    elpaBuild {
      pname = "xelb";
      ename = "xelb";
      version = "0.18";
      src = fetchurl {
        url = "https://elpa.gnu.org/packages/xelb-0.18.tar";
        sha256 = "1fp5mzl63sh0h3ws4l5p4qgvi7ny8a3fj6k4dhqa98xgw2bx03v7";
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
      version = "0.23";
      src = fetchurl {
        url = "https://elpa.gnu.org/packages/exwm-0.23.tar";
        sha256 = "05w1v3wrp1lzz20zd9lcvr5nhk809kgy6svvkbs15xhnr6x55ad5";
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
    all-the-icons
    anaconda-mode
    avy
    bar-cursor
    better-defaults
    buttercup
    cargo
    company
    company-anaconda
    company-lsp
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
    flycheck-rust
    git-timemachine
    gpastel
    gruvbox-theme
    helpful
    highlight-indentation
    hydra
    ibuffer-projectile
    iedit
    ivy
    ivy-posframe
    iy-go-to-char
    lsp-mode
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
    rust-mode
    shackle
    shrink-path
    swiper
    toml-mode
    use-package
    web-mode
    which-key
    yaml-mode
    yasnippet
    yasnippet-snippets
  ]) ++ (with epkgs.orgPackages; [
    org-plus-contrib
  ]) ++ [
    pkgs.notmuch
  ])
